# milonga CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| milonga_create_hybrid_samplesheet.sh | Failed | image problem: the script calls GNU 'basename -s' but the image has BusyBox basename, so samples.tsv stays header-only (read merging into raw/ works) |
| milonga_milonga_setup.sh | Not completed | installer that downloads pipeline databases and test data into the image install folder; not a data tool |

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

## milonga_create_hybrid_samplesheet.sh

### Tool Description
Create a sample sheet for MiLongA from a MinION run folder

### Metadata
- **Docker Image**: quay.io/biocontainers/milonga:1.0.3--hdfd78af_0
- **Homepage**: https://gitlab.com/bfr_bioinformatics/milonga
- **Package**: https://anaconda.org/channels/bioconda/packages/milonga/overview
- **Validation**: PASS

### Original Help Text
```text
Help file ----------------------
Basic usage: create_hybrid_samplesheet.sh rundir [subdir] [--flags]

Positional arguments:

rundir: Name of run (folder name in /cephfs/abteilung4/Datentransfer/MinIon_Network/, e.g. /cephfs/abteilung4/Datentransfer/MinIon_Network/MinIon_20201001)

Optional Positional argument:

subdir: subdirectory of the rundir where the fast5 files are located, e.g. guppy6_sup

Flags:
--interactive Ask before execution
--force Force also when samples.tsv already exists

This script parses all barcode dirs in rundir/workspace/pass or workspace/fastq_pass
It concatenates all fastq in a barcode dir into a single file whenever more than one fastq file is present.
If only a single file is present, then these are assumed to follow from barcode index errors and are ignored.
Main output is the file samples.tsv in rundir. It has the following columns:
sample	long	short1	short2
Use this file and edit samples and short1 short2 prior to using milonga.py
Concatenated reads will be written to rundir/raw
```

