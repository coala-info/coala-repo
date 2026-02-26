# gmwi2 CWL Generation Report

## gmwi2

### Tool Description
GMWI2 (Gut Microbiome Wellness Index 2) is a a robust and biologically interpretable predictor of health status based on the gut microbiome.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmwi2:1.6--pyhdfd78af_0
- **Homepage**: https://github.com/danielchang2002/GMWI2
- **Package**: https://anaconda.org/channels/bioconda/packages/gmwi2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmwi2/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/danielchang2002/GMWI2
- **Stars**: N/A
### Original Help Text
```text
usage: gmwi2 [-h] -n NUM_THREADS -f FORWARD -r REVERSE -o OUTPUT_PREFIX [-v]

 ██████╗ ███╗   ███╗██╗    ██╗██╗██████╗ 
██╔════╝ ████╗ ████║██║    ██║██║╚════██╗
██║  ███╗██╔████╔██║██║ █╗ ██║██║ █████╔╝
██║   ██║██║╚██╔╝██║██║███╗██║██║██╔═══╝ 
╚██████╔╝██║ ╚═╝ ██║╚███╔███╔╝██║███████╗
 ╚═════╝ ╚═╝     ╚═╝ ╚══╝╚══╝ ╚═╝╚══════╝

DESCRIPTION:
GMWI2 version 1.6 
GMWI2 (Gut Microbiome Wellness Index 2) is a a robust and biologically interpretable predictor of health status based on the gut microbiome.

AUTHORS: 
Daniel Chang, Vinod Gupta, Jaeyun Sung

USAGE: 
GMWI2 takes as input raw fastq (or fastq.gz) files generated from a paired-end stool metagenome, performs quality control, estimates microbial abundances, and using these microbial estimates, returns as output the GMWI2 score. 

* Example usage:

$ ls
.
├── forward.fastq
└── reverse.fastq

$ gmwi2 -f forward.fastq -r reverse.fastq -n 8 -o output_prefix

$ ls
.
├── forward.fastq
├── reverse.fastq
├── output_prefix_GMWI2.txt
├── output_prefix_GMWI2_taxa.txt
└── output_prefix_metaphlan.txt

The three output files are: 
(i) output_prefix_GMWI2.txt: GMWI2 score
(ii) output_prefix_GMWI2_taxa.txt: A list of the taxa present in the sample used to compute GMWI2
(iii) output_prefix_metaphlan.txt: Raw MetaPhlAn3 taxonomic profiling output

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

required named arguments:
  -n NUM_THREADS, --num_threads NUM_THREADS
                        number of threads
  -f FORWARD, --forward FORWARD
                        forward-read of metagenome (.fastq/.fastq.gz)
  -r REVERSE, --reverse REVERSE
                        reverse-read of metagenome (.fastq/.fastq.gz)
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        prefix to designate output file names
```

