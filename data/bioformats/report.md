# bioformats CWL Generation Report

## bioformats_bedautosql

### Tool Description
Get an autoSql table structure for the specified BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gtamazian/bioformats
- **Stars**: N/A
### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. bedautosql
       [-h] [-n NAME] [-d DESCRIPTION] [-l LINES] bed_file output_file

Get an autoSql table structure for the specified BED file

positional arguments:
  bed_file              a BED file
  output_file           an output file

optional arguments:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  a table name (default: Table)
  -d DESCRIPTION, --description DESCRIPTION
                        a table description (default: Description)
  -l LINES, --lines LINES
                        the number of lines to analyzefrom the input file
                        (default: 100)
```


## bioformats_bedcolumns

### Tool Description
A command within the bioformats toolset to process or display columns of a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. bedcolumns
       [-h] bed_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. bedcolumns: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_fastagaps

### Tool Description
Identify gaps in a FASTA file and output their coordinates in BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. fastagaps
       [-h] fasta_file bed_gaps
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. fastagaps: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_fastareorder

### Tool Description
Reorder sequences in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. fastareorder
       [-h] [-i] fasta order_file output

Reorder sequences in a FASTA file.

positional arguments:
  fasta                 a FASTA file of sequences to reorder
  order_file            a file with the sequence order
  output                an output FASTA file of reordered sequences

optional arguments:
  -h, --help            show this help message and exit
  -i, --ignore_missing  ignore sequences in the specified order file that are
                        missing in the input FASTA file
```


## bioformats_flanknfilter

### Tool Description
Given features from a BED or VCF file, check if they contain N's in their flanking regions of the specified length.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. flanknfilter
       [-h] [-t {bed,vcf}] [-l LENGTH] [-s] input_file fasta_file output_file

Given features from a BED or VCF file, check if they contain N's in their
flanking regions of the specified length.

positional arguments:
  input_file            an input file of features to be filtered
  fasta_file            a FASTA file of sequences the features are related to
  output_file           an output file of filtered features

optional arguments:
  -h, --help            show this help message and exit
  -t {bed,vcf}, --type {bed,vcf}
                        the input file type (default: bed)
  -l LENGTH, --length LENGTH
                        the flanking region length (default: 100)
  -s, --strict          require flanks to have exactly the specified length
                        (it may be shorter if a feature is located near a
                        sequence start or end) (default: False)
```


## bioformats_gff2bed

### Tool Description
Convert a GFF3 file to the BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. gff2bed
       [-h] [-a [ATTRIBUTES [ATTRIBUTES ...]]] [-n NAME_TAG]
       [-m MISSING_VALUE] [-g] [-p PARENT_TAG] [--no_order_check]
       gff_file type output_file

Convert a GFF3 file to the BED format.

positional arguments:
  gff_file              a GFF3 file
  type                  type of features to be processed
  output_file           the output file in the BED format

optional arguments:
  -h, --help            show this help message and exit
  -a [ATTRIBUTES [ATTRIBUTES ...]], --attributes [ATTRIBUTES [ATTRIBUTES ...]]
                        attributes to include to the output BED file (default:
                        None)
  -n NAME_TAG, --name_tag NAME_TAG
                        an attribute tag of a feature name (default: None)
  -m MISSING_VALUE, --missing_value MISSING_VALUE
                        the missing tag value (default: NA)
  -g, --genes           output a BED12 file of genes (default: False)
  -p PARENT_TAG, --parent_tag PARENT_TAG
                        an attribute tag of exon genes (default: Parent)
  --no_order_check      do not check the order of GFF3 file records (default:
                        False)
```


## bioformats_gff2to3

### Tool Description
Convert GFF2 files to GFF3 format using the bioformats toolset.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. gff2to3
       [-h] [-i] gff2_file output_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. gff2to3: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_gfftagstat

### Tool Description
Extract tag statistics from a GFF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. gfftagstat
       [-h] [-s SOURCE] [-t TYPE] gff_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. gfftagstat: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_interval2bed

### Tool Description
Convert interval files to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. interval2bed
       [-h] interval_file bed_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. interval2bed: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_ncbirenameseq

