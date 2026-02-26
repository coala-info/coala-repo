# grzctl CWL Generation Report

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


## grzctl_upload

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



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
Usage: grzctl upload [OPTIONS]
Try 'grzctl upload --help' for help.

Error: No such option: --h Did you mean --help?
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


## grzctl_decrypt

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



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
Usage: grzctl decrypt [OPTIONS]
Try 'grzctl decrypt --help' for help.

Error: No such option: --h Did you mean --help?
```


## grzctl_archive

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



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
Usage: grzctl archive [OPTIONS]
Try 'grzctl archive --help' for help.

Error: No such option: --h Did you mean --help?
```


## grzctl_clean

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grzctl/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



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
Usage: grzctl clean [OPTIONS]
Try 'grzctl clean --help' for help.

Error: No such option: --h Did you mean --help?
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


## grzctl_pruefbericht

### Tool Description
Generate and submit Prüfberichte.

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
Usage: grzctl pruefbericht [OPTIONS] COMMAND [ARGS]...

  Generate and submit Prüfberichte.

Options:
  --help  Show this message and exit.

Commands:
  generate  Generate a Prüfbericht JSON from submission metadata.
  submit    Submit a Prüfbericht JSON to BfArM.
```


## grzctl_db

### Tool Description
Database operations

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
Usage: grzctl db [OPTIONS] COMMAND [ARGS]...

  Database operations

Options:
  --config-file STRING  Path to config file
  --help                Show this message and exit.

Commands:
  init                  Initializes the database schema using Alembic.
  list                  Lists all submissions in the database with their...
  list-change-requests  Lists all submissions in the database that have a...
  should-qc             Check whether a submission should be QCed.
  submission            Submission operations
  sync-from-inbox       Synchronize the database with submissions found...
  tui                   Starts the interactive terminal user interface to...
  upgrade               Upgrades the database schema using Alembic.
```


## grzctl_report

### Tool Description
Generate various reports related to GRZ activities.

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
Usage: grzctl report [OPTIONS] COMMAND [ARGS]...

  Generate various reports related to GRZ activities.

Options:
  --config-file STRING  Path to config file
  --help                Show this message and exit.

Commands:
  processed  Generate a report of processed submissions.
  quarterly  Generate the tables for the quarterly report.
```

