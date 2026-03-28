# popins2 CWL Generation Report

## popins2_assemble

### Tool Description
Assembly of unmapped reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Total Downloads**: 591
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kehrlab/PopIns2
- **Stars**: N/A
### Original Help Text
```text
popins2 assemble - Assembly of unmapped reads.
==============================================

SYNOPSIS
    popins2 assemble [OPTIONS] BAM_FILE

DESCRIPTION
    Finds reads without high-quality alignment in the BAM FILE, quality
    filters them using SICKLE and assembles them into contigs using MINIA
    (default) or VELVET. If the option '--reference FASTA FILE' is set, the
    reads are first remapped to this reference using BWA-MEM and only reads
    that remain without high-quality alignment after remapping are
    quality-filtered and assembled.

    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  Input/output options:
    -p, --prefix PATH
          Path to the sample directories. Default: '.'.
    -s, --sample SAMPLE_ID
          An ID for the sample. Default: retrieval from BAM file header.

  Algorithm options:
    -a, --adapters STR
          Enable adapter removal for Illumina reads. Default: no adapter
          removal. One of HiSeq and HiSeqX.
    -r, --reference FASTA_FILE
          Remap reads to this reference before assembly. Default: no
          remapping. Valid filetypes are: fa, fna, fasta, and gz.
    -f, --filter INT
          Treat reads aligned to all but the first INT reference sequences
          after remapping as high-quality aligned even if their alignment
          quality is low. Recommended for non-human reference sequences.
    -vel, --use-velvet
          Use the velvet assembler. Default: Minia.
    -d, --use-spades
          Use the SPAdes assembler. Default: Minia.
    -n, --skip-assembly
          Skip assembly per sample.

  Compute resource options:
    -t, --threads INT
          Number of threads to use for BWA and samtools sort. In range
          [1..inf]. Default: 1.
    -m, --memory STR
          Maximum memory per thread for samtools sort; suffix K/M/G
          recognized. Default: 768M.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 assemble version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_merge

### Tool Description
Build or read a colored and compacted de Bruijn Graph (CCDBG) and generate supercontigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 merge - Build or read a colored and compacted de Bruijn Graph (CCDBG) and generate supercontigs.
========================================================================================================

SYNOPSIS
    popins2 merge --input-{seq|ref}-files DIR or --input-graph-file GFA
    --input-colors-file BFG_COLORS [OPTIONS] 

DESCRIPTION
    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  I/O options:
    -s, --input-seq-files DIR
          Path to the sample directories.
    -r, --input-ref-files DIR
          Path to the sample directories. (no abundance filter)
    -y, --input-graph-file GFA
          Source file with dBG
    -z, --input-colors-file BFG_COLORS
          Source file with dBG colors
    -p, --outputfile-prefix STRING
          Specify a prefix for the output files. Default: supercontigs.
    -f, --contigs-filename STRING
          Specify a filename of contigs to search for in the sample
          directories. Default: assembly_final.contigs.fa.

  Algorithm options:
    -k, --kmer-length INT
          Kmer length for the dBG construction In range [1..63]. Default: 63.
    -v, --verbose
          Print more output
    -i, --clip-tips
          Clip tips shorter than k kmers in length
    -d, --del-isolated
          Delete isolated contigs shorter than k kmers in length
    -e, --min-entropy FLOAT
          Minimum entropy for a unitig to not get flagged as low entropy In
          range [0.0..1.0]. Default: 0.

  Compute resource options:
    -t, --threads INT
          Amount of threads for parallel processing In range [1..inf].
          Default: 1.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 merge version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_multik

### Tool Description
Multi-k framework for a colored and compacted de Bruijn Graph (CCDBG)

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 multik - Multi-k framework for a colored and compacted de Bruijn Graph (CCDBG)
======================================================================================

SYNOPSIS
    popins2 multik --sample-path STRING [OPTIONS] 

DESCRIPTION
    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  I/O options:
    -s, --sample-path DIR
          Source directory with FASTA/Q files
    -a, --temp-path DIR
          Auxiliary directory for temporary files. Default: auxMultik.
    -p, --outputfile-prefix STRING
          Specify a prefix for the output files Default: ccdbg.

  Algorithm options:
    -k, --k-init INT
          Initial kmer length to start the multi-k iteration Default: 27.
    -m, --k-max INT
          Maximal kmer length to build a dBG with Default: 127.
    -d, --delta-k INT
          Step size to increase k Default: 20.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 multik version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_contigmap

### Tool Description
Alignment of unmapped reads to assembled contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 contigmap - Alignment of unmapped reads to assembled contigs.
=====================================================================

SYNOPSIS
    popins2 contigmap [OPTIONS] SAMPLE_ID

DESCRIPTION
    Aligns the reads with low-quality alignments of a sample to the set of
    supercontigs using BWA-MEM. Merges the BWA output file with the sample's
    non_ref.bam file into a non_ref_new.bam file where information about read
    mates is set.

    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  Input/output options:
    -p, --prefix PATH
          Path to the sample directories. Default: '.'.
    -c, --contigs FASTA_FILE
          Name of (super-)contigs file. Valid filetypes are: fa, fna, and
          fasta. Default: supercontigs.fa.
    -r, --reference FASTA_FILE
          Name of reference genome file. Valid filetypes are: fa, fna, and
          fasta. Default: genome.fa.

  Compute resource options:
    -t, --threads INT
          Number of threads to use for BWA and samtools sort. In range
          [1..inf]. Default: 1.
    -m, --memory STR
          Maximum memory per thread for samtools sort; suffix K/M/G
          recognized. Default: 768M.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 contigmap version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_place-refalign

### Tool Description
Contig placing by alignment of contig ends to reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 place-refalign - Contig placing by alignment of contig ends to reference genome.
========================================================================================

SYNOPSIS
    popins2 place-refalign [OPTIONS]

DESCRIPTION
    This is step 1/3 of contig placing. The contig locations in the sample
    directories are merged into one file of locations. Next, prefixes/suffixes
    of contigs are aligned to the merged locations on the reference genome and
    VCF records are written if the alignment is successful. Locations of
    contigs that do not align to the reference genome are written to
    additional output files locations_unplaced.txt in the sample directories.
    Further, groups of contigs that can be placed at the same position and
    whose prefixes/suffixes align to each other are written to another output
    file; only a single VCF record is written per group.

    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  Input/output options:
    -p, --prefix PATH
          Path to the sample directories. Default: '.'.
    -l, --locations FILE
          Name of merged locations file. Default: locations.txt.
    -i, --insertions VCF_FILE
          Name of VCF output file. Valid filetype is: vcf. Default:
          insertions.vcf.
    -c, --contigs FASTA_FILE
          Name of supercontigs file. Valid filetypes are: fa, fna, and fasta.
          Default: supercontigs.fa.
    -r, --reference FASTA_FILE
          Name of reference genome file. Valid filetypes are: fa, fna, and
          fasta. Default: genome.fa.
    -g, --groups FILE
          Name of file containing groups of contigs that can be placed at the
          same position and whose prefixes/suffixes align. Default:
          groups.txt.

  Algorithm options:
    --minScore FLOAT
          Minimal anchoring score for a location. In range [0..1]. Default:
          0.3.
    --minReads INT
          Minimal number of anchoring read pairs for a location. Default: 2.
    --maxInsertSize INT
          The maximum expected insert size of the read pairs. Default: 800.
    --readLength INT
          The length of the reads. Default: 100.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 place-refalign version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_place-splitalign

### Tool Description
Contig placing by split-read alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 place-splitalign - Contig placing by split-read alignment.
==================================================================

SYNOPSIS
    popins2 place-splitalign [OPTIONS] SAMPLE_ID

DESCRIPTION
    This is step 2/3 of contig placing. All locations in a sample's
    locations_unplaced.txt are split-read aligned and the results are written
    to a file locations_placed.txt in the sample directory.

    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  Input/output options:
    -p, --prefix PATH
          Path to the sample directories. Default: '.'.
    -c, --contigs FASTA_FILE
          Name of supercontigs file. Valid filetypes are: fa, fna, and fasta.
          Default: supercontigs.fa.
    -r, --reference FASTA_FILE
          Name of reference genome file. Valid filetypes are: fa, fna, and
          fasta. Default: genome.fa.

  Algorithm options:
    --maxInsertSize INT
          The maximum expected insert size of the read pairs. Default: 800.
    --readLength INT
          The length of the reads. Default: 100.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 place-splitalign version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_place-finish

### Tool Description
Combining breakpoint positions from split-read alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 place-finish - Combining breakpoint positions from split-read alignment.
================================================================================

SYNOPSIS
    popins2 place-finish [OPTIONS]

DESCRIPTION
    This is step 3/3 of contig placing. The results from split-read alignment
    (the locations_placed.txt files) of all samples are combined and appended
    to the VCF output file.

    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  Input/output options:
    -p, --prefix PATH
          Path to the sample directories. Default: '.'.
    -i, --insertions VCF_FILE
          Name of VCF output file. Valid filetype is: vcf. Default:
          insertions.vcf.
    -r, --reference FASTA_FILE
          Name of reference genome file. Valid filetypes are: fa, fna, and
          fasta. Default: genome.fa.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 place-finish version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## popins2_genotype

### Tool Description
Computes genotype likelihoods for a sample for all insertions given in the input VCF file by aligning all reads, which are mapped to the reference genome around the insertion breakpoint or to the contig, to the reference and to the alternative insertion sequence. VCF records with the genotype likelihoods in GT:PL format for the individual are written to a file insertions.vcf in the sample directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
- **Homepage**: https://github.com/kehrlab/PopIns2
- **Package**: https://anaconda.org/channels/bioconda/packages/popins2/overview
- **Validation**: PASS

### Original Help Text
```text
popins2 genotype - Genotyping a sample for insertions.
======================================================

