# inspector CWL Generation Report

## inspector_inspector.py

### Tool Description
de novo assembly evaluator

### Metadata
- **Docker Image**: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
- **Homepage**: https://github.com/ChongLab/Inspector
- **Package**: https://anaconda.org/channels/bioconda/packages/inspector/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/inspector/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ChongLab/Inspector
- **Stars**: N/A
### Original Help Text
```text
usage: inspector.py [-h] -c contig.fa -r raw_reads.fastq -o output_dict/

de novo assembly evaluator

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -c CONTIGFILE, --contig CONTIGFILE
                        assembly contigs in FASTA format
  -r READ [READ ...], --read READ [READ ...]
                        sequencing reads in FASTA/FASTQ format
  -d DATATYPE, --datatype DATATYPE
                        Input read type. (clr, hifi, nanopore) [clr]
  -o OUTPATH, --outpath OUTPATH
                        output directory
  --ref REF             OPTIONAL reference genome in FASTA format
  -t THREAD, --thread THREAD
                        number of threads. [8]
  --min_depth MIN_DEPTH
                        minimal read-alignment depth for a contig base to be
                        considered in QV calculation. [20% of average depth]
  --min_contig_length MIN_CONTIG_LENGTH
                        minimal length for a contig to be evaluated. [10000]
  --min_contig_length_assemblyerror MIN_CONTIG_LENGTH_ASSEMBLYERROR
                        minimal contig length for assembly error detection.
                        [1000000]
  --min_assembly_error_size MIN_ASSEMBLY_ERROR_SIZE
                        minimal size for assembly errors. [50]
  --max_assembly_error_size MAX_ASSEMBLY_ERROR_SIZE
                        maximal size for assembly errors. [4000000]
  --noplot              do not make plots
  --skip_read_mapping   skip the step of mapping reads to contig.
  --skip_structural_error
                        skip the step of identifying large structural errors.
  --skip_structural_error_detect
                        skip the step of detecting large structural errors.
  --skip_base_error     skip the step of identifying small-scale errors.
  --skip_base_error_detect
                        skip the step of detecting small-scale errors from
                        pileup.
```


## inspector_inspector-correct.py

### Tool Description
Assembly error correction based on Inspector assembly evaluation

### Metadata
- **Docker Image**: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
- **Homepage**: https://github.com/ChongLab/Inspector
- **Package**: https://anaconda.org/channels/bioconda/packages/inspector/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inspector-correct.py [-h] -i inspector_out/ --datatype pacbio-raw 

Assembly error correction based on Inspector assembly evaluation

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INSPECTOR, --inspector INSPECTOR
                        Inspector evaluation directory. Original file names
                        are required.
  --datatype DATATYPE   Type of read used for Inspector evaluation. This
                        option is required for structural error correction
                        when performing local assembly with Flye. (pacbio-raw,
                        pacbio-hifi, nano-raw,pacbio-corr, nano-corr)
  -o OUTPATH, --outpath OUTPATH
                        output directory
  --flyetimeout FLYETIMEOUT
                        Maximal runtime for local assembly with Flye. Unit is
                        second. [1200]
  --skip_structural     Do not correct structural errors. Local assembly will
                        not be performed.
  --skip_baseerror      Do not correct base errors.
  -t THREAD, --thread THREAD
                        number of threads
```


## Metadata
- **Skill**: generated
