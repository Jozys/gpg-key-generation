# This script should generate a new GPG key pair, save it to git and push the public key to GitHub

# Get the parameters from the script execution
# $1: The email address to use for the key
# $2: The name to use for the key
# $3: The comment to use for the key

# Check if the parameters are set
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$3" ]; then
	echo "Usage: $0 <email> <name> <comment>"
	exit 1
fi

# Print the parameters
echo "Email: $1"
echo "Name: $2"
echo "Comment: $3"

# Check if GPG_TTY is set in .bashrc
if ! grep -q "GPG_TTY" ~/.bashrc; then
	echo "GPG_TTY is not set in .bashrc. Now adding the following line to .bashrc:"
	echo "export GPG_TTY=\$(tty)"
	[ -f ~/.bashrc ] && echo -e '\nexport GPG_TTY=$(tty)' >> ~/.bashrc
	exit 1
fi


# Generate a 4096-bit RSA key pair with the given parameters.
# The user needs to enter a passphrase for the key.
gpg --batch --generate-key <<EOF
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Name-Real: $2
Name-Email: $1
Expire-Date: 3m
Name-Comment: $3
EOF

# Get the key ID of the generated key by its comment
KEY_IDS=$(gpg --list-secret-keys --keyid-format LONG | grep -E "^sec" | awk '{print $2}' | cut -d'/' -f2)
 
# Convert the key IDs to an array
KEY_IDS=($KEY_IDS)

# Choose the last key of the array
KEY_ID=${KEY_IDS[${#KEY_IDS[@]}-1]}

# Export the public key to a file named key.txt
echo "Exporting the public key to key.txt. Please make sure to copy the content of this file to GitHub"
gpg --armor --export $KEY_ID > key.txt

# Add the keyid to the git configuration
echo "Adding the key ID to the git configuration"
echo "Please make sure, that you have entered the same email address in the git configuration as you used for the key generation"

git config --global user.signingkey $KEY_ID

# Enable GPG signing for commits
echo "Enabling GPG signing for commits"
git config --global commit.gpgsign true


