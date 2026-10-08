# grzctl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| grzctl_archive | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_clean | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_consent | PASS |  |
| grzctl_decrypt | PASS |  |
| grzctl_download | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_encrypt | PASS |  |
| grzctl_list | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_pruefbericht_generate_from-metadata | PASS |  |
| grzctl_pruefbericht_generate_from-submission-dir | PASS |  |
| grzctl_pruefbericht_submit | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_submit | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_upload | Not completed | needs an account and S3 or web servers of the German genome data center |
| grzctl_validate | PASS |  |

## grzctl_validate

### Tool Description
Validate the submission.

  This validates the submission by checking its checksums, as well
  as performing basic sanity checks on the supplied metadata. Must be executed
  before calling `encrypt` and `upload`.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-05
- **GitHub**: https://github.com/BfArM-MVH/grz-tools
- **Stars**: N/A
### Original Help Text
```text
Usage: grzctl validate [OPTIONS]

  Validate the submission.

  This validates the submission by checking its checksums, as well as
  performing basic sanity checks on the supplied metadata. Must be executed
  before calling `encrypt` and `upload`.

Options:
  --submission-dir PATH  Path to the submission directory containing
                         'metadata/', 'files/', 'encrypted_files/' and 'logs/'
                         directories  [required]
  --config-file STRING   Path to config file
  --force / --no-force   Overwrite files and ignore cached results
                         (dangerous!)
  --threads INTEGER      Number of threads to use for parallel operations
                         [default: 4]
  --help                 Show this message and exit.
```

## grzctl_encrypt

### Tool Description
Encrypt a submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl encrypt [OPTIONS]

  Encrypt a submission.

  Encryption is done with the recipient's public key. Sub-folders
  'encrypted_files' and 'logs' are created within the submission directory.

Options:
  --submission-dir PATH           Path to the submission directory containing
                                  'metadata/', 'files/', 'encrypted_files/'
                                  and 'logs/' directories  [required]
  --config-file STRING            Path to config file
  --force / --no-force            Overwrite files and ignore cached results
                                  (dangerous!)
  --check-validation-logs / --no-check-validation-logs
                                  Check validation logs before encrypting.
  --help                          Show this message and exit.
```

## grzctl_submit

### Tool Description
Validate, encrypt, and then upload.

  This is a convenience command that performs the following steps in order: 1.
  Validate the submission 2. Encrypt the submission 3. Upload the encrypted
  submission

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl submit [OPTIONS]

  Validate, encrypt, and then upload.

  This is a convenience command that performs the following steps in order: 1.
  Validate the submission 2. Encrypt the submission 3. Upload the encrypted
  submission

Options:
  --submission-dir PATH  Path to the submission directory containing
                         'metadata/', 'files/', 'encrypted_files/' and 'logs/'
                         directories  [required]
  --config-file STRING   Path to config file
  --threads INTEGER      Number of threads to use for parallel operations
                         [default: 4]
  --force / --no-force   Overwrite files and ignore cached results
                         (dangerous!)
  --help                 Show this message and exit.
```

## grzctl_list

### Tool Description
List resources managed by grzctl

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/docopt.py:165: SyntaxWarning: invalid escape sequence '\S'
  name = re.findall('(<\S*?>)', source)[0]
/usr/local/lib/python3.13/site-packages/docopt.py:166: SyntaxWarning: invalid escape sequence '\['
  value = re.findall('\[default: (.*)\]', source, flags=re.I)
/usr/local/lib/python3.13/site-packages/docopt.py:207: SyntaxWarning: invalid escape sequence '\['
  matched = re.findall('\[default: (.*)\]', description, flags=re.I)
/usr/local/lib/python3.13/site-packages/docopt.py:456: SyntaxWarning: invalid escape sequence '\S'
  split = re.split('\n *(<\S+?>|-\S+?)', doc)[1:]
Usage: grzctl list [OPTIONS]
Try 'grzctl list --help' for help.

Error: Invalid value for '--config-file': File '/root/.config/grz-cli/config.yaml' does not exist.
```

## grzctl_download

### Tool Description
Download a submission from a GRZ.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl download [OPTIONS]

  Download a submission from a GRZ.

  Downloaded metadata is stored within the `metadata` sub-folder of the
  submission output directory. Downloaded files are stored within the
  `encrypted_files` sub-folder of the submission output directory.

Options:
  --submission-id STRING  S3 submission ID  [required]
  --output-dir PATH       Path to the target submission output directory
                          [required]
  --config-file STRING    Path to config file
  --threads INTEGER       Number of threads to use for parallel operations
                          [default: 4]
  --force / --no-force    Overwrite files and ignore cached results
                          (dangerous!)
  --help                  Show this message and exit.
```

