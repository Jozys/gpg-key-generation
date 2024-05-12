# Generate your GPG-key via one script

This script will generate a GPG-key for you. You need to provide your name, email and comment.
During the process you will be asked for a passphrase. This passphrase is used to protect your private key.
This script can be executed on Linux, macOS and Windows (inside the WSL).

## Requirements

You need to have `gpg` installed on your system and the script needs to be executable.

To make the script executable run the following command:

```bash
chmod +x generate.sh
```

## Usage

```bash
./generate.sh <name> <email> <comment>
```

## Example

```bash
./generate.sh "John Doe" "john@doe.com" "My GPG-key"
```

The script will generate a GPG-key with the following properties:

- Name: John Doe
- Email: john@doe.com
- Comment: My GPG-key
- Key type: RSA
- Key length: 4096
- Expiration: 3m (3 months)

It will save a key.txt file with the public key. This key should be entered in your GitHub account, inside the GPG and SSH keys settings as new GPG key.

In the future I will add the possibility to add the key directly to your GitHub account using the comment as identifier.
