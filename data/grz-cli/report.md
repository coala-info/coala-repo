# grz-cli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| grz-cli_encrypt | PASS |  |
| grz-cli_get-id | PASS |  |
| grz-cli_submit | Not completed | needs an account and an S3 upload server of the German genome data center |
| grz-cli_upload | Not completed | needs an account and an S3 upload server of the German genome data center |
| grz-cli_validate | PASS |  |

## grz-cli_get-id

### Tool Description
Get ID from metadata

### Metadata
- **Docker Image**: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/grz-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/grz-cli/overview
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
2026-02-25 09:01 PM [INFO] grz_cli.cli: Running command: /usr/local/bin/grz-cli get-id --h
Usage: grz-cli get-id [OPTIONS] METADATA
Try 'grz-cli get-id --help' for help.

Error: No such option: --h Did you mean --help?
```

## grz-cli_validate

### Tool Description
Validate the submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grz-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grz-cli validate [OPTIONS]

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

## grz-cli_encrypt

### Tool Description
Encrypt a submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grz-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grz-cli encrypt [OPTIONS]

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

## grz-cli_upload

### Tool Description
Upload a submission to a GRZ/GDC.

### Metadata
- **Docker Image**: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grz-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grz-cli upload [OPTIONS]

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

## grz-cli_submit

### Tool Description
Validate, encrypt, and then upload.

### Metadata
- **Docker Image**: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/grz-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grz-cli submit [OPTIONS]

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