## grzctl_consent

### Tool Description
Check if a submission is consented for research.

  Returns 'true' if consented, 'false' if not. A submission is considered
  consented if all donors have consented for research, that is the FHIR MII IG
  Consent profiles all have a "permit" provision for code
  2.16.840.1.113883.3.1937.777.24.5.3.8

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl consent [OPTIONS]

  Check if a submission is consented for research.

  Returns 'true' if consented, 'false' if not. A submission is considered
  consented if all donors have consented for research, that is the FHIR MII IG
  Consent profiles all have a "permit" provision for code
  2.16.840.1.113883.3.1937.777.24.5.3.8

Options:
  --submission-dir PATH  Path to the submission directory containing
                         'metadata/', 'files/', 'encrypted_files/' and 'logs/'
                         directories  [required]
  --json                 Output JSON for machine-readability.
  --details              Show more detailed output.
  --date TEXT            date for which to check consent validity in ISO
                         format (default: today)
  --help                 Show this message and exit.
```

## grzctl_decrypt

### Tool Description
Decrypt a submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl decrypt [OPTIONS]

  Decrypt a submission.

  Decrypting a submission requires the _private_ key of the original
  recipient.

Options:
  --submission-dir PATH  Path to the submission directory containing
                         'metadata/', 'files/', 'encrypted_files/' and 'logs/'
                         directories  [required]
  --config-file STRING   Path to config file
  --force / --no-force   Overwrite files and ignore cached results
                         (dangerous!)
  --help                 Show this message and exit.
```

## grzctl_upload

### Tool Description
Upload a submission to a GRZ/GDC.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl upload [OPTIONS]

  Upload a submission to a GRZ/GDC.

Options:
  --submission-dir PATH  Path to the submission directory containing
                         'metadata/', 'files/', 'encrypted_files/' and 'logs/'
                         directories  [required]
  --config-file STRING   Path to config file
  --threads INTEGER      Number of threads to use for parallel operations
                         [default: 4]
  --help                 Show this message and exit.
```

## grzctl_archive

### Tool Description
Archive a submission within a GRZ/GDC.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl archive [OPTIONS]

  Archive a submission within a GRZ/GDC.

Options:
  --submission-dir PATH  Path to the submission directory containing
                         'metadata/', 'files/', 'encrypted_files/' and 'logs/'
                         directories  [required]
  --config-file STRING   Path to config file
  --threads INTEGER      Number of threads to use for parallel operations
                         [default: 4]
  --help                 Show this message and exit.
```

## grzctl_clean

### Tool Description
Remove all files of a submission from the S3 inbox.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl clean [OPTIONS]

  Remove all files of a submission from the S3 inbox.

Options:
  --submission-id STRING  S3 submission ID  [required]
  --config-file STRING    Path to config file
  --yes-i-really-mean-it
  --help                  Show this message and exit.
```

## grzctl_pruefbericht_submit

### Tool Description
Submit a Prüfbericht JSON to BfArM.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl pruefbericht submit [OPTIONS]

  Submit a Prüfbericht JSON to BfArM.

Options:
  --pruefbericht-file PATH  Path to pruefbericht file  [required]
  --config-file STRING      Path to config file
  --token TEXT              Access token to try instead of requesting a new
                            one.
  --print-token             Print obtained access token to stdout.
  --allow-redacted-tan-g    Allow submission of a Prüfbericht with a redacted
                            TAN.
  --help                    Show this message and exit.
```

## grzctl_pruefbericht_generate_from-metadata

### Tool Description
Generate Prüfbericht from metadata.json

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl pruefbericht generate from-metadata [OPTIONS] METADATA_FILE

  Generate Prüfbericht from metadata.json

Options:
  --fail / --pass  Fail an otherwise valid submission (e.g. failed internal
                   QC)
  --help           Show this message and exit.
```

## grzctl_pruefbericht_generate_from-submission-dir

### Tool Description
Generate Prüfbericht from submission directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grzctl pruefbericht generate from-submission-dir [OPTIONS] PATH

  Generate Prüfbericht from submission directory.

  This is equivalent to `from-metadata
  ${submission_dir}/metadata/metadata.json`.

Options:
  --fail / --pass  Fail an otherwise valid submission (e.g. failed internal
                   QC)
  --help           Show this message and exit.
```

## Metadata
- **Skill**: not generated
