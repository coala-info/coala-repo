# milonga CWL Generation Report

## milonga_milonga_setup.sh

### Tool Description
This script completes the installation of the MiLongA pipeline. The openssl library is required for hashing the downloaded files.
for MiLongA installations from Gitlab use the option set [--mamba --databases].
For more information, please visit https://gitlab.com/bfr_bioinformatics/milonga

### Metadata
- **Docker Image**: quay.io/biocontainers/milonga:1.0.3--hdfd78af_0
- **Homepage**: https://gitlab.com/bfr_bioinformatics/milonga
- **Package**: https://anaconda.org/channels/bioconda/packages/milonga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/milonga/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Basic usage:
bash /usr/local/opt/milonga/scripts/milonga_setup.sh [OPTIONS]

Description:
This script completes the installation of the MiLongA pipeline. The openssl library is required for hashing the downloaded files.
for MiLongA installations from Gitlab use the option set [--mamba --databases].
For more information, please visit https://gitlab.com/bfr_bioinformatics/milonga

Options:
  -m, --mamba                Install the latest version of 'mamba' to the Conda base environment and
                             create the MiLongA environment from the git repository recipe
  -d, --databases            Download databases to <MiLongA>/download and extract them in <MiLongA>/databases
  -t, --test_data            Download test data to <MiLongA>/download and extract them in <MiLongA>/test_data
  -s, --status               Show installation status
  -f, --force                Force overwrite for downloads in <MiLongA>/download
  -k, --keep_downloads       Do not remove downloads after extraction
  -v, --verbose              Print script debug info
  -h, --help                 Show this help
```

