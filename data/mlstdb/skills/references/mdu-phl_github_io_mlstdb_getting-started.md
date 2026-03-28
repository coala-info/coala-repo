[ ]
[ ]

[Skip to content](#getting-started)

mlstdb

Getting Started

Initializing search

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](..)
* [Installation](../installation/)
* [Getting Started](./)
* [Usage](../usage/overview/)
* [Disclaimer](../disclaimer/)
* [Changelog](../changelog/)

mlstdb

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](..)
* [Installation](../installation/)
* [ ]

  Getting Started

  [Getting Started](./)

  Table of contents
  + [Step 1: Install mlstdb](#step-1-install-mlstdb)
  + [Step 2: Register with the databases](#step-2-register-with-the-databases)

    - [Connect to PubMLST](#connect-to-pubmlst)
    - [Connect to Pasteur](#connect-to-pasteur)
  + [Step 3: Download MLST schemes](#step-3-download-mlst-schemes)
  + [Step 4: Verify with mlst](#step-4-verify-with-mlst)
  + [What was created?](#what-was-created)
  + [Keeping your database up to date](#keeping-your-database-up-to-date)
  + [Next Steps](#next-steps)
* [ ]

  Usage

  Usage
  + [Overview](../usage/overview/)
  + [Connect](../usage/connect/)
  + [Update](../usage/update/)
  + [Purge](../usage/purge/)
  + [Fetch (Advanced)](../usage/fetch/)
* [Disclaimer](../disclaimer/)
* [Changelog](../changelog/)

Table of contents

* [Step 1: Install mlstdb](#step-1-install-mlstdb)
* [Step 2: Register with the databases](#step-2-register-with-the-databases)

  + [Connect to PubMLST](#connect-to-pubmlst)
  + [Connect to Pasteur](#connect-to-pasteur)
* [Step 3: Download MLST schemes](#step-3-download-mlst-schemes)
* [Step 4: Verify with mlst](#step-4-verify-with-mlst)
* [What was created?](#what-was-created)
* [Keeping your database up to date](#keeping-your-database-up-to-date)
* [Next Steps](#next-steps)

# Getting Started

This guide walks you through the complete setup — from installation to running `mlst` with your freshly updated database.

---

## Step 1: Install mlstdb

```
conda create -n mlst -c bioconda mlst
conda activate mlst
pip install mlstdb
```

Verify the installation:

```
mlstdb --version
```

---

## Step 2: Register with the databases

Before downloading any schemes, you need to register your OAuth credentials with PubMLST and/or Pasteur. This is a **one-time setup** — your credentials are saved locally and reused for future updates.

### Connect to PubMLST

```
mlstdb connect --db pubmlst
```

### Connect to Pasteur

```
mlstdb connect --db pasteur
```

Each `connect` command will:

1. Ask for your **Client ID** (24 characters) and **Client Secret** (42 characters)
2. Open an authorisation URL — visit it in your browser
3. Ask you to paste the **verification code** from the website
4. Save all tokens securely to `~/.config/mlstdb/`

Where do I get my Client ID and Client Secret?

See the [Connect guide](../usage/connect/#obtaining-client-credentials) for step-by-step instructions on registering with PubMLST and Pasteur.

Info

If you've already connected before, `mlstdb connect` will test your existing credentials and skip re-registration if they're still valid.

---

## Step 3: Download MLST schemes

```
mlstdb update
```

This will:

* Read the built-in curated list of ~170 MLST schemes from both PubMLST and Pasteur
* Download allele sequences (`.tfa` files) and ST profiles (`.txt` files) for each scheme
* Save everything to a `pubmlst/` directory
* Build a BLAST database in `blast/`

First run may take a while

Downloading hundreds of schemes involves many API calls. You can speed things up with `--threads 4` or download specific schemes by providing a custom input file. See the [Update guide](../usage/update/) for details.

If the download is interrupted, use `--resume` to pick up where you left off:

```
mlstdb update --resume
```

---

## Step 4: Verify with mlst

Once the update is complete, test your new database:

```
mlst --blastdb blast/mlst.fa --datadir pubmlst your_assembly.fasta
```

Replace `your_assembly.fasta` with the path to any bacterial genome assembly.

---

## What was created?

After a successful update, your directory should look like this:

```
pubmlst/
├── klebsiella/
│   ├── klebsiella.txt          # ST profiles
│   ├── klebsiella_info.json    # Scheme metadata
│   ├── database_version.txt    # Database version number
│   ├── gapA.tfa                # Allele sequences
│   ├── infB.tfa
│   └── ...
├── listeria/
│   └── ...
└── ...

blast/
├── mlst.fa                     # Combined allele sequences
├── mlst.fa.ndb                 # BLAST index files
├── mlst.fa.nhr
└── ...
```

Each scheme gets its own subdirectory containing:

* **Profile file** (`<scheme>.txt`) — maps ST numbers to allele combinations
* **Allele files** (`<locus>.tfa`) — FASTA sequences for each locus
* **Metadata** (`<scheme>_info.json`) — source database, download date, locus count

---

## Keeping your database up to date

Schemes change over time as new STs and alleles are added. To update your database, simply run:

```
mlstdb update
```

This will re-download all schemes and rebuild the BLAST database. Use `--resume` if you want to skip schemes that have already been downloaded.

---

## Next Steps

* [Connect — Registration details](../usage/connect/) — How to obtain OAuth credentials
* [Update — All options](../usage/update/) — Custom inputs, parallel downloads, resume
* [Fetch — Advanced](../usage/fetch/) — Explore all available schemes with custom filters
* [Disclaimer](../disclaimer/) — Important safety notes

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)