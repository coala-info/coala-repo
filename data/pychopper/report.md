# pychopper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pychopper | PASS |  |

## pychopper

### Tool Description
Tool to identify, orient and rescue full-length cDNA reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/pychopper:2.7.10--pyhdfd78af_0
- **Homepage**: https://github.com/epi2me-labs/pychopper
- **Package**: https://anaconda.org/channels/bioconda/packages/pychopper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pychopper/overview
- **Total Downloads**: 38.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/pychopper
- **Stars**: N/A
### Original Help Text
```text
usage: pychopper [-h] [-b primers] [-g phmm_file] [-c config_file]
                 [-k {PCS109,PCS110,PCS111,PCS114,LSK114,PCB111,PCB114}]
                 [-q cutoff] [-Q min_qual] [-z min_len] [-r report_pdf]
                 [-u unclass_output] [-l len_fail_output] [-w rescue_output]
                 [-S stats_output] [-K qc_fail_output] [-Y autotune_nr]
                 [-L autotune_samples] [-A scores_output] [-m method]
                 [-x rescue] [-p] [-t threads] [-B batch_size] [-D read stats]
                 [-y] [-U]
                 input_fastx [output_fastx]

Tool to identify, orient and rescue full-length cDNA reads.

positional arguments:
  input_fastx           Input file.
  output_fastx          Output file.

options:
  -h, --help            show this help message and exit
  -b primers            Primers fasta.
  -g phmm_file          File with custom profile HMMs (None).
  -c config_file        File to specify primer configurations for each
                        direction (None).
  -k {PCS109,PCS110,PCS111,PCS114,LSK114,PCB111,PCB114}
                        Use primer sequences from this kit (PCS109).
  -q cutoff             Cutoff parameter (autotuned).
  -Q min_qual           Minimum mean base quality (7.0).
  -z min_len            Minimum segment length (50).
  -r report_pdf         Report PDF (pychopper.pdf).
  -u unclass_output     Write unclassified reads to this file.
  -l len_fail_output    Write fragments failing the length filter in this
                        file.
  -w rescue_output      Write rescued reads to this file.
  -S stats_output       Write statistics to this file.
  -K qc_fail_output     Write reads failing mean quality filter to this file.
  -Y autotune_nr        Approximate number of reads used for tuning the cutoff
                        parameter (10000).
  -L autotune_samples   Number of samples taken when tuning cutoff parameter
                        (30).
  -A scores_output      Write alignment scores to this BED file.
  -m method             Detection method: phmm or edlib (phmm).
  -x rescue             Protocol-specific read rescue: DCS109 (None).
  -p                    Keep primers, but trim the rest.
  -t threads            Number of threads to use (8).
  -B batch_size         Maximum number of reads processed in each batch
                        (10000).
  -D read stats         Tab separated file with per-read stats (None).
  -y                    Output FASTQ comment as BAM tags. Use with minimap2 -y
                        to pass UMI and additional info into BAM file.
  -U                    Detect UMIs
```


## Metadata
- **Skill**: not generated
