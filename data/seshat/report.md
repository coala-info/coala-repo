# seshat CWL Generation Report

## seshat_find-in-gmail

### Tool Description
Finds emails in Gmail and annotates them.

### Metadata
- **Docker Image**: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
- **Homepage**: https://github.com/clintval/tp53
- **Package**: https://anaconda.org/channels/bioconda/packages/seshat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seshat/overview
- **Total Downloads**: 484
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/clintval/tp53
- **Stars**: N/A
### Original Help Text
```text
required
  -i, --input  <arg>         The path to the input VCF file.
  -o, --output  <arg>        The output path prefix for writing annotations.

 optional
  -c, --credentials  <arg>   The Google OAuth credentials JSON.
  -n, --newer-than  <arg>    Only consider emails that arrived <= hours.
                             (default: 10).
  -w, --wait-for  <arg>      How long to wait for Seshat to email in seconds.
                             (default: 200)

  -h, --help                 Show help message
```


## seshat_merge

### Tool Description
Merge VCF files with annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
- **Homepage**: https://github.com/clintval/tp53
- **Package**: https://anaconda.org/channels/bioconda/packages/seshat/overview
- **Validation**: PASS

### Original Help Text
```text
required
  -i, --input  <arg>         The path to the input VCF file.
  -a, --annotations  <arg>   The annotation text file output from Seshat.
  -o, --output  <arg>        The path to the output VCF file.

  -h, --help                 Show help message
```


## seshat_round-trip

### Tool Description
Seshat round-trip annotation tool

### Metadata
- **Docker Image**: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
- **Homepage**: https://github.com/clintval/tp53
- **Package**: https://anaconda.org/channels/bioconda/packages/seshat/overview
- **Validation**: PASS

### Original Help Text
```text
required
  -i, --input  <arg>              The path to the input VCF file.
  -o, --output  <arg>             The output path prefix for the annotations and
                                  annotated VCF.
  -e, --email  <arg>              The email address for delivering Seshat
                                  annotations.

 optional
  -a, --assembly  <arg>           The human genome assembly of the input VCF.
                                  Available options: (hg17, hg19, hg38).
                                  (default: hg38).
      --annotation-type  <arg>    The annotation text file output from Seshat.
                                  Available options: (short, long).
                                  (default: long).
  -u, --url  <arg>                The Seshat batch annotation URL.
                                  (default:
                                  http://vps338341.ovh.net/batch_analysis).
  -w, --wait-for-upload  <arg>    Seconds to wait before raising an exception.
                                  (default: 200).
      --wait-for-email  <arg>     How long to wait for Seshat to email in
                                  seconds.
                                  (default: 200)
  -n, --newer-than-email  <arg>   Only consider emails that arrived <= hours.
                                  (default: 10).
  -c, --credentials  <arg>        The Google OAuth credentials JSON.

  -h, --help                      Show help message
```


## seshat_upload-vcf

### Tool Description
Uploads a VCF file to Seshat for annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
- **Homepage**: https://github.com/clintval/tp53
- **Package**: https://anaconda.org/channels/bioconda/packages/seshat/overview
- **Validation**: PASS

### Original Help Text
```text
required
  -i, --input  <arg>      The path to the input VCF file.
  -e, --email  <arg>      The email address for delivering Seshat annotations.

 optional
  -u, --url  <arg>        The Seshat batch annotation URL.
                          (default: http://vps338341.ovh.net/batch_analysis).
  -w, --wait-for  <arg>   Seconds to wait before raising an exception.
                          (default: 200).

  -a, --assembly  <arg>   The human genome assembly of the input VCF.
                          Available options: (hg17, hg19, hg38).
                          (default: hg38).
  -h, --help              Show help message
```

