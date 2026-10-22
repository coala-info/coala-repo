# titan-gc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| titan-gc | Not completed | skipped: WDL/Cromwell |
| titan-gc_titan-gc-organize.py | Not completed | needs the Cromwell metadata.json of a Titan GC run (WDL/Cromwell skipped) |
| titan-gc_titan-gc-prepare.py | PASS | real SARS-CoV-2 paired reads and primer file from the tool's tests |

## titan-gc

### Tool Description
Run Titan GC on a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
- **Homepage**: https://github.com/theiagen/public_health_viral_genomics
- **Package**: https://anaconda.org/channels/bioconda/packages/titan-gc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/titan-gc/overview
- **Total Downloads**: 11.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/theiagen/public_health_viral_genomics
- **Stars**: N/A
### Original Help Text
```text
Unknown parameter passed: -help
usage: titan-gc [-h] [-i STR] [--inputs STR] [-o STR] [--outdir STR] [--options STR] [--quiet]

titan-gc - Run Titan GC on a set of samples.

required arguments:
  -i STR, --inputs STR  The JSON file to be used with Cromwell for inputs.
  -o STR, --outdir STR  Output directory to store the final results in.

optional arguments:
  -h, --help              Show this help message and exit
  -v, --version           Print the version
  --options STR           JSON file containing Cromwell options
  --profile STR           The backend profile to use [options: docker, singularity]
  --config STR            Custom backend profile to use
  --cromwell_jar STR      Path to cromwell.jar (Default use conda install)
  --quiet                 Silence all STDOUT from Cromwell and titan-gc-organize
```

## titan-gc_titan-gc-prepare.py

### Tool Description
Read a directory of FASTQ files and prepare a JSON input file for Titan GC

### Metadata
- **Docker Image**: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
- **Homepage**: https://github.com/theiagen/public_health_viral_genomics
- **Package**: https://anaconda.org/channels/bioconda/packages/titan-gc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: titan-gc-prepare [-h] [-f STR] [--fastq_separator STR]
                        [--fastq_pattern STR] [--pe1_pattern STR]
                        [--pe2_pattern STR] [-r] [--prefix STR] [--tsv]
                        [--pangolin_docker STR] [--params STR]
                        FASTQ_PATH WORKFLOW PRIMER

titan-gc-prepare - Read a directory and prepare a JSON for input to Titan GC

optional arguments:
  -h, --help            show this help message and exit

Titan-GC Prepare Parameters:
  FASTQ_PATH            Directory where FASTQ files are stored
  WORKFLOW              The Titan-GC workflow to use for analysis. Options:
                        clearlabs, illumina_pe, illumina_se, ont
  PRIMER                A file containing primers (bed format) used during
                        sequencing.
  -f STR, --fastq_ext STR
                        Extension of the FASTQs. Default: .fastq.gz
  --fastq_separator STR
                        Split FASTQ name on the last occurrence of the
                        separator. Default: _
  --fastq_pattern STR   Glob pattern to match FASTQs. Default: *.fastq.gz
  --pe1_pattern STR     Designates difference first set of paired-end reads.
                        Default: ([Aa]|[Rr]1|1) (R1, r1, 1, A, a)
  --pe2_pattern STR     Designates difference second set of paired-end reads.
                        Default: ([Bb]|[Rr]2|2) (R2, r2, 2, AB b)
  -r, --recursive       Directories will be traversed recursively
  --prefix STR          Replace the absolute path with a given string.
                        Default: Use absolute path
  --tsv                 Output FOFN as a TSV (Default JSON)

Optional Titan-GC Workflow Parameters:
  --pangolin_docker STR
                        Docker image used to run Pangolin (takes priority over
                        --params)
  --params STR          A JSON file containing parameter values
```

## titan-gc_titan-gc-organize.py

### Tool Description
Read Cromwell metadata to organize Titan GC output files into a readable structure

### Metadata
- **Docker Image**: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
- **Homepage**: https://github.com/theiagen/public_health_viral_genomics
- **Package**: https://anaconda.org/channels/bioconda/packages/titan-gc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: titan-gc-organize [-h] [--outdir STR] [--debug] METADATA_JSON

titan-gc-organize- Read Cromwell metadata to organize files into readable
structure

positional arguments:
  METADATA_JSON  The metadata.json output (-m) from the Titan GC run.

optional arguments:
  -h, --help     show this help message and exit
  --outdir STR   Directory to copy files to. (Default: ./titan-gc).
  --debug        Print helpful information
```

