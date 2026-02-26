# isoquant CWL Generation Report

## isoquant_isoquant.py

### Tool Description
IsoQuant is a tool for quantifying isoforms from long-read sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/isoquant:3.10.0--hdfd78af_0
- **Homepage**: https://github.com/ablab/IsoQuant
- **Package**: https://anaconda.org/channels/bioconda/packages/isoquant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isoquant/overview
- **Total Downloads**: 58.7K
- **Last updated**: 2025-10-25
- **GitHub**: https://github.com/ablab/IsoQuant
- **Stars**: N/A
### Original Help Text
```text
usage: isoquant.py [-h] [--full_help] [--test] [--output OUTPUT]
                   [--prefix PREFIX] [--labels LABELS [LABELS ...]]
                   [--reference REFERENCE] [--genedb GENEDB]
                   [--complete_genedb] [--bam BAM [BAM ...] |
                   --fastq FASTQ [FASTQ ...] |
                   --unmapped_bam UNMAPPED_BAM [UNMAPPED_BAM ...] |
                   --yaml YAML]
                   [--illumina_bam ILLUMINA_BAM [ILLUMINA_BAM ...]]
                   [--read_group READ_GROUP]
                   [--data_type {pacbio_ccs,pacbio,nanopore,ont,assembly,transcripts}]
                   [--stranded STRANDED] [--polya_trimmed {none,all,stranded}]
                   [--fl_data] [--threads THREADS] [--resume | --force]
                   [--check_canonical] [--sqanti_output] [--count_exons]
                   [--version]

options:
  -h, --help            show this help message and exit
  --full_help           show full list of options
  --test                run IsoQuant on toy dataset
  --version, -v         show program's version number and exit

Reference data:
  --reference, -r REFERENCE
                        reference genome in FASTA format (can be gzipped)
  --genedb, -g GENEDB   gene database in gffutils DB format or GTF/GFF format
                        (optional)
  --complete_genedb     use this flag if gene annotation contains transcript
                        and gene metafeatures, e.g. with official annotations,
                        such as GENCODE; speeds up gene database conversion

Input data:
  --bam BAM [BAM ...]   sorted and indexed BAM file(s), each file will be
                        treated as a separate sample
  --fastq FASTQ [FASTQ ...]
                        input FASTQ/FASTA file(s) with reads, each file will
                        be treated as a separate sample; reference genome
                        should be provided when using reads as input
  --unmapped_bam UNMAPPED_BAM [UNMAPPED_BAM ...]
                        unmapped BAM file(s), each file will be treated as a
                        separate sample
  --yaml YAML           yaml file containing all input files, one entry per
                        sample, check readme for format info
  --illumina_bam ILLUMINA_BAM [ILLUMINA_BAM ...]
                        sorted and indexed file(s) with Illumina reads from
                        the same sample
  --read_group READ_GROUP
                        a way to group feature counts (no grouping by
                        default): by BAM file tag (tag:TAG); using additional
                        file (file:FILE:READ_COL:GROUP_COL:DELIM); using read
                        id (read_id:DELIM); by original file name (file_name)
  --data_type, -d {pacbio_ccs,pacbio,nanopore,ont,assembly,transcripts}
                        type of data to process, supported types are:
                        pacbio_ccs, pacbio, nanopore, ont, assembly,
                        transcripts
  --stranded STRANDED   reads strandness type, supported values are: forward,
                        reverse, none
  --polya_trimmed {none,all,stranded}
                        define reads which had polyA tail trimmed
  --fl_data             reads represent FL transcripts; both ends of the read
                        are considered to be reliable

Output naming:
  --output, -o OUTPUT   output folder, will be created automatically
                        [default=isoquant_output]
  --prefix, -p PREFIX   experiment name; to be used for folder and file
                        naming; default is OUT
  --labels, -l LABELS [LABELS ...]
                        sample/replica labels to be used as column names;
                        input file names are used if not set; must be equal to
                        the number of input files given via --fastq/--bam

Pipeline options:
  --threads, -t THREADS
                        number of threads to use
  --resume              resume failed run, specify output folder, input
                        options are not allowed
  --force               force to overwrite the previous run

Output configuration:
  --check_canonical     report whether splice junctions are canonical
  --sqanti_output       produce SQANTI-like TSV output
  --count_exons         perform exon and intron counting
```

