# mitgard CWL Generation Report

## mitgard_MITGARD-LR.py

### Tool Description
MITGARD-LR.py

### Metadata
- **Docker Image**: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
- **Homepage**: https://github.com/pedronachtigall/MITGARD
- **Package**: https://anaconda.org/channels/bioconda/packages/mitgard/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mitgard/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pedronachtigall/MITGARD
- **Stars**: N/A
### Original Help Text
```text
Usage: MITGARD-LR.py [options]

Options:
  -h, --help            show this help message and exit
  -s string, --sample=string
                        Mandatory - sample ID to be used in the output files
                        and final mitogenome assembly
  -r fq, --reads=fq     Mandatory - input long-reads fq file (FASTQ format),
                        /path/to/long_read.fq ; the fq file can be in .gz the
                        compressed format (e.g. long_read.fq.gz).
  -R fasta, --reference=fasta
                        Mandatory - input mitogenome in FASTA format to be
                        used as reference, /path/to/reference.fa
  -m string, --method=string
                        Optional - this parameter indicates the type of long-
                        read data being used (e.g., "pacbio_hifi",
                        "pacbio_clr", or "nanopore"). If not set, the
                        "pacbio_hifi" will be considered.
                        [default=pacbio_hifi]
  -l int, --length=int  Optional - this parameter indicates the estimated size
                        of the final mitochondiral genome (in bp; e.g., use
                        17000 for 17Kb). If not set, the estimated size will
                        be considered similar to the reference being used.
                        [default=length(reference)]
  -c int, --cpu=int     Optional - number of threads to be used in each step
                        [default=1]
```