### Tool Description
Change NCBI-style sequence names in a FASTA file or plain text tabular file

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. ncbirenameseq
       [-h] [-f] [-c COLUMN] [--comment_char COMMENT_CHAR] [-s SEPARATOR]
       [--chr CHR] [--unloc UNLOC] [--unpl UNPL] [--prefix PREFIX]
       [--prefix_chr PREFIX_CHR] [--prefix_unloc PREFIX_UNLOC]
       [--prefix_unpl PREFIX_UNPL] [--suffix SUFFIX] [--suffix_chr SUFFIX_CHR]
       [--suffix_unloc SUFFIX_UNLOC] [--suffix_unpl SUFFIX_UNPL] [-r]
       [--no_version] [--no_description] [--output_table OUTPUT_TABLE]
       input_file
       {refseq_full,genbank_full,refseq_gi,genbank_gi,refseq,genbank,chr_refseq,chr_genbank}
       output_file
       {refseq_full,genbank_full,refseq_gi,genbank_gi,refseq,genbank,chr_refseq,chr_genbank,ucsc}

Change NCBI-style sequence names in a FASTA fileor plain text tabular file

positional arguments:
  input_file            a file to change sequence names in
  {refseq_full,genbank_full,refseq_gi,genbank_gi,refseq,genbank,chr_refseq,chr_genbank}
                        a format of sequence names in input
  output_file           an output file for renamed sequences
  {refseq_full,genbank_full,refseq_gi,genbank_gi,refseq,genbank,chr_refseq,chr_genbank,ucsc}
                        a format of sequence names in output

optional arguments:
  -h, --help            show this help message and exit
  -f, --fasta           the input file is of the FASTA format
  -c COLUMN, --column COLUMN
                        the number of the column that contains sequence names to be changed (1 by default)
  --comment_char COMMENT_CHAR
                        a character designating comment lines in the specified plain text file
  -s SEPARATOR, --separator SEPARATOR
                        a symbol separating columns in the specified plain text file
  --chr CHR             a name of a file containing NCBI chromosome accession numbers
  --unloc UNLOC         a name of a file containing NCBI accession numbers of unlocalized fragments
  --unpl UNPL           a name of a file containing NCBI accession numbers of unplaced fragments
  --prefix PREFIX       a prefix to be added to sequence names
  --prefix_chr PREFIX_CHR
                        a prefix to be added to chromosome names
  --prefix_unloc PREFIX_UNLOC
                        a prefix to be added to unlocalized fragment names
  --prefix_unpl PREFIX_UNPL
                        a prefix to be added to unplaced fragment names
  --suffix SUFFIX       a suffix to be added to sequence names
  --suffix_chr SUFFIX_CHR
                        a suffix to be added to chromosome names
  --suffix_unloc SUFFIX_UNLOC
                        a suffix to be added to unlocalized fragment names
  --suffix_unpl SUFFIX_UNPL
                        a suffix to be added to unplaced fragment names
  -r, --revert          perform reverse renaming, that is, change original and new names in the renaming table
  --no_version          remove a sequence version from an accession number
  --no_description      remove descriptions from FASTA sequence headers
  --output_table OUTPUT_TABLE
                        write the renaming table to the specified file

Format values: 
	refseq_full:	gi|568815597|ref|NC_000001.11|
	genbank_full:	gi|568336023|gb|CM000663.2|
	refseq_gi:	568815597
	genbank_gi:	568336023
	refseq: 	NC_000001.11
	genbank:	CM000663.2
	chr_refseq:	1_NC_000001.11
	chr_genbank:	1_CM000663.2
```


## bioformats_randomfasta

### Tool Description
Generate a random FASTA file with specified sequence length and number of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. randomfasta
       [-h] seq_length seq_num output
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. randomfasta: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_renameseq

### Tool Description
Change sequence names in a FASTA or plain text tabular file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. renameseq
       [-h] [-f] [-c COLUMN] [-r] [--no_description]
       [--comment_char COMMENT_CHAR] [-s SEPARATOR]
       renaming_table input_file output_file

Change sequence names in a FASTA or plain text tabular file.

positional arguments:
  renaming_table        a file containing a table of original and new sequence
                        names
  input_file            a file to change sequence names in
  output_file           an output file with renamed sequences

optional arguments:
  -h, --help            show this help message and exit
  -f, --fasta           the input file is of the FASTA format
  -c COLUMN, --column COLUMN
                        the number of the column that contains sequence names
                        to be changed staring from 1
  -r, --revert          perform reverse renaming, that is, change original and
                        new names in the renaming table
  --no_description      remove descriptions from FASTA sequence names
  --comment_char COMMENT_CHAR
                        a character that designates comment lines in the
                        specified plain-text file
  -s SEPARATOR, --separator SEPARATOR
                        a symbol that separates columns in the specified
                        plain-text file
```


