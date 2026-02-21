# pbcoretools CWL Generation Report

## pbcoretools

### Tool Description
The provided text does not contain help information as the executable was not found in the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbcoretools:0.8.1--py_1
- **Homepage**: https://github.com/mpkocher/pbcoretools
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbcoretools/overview
- **Total Downloads**: 12.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mpkocher/pbcoretools
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 01:43:33  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "pbcoretools": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## pbcoretools_pbvalidate

### Tool Description
Utility for validating files produced by PacBio software against our own internal specifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbcoretools:0.8.1--py_1
- **Homepage**: https://github.com/mpkocher/pbcoretools
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: pbvalidate [-h] [--version] [--log-file LOG_FILE]
                  [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL} | --debug | --quiet | -v]
                  [--quick] [--max MAX_ERRORS] [--max-records MAX_RECORDS]
                  [--type {BAM,Fasta,AlignmentSet,ConsensusSet,ConsensusAlignmentSet,SubreadSet,TranscriptSet,BarcodeSet,ContigSet,ReferenceSet,GmapReferenceSet}]
                  [--index] [--strict] [-x XUNIT_OUT] [--alarms ALARMS_OUT]
                  [--unaligned] [--unmapped] [--aligned] [--mapped]
                  [--contents {SUBREAD,CCS}] [--reference REFERENCE]
                  file

Utility for validating files produced by PacBio software against our own
internal specifications.

positional arguments:
  file                  BAM, FASTA, or DataSet XML file

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --log-file LOG_FILE   Write the log to file. Default(None) will write to
                        stdout. (default: None)
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set log level (default: CRITICAL)
  --debug               Alias for setting log level to DEBUG (default: False)
  --quiet               Alias for setting log level to CRITICAL to suppress
                        output. (default: False)
  -v, --verbose         Set the verbosity level. (default: None)
  --quick               Limits validation to the first 100 records (plus file
                        header); equivalent to --max-records=100 (default:
                        False)
  --max MAX_ERRORS      Exit after MAX_ERRORS have been recorded (DEFAULT:
                        check entire file) (default: None)
  --max-records MAX_RECORDS
                        Exit after MAX_RECORDS have been inspected (DEFAULT:
                        check entire file) (default: None)
  --type {BAM,Fasta,AlignmentSet,ConsensusSet,ConsensusAlignmentSet,SubreadSet,TranscriptSet,BarcodeSet,ContigSet,ReferenceSet,GmapReferenceSet}
                        Use the specified file type instead of guessing
                        (default: None)
  --index               Require index files (.fai or .pbi) (default: False)
  --strict              Turn on additional validation, primarily for DataSet
                        XML (default: False)
  -x XUNIT_OUT, --xunit-out XUNIT_OUT
                        Xunit test results for Jenkins (default: None)
  --alarms ALARMS_OUT   alarms.json for errors (default: None)

bam:
  BAM options

  --unaligned           Specify that the file should contain only unmapped
                        alignments (DEFAULT: no requirement) (default: None)
  --unmapped            Alias for --unaligned (default: None)
  --aligned             Specify that the file should contain only mapped
                        alignments (DEFAULT: no requirement) (default: None)
  --mapped              Alias for --aligned (default: None)
  --contents {SUBREAD,CCS}
                        Enforce read type (default: None)
  --reference REFERENCE
                        Path to optional reference FASTA file, used for
                        additional validation of mapped BAM records (default:
                        None)

fasta:
  Fasta options
```

## pbcoretools_bamsieve

### Tool Description
Tool for subsetting a BAM or PacBio DataSet file based on either a whitelist of hole numbers or a percentage of reads to be randomly selected.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbcoretools:0.8.1--py_1
- **Homepage**: https://github.com/mpkocher/pbcoretools
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: bamsieve [-h] [--version] [--log-file LOG_FILE]
                [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL} | --debug | --quiet | -v]
                [--show-zmws] [--whitelist WHITELIST] [--blacklist BLACKLIST]
                [--subreads] [--percentage PERCENTAGE] [-n COUNT] [-s SEED]
                [--ignore-metadata] [--relative] [--anonymize] [--barcodes]
                [--sample-scraps] [--keep-uuid] [--min-adapters MIN_ADAPTERS]
                input_bam [output_bam]

Tool for subsetting a BAM or PacBio DataSet file based on either a whitelist
of hole numbers or a percentage of reads to be randomly selected.

positional arguments:
  input_bam             Input BAM or DataSet from which reads will be read
  output_bam            Output BAM or DataSet to which filtered reads will be
                        written (default: None)

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --log-file LOG_FILE   Write the log to file. Default(None) will write to
                        stdout. (default: None)
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set log level (default: WARN)
  --debug               Alias for setting log level to DEBUG (default: False)
  --quiet               Alias for setting log level to CRITICAL to suppress
                        output. (default: False)
  -v, --verbose         Set the verbosity level. (default: None)
  --show-zmws           Print a list of ZMWs and exit (default: False)
  --whitelist WHITELIST
                        Comma-separated list of ZMWs, or file containing
                        whitelist of one hole number per line, or BAM/DataSet
                        file from which to extract ZMWs (default: None)
  --blacklist BLACKLIST
                        Opposite of --whitelist, specifies ZMWs to discard
                        (default: None)
  --subreads            If set, the whitelist or blacklist will be assumed to
                        contain one subread name per line, or a BAM/DataSet
                        file from which to extract subreads (default: False)
  --percentage PERCENTAGE
                        If you prefer to recover a percentage of a SMRTcell
                        rather than a specific list of reads specify that
                        percentage (range 0-100) here (default: None)
  -n COUNT, --count COUNT
                        Recover a specific number of ZMWs picked at random
                        (default: None)
  -s SEED, --seed SEED  Random seed for selecting a percentage of reads
                        (default: None)
  --ignore-metadata     Discard input DataSet metadata (default: False)
  --relative            Make external resource paths relative (default: False)
  --anonymize           Randomize sequences for privacy (default: False)
  --barcodes            Indicates that the whitelist or blacklist contains
                        barcode indices instead of ZMW numbers (default:
                        False)
  --sample-scraps       If enabled, --percentage and --count will include hole
                        numbers from scraps BAM files when picking a random
                        sample (default is to sample only ZMWs present in
                        subreads BAM). (default: False)
  --keep-uuid           If enabled, the UUID from the input dataset will be
                        used for the output as well. (default: False)
  --min-adapters MIN_ADAPTERS
                        Minimum number of adapters to filter for (default:
                        None)
```

