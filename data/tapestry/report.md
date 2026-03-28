# tapestry CWL Generation Report

## tapestry_weave

### Tool Description
assess quality of one genome assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/johnomics/tapestry
- **Package**: https://anaconda.org/channels/bioconda/packages/tapestry/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tapestry/overview
- **Total Downloads**: 14.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/johnomics/tapestry
- **Stars**: N/A
### Original Help Text
```text
usage: weave [-h] -a ASSEMBLY -r READS [-d DEPTH] [-l LENGTH]
             [-t TELOMERE [TELOMERE ...]] [-w WINDOWSIZE] [-f]
             [-m MINCONTIGALIGNMENT] [-o OUTPUT] [-c CORES] [-v]

weave: assess quality of one genome assembly

options:
  -h, --help            show this help message and exit
  -a ASSEMBLY, --assembly ASSEMBLY
                        filename of assembly in FASTA format (required)
  -r READS, --reads READS
                        filename of long reads in FASTQ format (required; must
                        be gzipped)
  -d DEPTH, --depth DEPTH
                        genome coverage to subsample from FASTQ file (default
                        50)
  -l LENGTH, --length LENGTH
                        minimum read length to retain when subsampling
                        (default 10000 bp)
  -t TELOMERE [TELOMERE ...], --telomere TELOMERE [TELOMERE ...]
                        telomere sequence to search for
  -w WINDOWSIZE, --windowsize WINDOWSIZE
                        window size for ploidy calculations (default ~1/30th
                        of contig N50 length, minimum 10000 bp)
  -f, --forcereadoutput
                        output read alignments whatever the assembly size
                        (default, only output read alignments for <50 Mb
                        assemblies)
  -m MINCONTIGALIGNMENT, --mincontigalignment MINCONTIGALIGNMENT
                        minimum length of contig alignment to keep (default
                        2000 bp)
  -o OUTPUT, --output OUTPUT
                        directory to write output, default weave_output
  -c CORES, --cores CORES
                        number of parallel cores to use (default 1)
  -v, --version         report version number and exit
```


## tapestry_clean

### Tool Description
filter and order assembly from list of contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/johnomics/tapestry
- **Package**: https://anaconda.org/channels/bioconda/packages/tapestry/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clean [-h] -a ASSEMBLY -c CSV [-o OUTPUT]

clean: filter and order assembly from list of contigs

options:
  -h, --help            show this help message and exit
  -a ASSEMBLY, --assembly ASSEMBLY
                        filename of assembly in FASTA format
  -c CSV, --csv CSV     Tapestry CSV output
  -o OUTPUT, --output OUTPUT
                        filename of output contigs, default
                        filtered_assembly.fasta
```


## Metadata
- **Skill**: generated