## bioformats_rmout2bed

### Tool Description
Convert a RepeatMasker out file to the BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. rmout2bed
       [-h] [-c {class,identity,class_identity}]
       [-n {id,name,class,family,class_family}] [-s]
       rmout_file bed_file

Convert a RepeatMasker out file to the BED format.

positional arguments:
  rmout_file            a RepeatMasker out file
  bed_file              the output BED file

optional arguments:
  -h, --help            show this help message and exit
  -c {class,identity,class_identity}, --color {class,identity,class_identity}
                        how to choose colors of BED repeat records (default:
                        class)
  -n {id,name,class,family,class_family}, --name {id,name,class,family,class_family}
                        how to choose names of BED repeat records (default:
                        id)
  -s, --short           output only repeat loci (the output is a BED3 file)
                        (default: False)
```


## bioformats_snpeff2bed

### Tool Description
Convert SnpEff VCF files to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. snpeff2bed
       [-h] [--bed3] vcf_file bed_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. snpeff2bed: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_snpeff2pph

### Tool Description
Convert SnpEff annotated VCF files to PolyPhen-2 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. snpeff2pph
       [-h] vcf_file output_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. snpeff2pph: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_vcf2bed

### Tool Description
Convert VCF files to BED format using the bioformats toolset.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. vcf2bed
       [-h] vcf_file bed_file
bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. vcf2bed: error: argument -h/--help: ignored explicit argument 'elp'
```


## bioformats_vcfeffect2bed

### Tool Description
Given an snpEff-annotated VCF file, extract its sample genotype effects.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. vcfeffect2bed
       [-h]
       [-i {HIGH,MODERATE,LOW,MODIFIER} [{HIGH,MODERATE,LOW,MODIFIER} ...]]
       [-g {REFHET,COMHET,ALTHOM} [{REFHET,COMHET,ALTHOM} ...]]
       [--ignore_errors]
       vcf_file output_file

Given an snpEff-annotated VCF file, extract its sample genotype effects.

positional arguments:
  vcf_file              an snpEff-annotated VCF file
  output_file           the output BED3+ file of sample effects

optional arguments:
  -h, --help            show this help message and exit
  -i {HIGH,MODERATE,LOW,MODIFIER} [{HIGH,MODERATE,LOW,MODIFIER} ...], --impacts {HIGH,MODERATE,LOW,MODIFIER} [{HIGH,MODERATE,LOW,MODIFIER} ...]
                        impacts of effects to be reported
  -g {REFHET,COMHET,ALTHOM} [{REFHET,COMHET,ALTHOM} ...], --genotypes {REFHET,COMHET,ALTHOM} [{REFHET,COMHET,ALTHOM} ...]
  --ignore_errors       ignore errors in an input file

Genotype values:
	REFHET - a heterozygote with one reference allele
	COMHET - a heterozygote with both alternative alleles
	ALTHOM - an alternative homozygote
```


## bioformats_vcfgeno2bed

### Tool Description
Given a VCF file, extract genotype counts from it and write them to the specified file in the BED3+ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioformats:0.1.15--py27_0
- **Homepage**: https://github.com/gtamazian/bioformats
- **Package**: https://anaconda.org/channels/bioconda/packages/bioformats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioformats [command] [-h] [-v]
Please specify the command or use -h to view the help message. vcfgeno2bed
       [-h] [-i INDIVIDUALS] vcf_file output_file

Given a VCF file, extract genotype counts from it and write them to the
specified file in the BED3+ format.

positional arguments:
  vcf_file              a VCF file
  output_file           the output BED3+ file of genotype counts

optional arguments:
  -h, --help            show this help message and exit
  -i INDIVIDUALS, --individuals INDIVIDUALS
                        a file with the list of individuals to be considered
                        for genotype counting
```


## Metadata
- **Skill**: generated
