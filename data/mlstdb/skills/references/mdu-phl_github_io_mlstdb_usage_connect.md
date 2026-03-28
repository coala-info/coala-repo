[ ]
[ ]

[Skip to content](#connect)

mlstdb

Connect

Initializing search

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [Getting Started](../../getting-started/)
* [Usage](../overview/)
* [Disclaimer](../../disclaimer/)
* [Changelog](../../changelog/)

mlstdb

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [Getting Started](../../getting-started/)
* [x]

  Usage

  Usage
  + [Overview](../overview/)
  + [ ]

    Connect

    [Connect](./)

    Table of contents
    - [Basic Usage](#basic-usage)
    - [Options](#options)
    - [Obtaining Client Credentials](#obtaining-client-credentials)

      * [PubMLST](#pubmlst)
      * [Pasteur (BIGSdb)](#pasteur-bigsdb)
    - [What happens during connect](#what-happens-during-connect)
    - [Re-connecting](#re-connecting)
  + [Update](../update/)
  + [Purge](../purge/)
  + [Fetch (Advanced)](../fetch/)
* [Disclaimer](../../disclaimer/)
* [Changelog](../../changelog/)

Table of contents

* [Basic Usage](#basic-usage)
* [Options](#options)
* [Obtaining Client Credentials](#obtaining-client-credentials)

  + [PubMLST](#pubmlst)
  + [Pasteur (BIGSdb)](#pasteur-bigsdb)
* [What happens during connect](#what-happens-during-connect)
* [Re-connecting](#re-connecting)

# Connect

The `connect` command registers your OAuth credentials with PubMLST or Pasteur databases. This is a **one-time setup** per database, credentials are saved locally and reused automatically.

---

## Basic Usage

```
mlstdb connect --db pubmlst
mlstdb connect --db pasteur
```

If you omit `--db`, you'll be prompted to choose.

---

## Options

| Option | Description |
| --- | --- |
| `--db`, `-d` | Database to connect to: `pubmlst` or `pasteur` |
| `--verbose`, `-v` | Show detailed debug output |
| `-h`, `--help` | Show help message |

---

## Obtaining Client Credentials

Before running `mlstdb connect`, you need to register as an API client on each database platform to get your **Client ID** and **Client Secret**.

### PubMLST

1. Go to <https://pubmlst.org/bigsdb>
2. Create an account or log in
3. Under the "Database registrations" section, select "check all" the databases you want access to. You may register for just the ones you need, but you might not be able to access schemes from databases you haven't registered for. You will get an warning while running `mlstdb update` if you haven't registered for a scheme's database.
4. Make sure you register to (e.g., *Neisseria* → `pubmlst_neisseria_seqdef`) as `mlstdb` uses this for connecting to the API and downloading schemes.
5. Go to **API keys** section and create a new API key for MLST database access.
6. Copy the **Client ID** (24 characters) and **Client Secret** (42 characters)

### Pasteur (BIGSdb)

1. Go to <https://bigsdb.pasteur.fr/cgi-bin/bigsdb/bigsdb.pl>
2. Same as for PubMLST, create an account or log in and register for all the databases you want access to.
3. You will need to email the Pasteur team to request API access and get your Client ID and Client Secret.
4. Use the **Client ID** and **Client Secret** for `mlstdb connect --db pasteur`

Tip

You only need to register your client credentials **once** per platform. The same credentials work across all databases within that platform.

Register with individual databases

While the client credentials are platform-wide, you may need to **register/enrol** within specific databases on each platform to access their schemes. If you get authentication errors during `mlstdb update`, check that you've registered with the relevant databases.

---

## What happens during connect

When you run `mlstdb connect`, the following OAuth flow occurs:

1. **You provide** your Client ID and Client Secret
2. **mlstdb** requests a temporary token from the API
3. **A URL is displayed** — open it in your browser
4. **Authorise** the application on the website
5. **Enter the verification code** shown on the website back into the terminal
6. **mlstdb** exchanges this for access and session tokens
7. **Credentials are saved** to `~/.config/mlstdb/`

```
~/.config/mlstdb/
├── client_credentials    # Your Client ID and Secret
├── access_tokens         # OAuth access tokens
└── session_tokens        # Session tokens (used for API calls)
```

Security

All credential files are stored with restrictive permissions (`0700`). They are only readable by your user account.

---

## Re-connecting

If your credentials expire or become invalid, `mlstdb connect` will detect this:

```
mlstdb connect --db pubmlst
# Output: ✓ Credentials found for pubmlst
# Output: ✗ Connection test failed for pubmlst
# Prompt: Do you want to re-register with pubmlst?
```

Answer **yes** to go through the registration flow again.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)