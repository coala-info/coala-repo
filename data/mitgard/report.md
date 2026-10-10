# mitgard CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mitgard_MITGARD-LR.py | PASS |  |
| mitgard_MITGARD.py | PASS |  |

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

## mitgard_MITGARD.py

### Tool Description
Recovers the mitochondrial genome from short-read RNA-seq data (single-end or paired-end) with a reference mitogenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
- **Homepage**: https://github.com/pedronachtigall/MITGARD
- **Package**: https://anaconda.org/channels/bioconda/packages/mitgard/overview
- **Validation**: PASS

### Original Help Text
```text
[help] MITGARD.py: ok via MITGARD.py --help (--help=ok, -h=ok, -help=ok, (no args)=usage_only)
Usage: MITGARD.py [options]

Options:
  -h, --help            show this help message and exit
  -s string, --sample=string
                        Mandatory - sample ID to be used in the output files
                        and final mitogenome assembly
  -S fq, --single_end=fq
                        Mandatory - input single-end fq file (FASTQ format),
                        /path/to/single_end.fq ; the fq file can be in .gz the
                        compressed format
  -1 fq, --paired_read1=fq
                        Mandatory - input paired-end read 1 fq file (FASTQ
                        format), /path/to/paired_read1.fq ; the fq file can be
                        in .gz the compressed format
  -2 fq, --paired_read2=fq
                        Mandatory - input paired-end read 2 fq file (FASTQ
                        format), /path/to/paired_read2.fq ; the fq file can be
                        in .gz the compressed format
  -R fasta, --reference=fasta
                        Mandatory - input mitogenome in FASTA format to be
                        used as reference, /path/to/reference.fa
  -a string, --assembler=string
                        Optional - this parameter sets the assembler tools to
                        be used to generate the mitochondrial contigs. Choice
                        one from trinity, spades and mitoz or make combination
                        between them (e.g., "trinity,spades,mitoz", or
                        "trinity,mitoz", etc). By default, MITGARD uses
                        trinity and spades, which were shown to recover the
                        entire mitochondrial genome using RNA-seq data.
                        [default=trinity,spades]
  -L string, --low_coverage=string
                        Optional - this parameter decide what to do with low
                        coverage regions. Use "N" to assign N's in the low
                        coverage regions. Use "R" to assign the Reference
                        nucleotides in the low coverage regions. [default=N]
  -r string, --rearrangement=string
                        Optional - this parameter turn on/off an additional
                        step to check for rearrangements using the
                        mitochondrial contigs generated. To turn on set
                        "True". [Default=False]
  -g int, --genetic_code=int
                        Optional - set the genetic code to be used in the "--
                        genetic_code" parameter of MitoZ assembler [Default=2]
  -C string, --clade=string
                        Optional - set the taxonomic clade to be used in the "
                        --clade" parameter of MitoZ assembler
                        [Default=Chordata]
  -c int, --cpu=int     Optional - number of threads to be used in each step
                        [default=1]
  -M string, --memory=string
                        Optional - Max memory usage to be passed to Trinity
                        assembler [default=4G], use the same format as stated
                        by Trinity assembler
```