SYNOPSIS
    popins2 genotype [OPTIONS] SAMPLE_ID

DESCRIPTION
    Computes genotype likelihoods for a sample for all insertions given in the
    input VCF file by aligning all reads, which are mapped to the reference
    genome around the insertion breakpoint or to the contig, to the reference
    and to the alternative insertion sequence. VCF records with the genotype
    likelihoods in GT:PL format for the individual are written to a file
    insertions.vcf in the sample directory.

    -h, --help
          Display the help message.
    -H, --fullHelp
          Display the help message with the full list of options.
    --version
          Display version information.

  Input/output options:
    -p, --prefix PATH
          Path to the sample directories. Default: '.'.
    -i, --insertions VCF_FILE
          Name of VCF input file. Valid filetype is: vcf. Default:
          insertions.vcf.
    -c, --contigs FASTA_FILE
          Name of supercontigs file. Valid filetypes are: fa, fna, and fasta.
          Default: supercontigs.fa.
    -r, --reference FASTA_FILE
          Name of reference genome file. Valid filetypes are: fa, fna, and
          fasta. Default: genome.fa.

  Algorithm options:
    -m, --model GENOTYPING_MODEL
          Model used for genotyping. One of DUP and RANDOM. Default: RANDOM.
    -w, --window INT
          Region window size. Default: 50.

VERSION
    Last update: on 2022-11-30 14:36:07
    popins2 genotype version: 0.13.0-07b2936
    SeqAn version: 2.2.0
```


## Metadata
- **Skill**: generated
