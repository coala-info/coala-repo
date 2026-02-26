# rgi CWL Generation Report

## rgi

### Tool Description
Use the Resistance Gene Identifier to predict resistome(s) from protein or nucleotide data based on homology and SNP models. Check https://card.mcmaster.ca/download for software and data updates. Receive email notification of monthly CARD updates via the CARD Mailing List (https://mailman.mcmaster.ca/mailman/listinfo/card-l)

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Total Downloads**: 208.4K
- **Last updated**: 2025-09-01
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: rgi <command> [<args>]
            commands are:
               ---------------------------------------------------------------------------------------
               Database
               ---------------------------------------------------------------------------------------
               auto_load Automatically loads CARD database, annotations and k-mer database
               load      Loads CARD database, annotations and k-mer database
               clean     Removes BLAST databases and temporary files
               database  Information on installed card database
               galaxy    Galaxy project wrapper

               ---------------------------------------------------------------------------------------
               Genomic
               ---------------------------------------------------------------------------------------

               main     Runs rgi application
               tab      Creates a Tab-delimited from rgi results
               parser   Creates categorical JSON files RGI wheel visualization
               heatmap  Heatmap for multiple analysis

               ---------------------------------------------------------------------------------------
               Metagenomic
               ---------------------------------------------------------------------------------------
               bwt                   Align reads to CARD and in silico predicted allelic variants (beta)

               ---------------------------------------------------------------------------------------
               Baits validation
               ---------------------------------------------------------------------------------------
               tm                    Baits Melting Temperature

               ---------------------------------------------------------------------------------------
               Annotations
               ---------------------------------------------------------------------------------------
               card_annotation       Create fasta files with annotations from card.json
               wildcard_annotation   Create fasta files with annotations from variants
               baits_annotation      Create fasta files with annotations from baits (experimental)
               remove_duplicates     Removes duplicate sequences (experimental)

               ---------------------------------------------------------------------------------------
               Pathogen of origin
               ---------------------------------------------------------------------------------------

               kmer_build            Build AMR specific k-mers database used for pathogen of origin (beta)
               kmer_query            Query sequences against AMR k-mers database to predict pathogen of origin (beta)

               

Resistance Gene Identifier - 6.0.5

positional arguments:
  {main,tab,parser,load,auto_load,clean,galaxy,database,bwt,tm,card_annotation,wildcard_annotation,baits_annotation,remove_duplicates,heatmap,kmer_build,kmer_query}
                        Subcommand to run

options:
  -h, --help            show this help message and exit

Use the Resistance Gene Identifier to predict resistome(s) from protein or
nucleotide data based on homology and SNP models. Check
https://card.mcmaster.ca/download for software and data updates. Receive email
notification of monthly CARD updates via the CARD Mailing List
(https://mailman.mcmaster.ca/mailman/listinfo/card-l)
```


## rgi_rgi main

### Tool Description
Resistance Gene Identifier - 6.0.5 - Main

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi main [-h] -i INPUT_SEQUENCE -o OUTPUT_FILE [-t {contig,protein}]
                [-a {DIAMOND,BLAST}] [-n THREADS] [--include_loose]
                [--include_nudge] [--local] [--clean] [--keep] [--debug]
                [--low_quality] [-d {wgs,plasmid,chromosome,NA}] [-v]
                [-g {PRODIGAL,PYRODIGAL}] [--split_prodigal_jobs]

Resistance Gene Identifier - 6.0.5 - Main

options:
  -h, --help            show this help message and exit
  -i, --input_sequence INPUT_SEQUENCE
                        input file must be in either FASTA (contig and
                        protein) or gzip format! e.g myFile.fasta,
                        myFasta.fasta.gz
  -o, --output_file OUTPUT_FILE
                        output folder and base filename
  -t, --input_type {contig,protein}
                        specify data input type (default = contig)
  -a, --alignment_tool {DIAMOND,BLAST}
                        specify alignment tool (default = BLAST)
  -n, --num_threads THREADS
                        number of threads (CPUs) to use in the BLAST search
                        (default=20)
  --include_loose       include loose hits in addition to strict and perfect
                        hits (default: False)
  --include_nudge       include hits nudged from loose to strict hits
                        (default: False)
  --local               use local database (default: uses database in
                        executable directory)
  --clean               removes temporary files (default: False)
  --keep                keeps Prodigal CDS when used with --clean (default:
                        False)
  --debug               debug mode (default: False)
  --low_quality         use for short contigs to predict partial genes
                        (default: False)
  -d, --data {wgs,plasmid,chromosome,NA}
                        specify a data-type (default = NA)
  -v, --version         prints software version number
  -g, --orf_finder {PRODIGAL,PYRODIGAL}
                        specify ORF finding tool (default = PRODIGAL)
  --split_prodigal_jobs
                        run multiple prodigal jobs simultaneously for contigs
                        in a fasta file (default: False)
```


## rgi_rgi bwt

### Tool Description
Aligns metagenomic reads to CARD and wildCARD reference using kma, bowtie2 or bwa and provide reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi bwt [-h] -1 READ_ONE [-2 READ_TWO] [-a {kma,bowtie2,bwa}]
               [-n THREADS] -o OUTPUT_FILE [--debug] [--clean] [--local]
               [--include_wildcard] [--include_other_models] [--include_baits]
               [--mapq MAPQ] [--mapped MAPPED] [--coverage COVERAGE]

Resistance Gene Identifier - 6.0.5 - BWT 

Aligns metagenomic reads to CARD and wildCARD reference using kma, bowtie2 or bwa and provide reports.

options:
  -h, --help            show this help message and exit
  -1, --read_one READ_ONE
                        raw read one (qc and trimmed)
  -2, --read_two READ_TWO
                        raw read two (qc and trimmed)
  -a, --aligner {kma,bowtie2,bwa}
                        select read aligner (default=kma)
  -n, --threads THREADS
                        number of threads (CPUs) to use (default=20)
  -o, --output_file OUTPUT_FILE
                        name of output filename(s)
  --debug               debug mode (default=False)
  --clean               removes temporary files (default=False)
  --local               use local database (default: uses database in executable directory)
  --include_wildcard    include wildcard (default=False)
  --include_other_models
                        include protein variant, rRNA variant, knockout, and protein overexpression models (default=False)
  --include_baits       include baits (default=False)
  --mapq MAPQ           filter reads based on MAPQ score (default=False)
  --mapped MAPPED       filter reads based on mapped reads (default=False)
  --coverage COVERAGE   filter reads based on coverage of reference sequence
```


## rgi_rgi kmer_query

### Tool Description
Tests sequenes using CARD*kmers

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi kmer_query [-h] -i INPUT [--bwt] [--rgi] [--fasta] -k K [-m MIN]
                      [-n THREADS] -o OUTPUT [--local] [--debug]

Resistance Gene Identifier - 6.0.5 - Kmer Query 

Tests sequenes using CARD*kmers

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input file (bam file from RGI*BWT, json file of RGI results, fasta file of sequences)
  --bwt                 Specify if the input file for analysis is a bam file generated from RGI*BWT
  --rgi                 Specify if the input file is a RGI results json file
  --fasta               Specify if the input file is a fasta file of sequences
  -k, --kmer_size K     length of k
  -m, --minimum MIN     Minimum number of kmers in the called category for the classification to be made (default=10).
  -n, --threads THREADS
                        number of threads (CPUs) to use (default=1)
  -o, --output OUTPUT   Output file name.
  --local               use local database (default: uses database in executable directory)
  --debug               debug mode
```


## rgi_rgi load

### Tool Description
Resistance Gene Identifier - 6.0.5 - Load

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi load [-h] -i CARD_JSON [--card_annotation CARD_ANNOTATION]
                [--card_annotation_all_models CARD_ANNOTATION_ALL_MODELS]
                [--wildcard_annotation WILDCARD_ANNOTATION]
                [--wildcard_annotation_all_models WILDCARD_ANNOTATION_ALL_MODELS]
                [--wildcard_index WILDCARD_INDEX]
                [--wildcard_version WILDCARD_VERSION]
                [--baits_annotation BAITS_ANNOTATION]
                [--baits_index BAITS_INDEX] [--kmer_database KMER_DATABASE]
                [--amr_kmers AMR_KMERS] [--kmer_size KMER_SIZE] [--local]
                [--debug]

Resistance Gene Identifier - 6.0.5 - Load

options:
  -h, --help            show this help message and exit
  -i, --card_json CARD_JSON
                        must be a card database json file
  --card_annotation CARD_ANNOTATION
                        annotated reference FASTA for homolog models only,
                        created using rgi card_annotation
  --card_annotation_all_models CARD_ANNOTATION_ALL_MODELS
                        annotated reference FASTA which includes all models
                        created using rgi card_annotation
  --wildcard_annotation WILDCARD_ANNOTATION
                        annotated reference FASTA for homolog models only,
                        created using rgi wildcard_annotation
  --wildcard_annotation_all_models WILDCARD_ANNOTATION_ALL_MODELS
                        annotated reference FASTA which includes all models
                        created using rgi wildcard_annotation
  --wildcard_index WILDCARD_INDEX
                        wildcard index file (index-for-model-sequences.txt)
  --wildcard_version WILDCARD_VERSION
                        specify variants version used
  --baits_annotation BAITS_ANNOTATION
                        annotated reference FASTA
  --baits_index BAITS_INDEX
                        baits index file (baits-probes-with-sequence-info.txt)
  --kmer_database KMER_DATABASE
                        json of kmer database
  --amr_kmers AMR_KMERS
                        txt file of all amr kmers
  --kmer_size KMER_SIZE
                        kmer size if loading kmer files
  --local               use local database (default: uses database in
                        executable directory)
  --debug               debug mode
```


## rgi_rgi heatmap

### Tool Description
Creates a heatmap when given multiple RGI results.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi heatmap [-h] -i INPUT
                   [-cat {drug_class,resistance_mechanism,gene_family}] [-f]
                   [-o OUTPUT] [-clus {samples,genes,both}]
                   [-d {plain,fill,text}] [--debug]

Resistance Gene Identifier - 6.0.5 - Heatmap 

Creates a heatmap when given multiple RGI results.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Directory containing the RGI .json files (REQUIRED)
  -cat, --category {drug_class,resistance_mechanism,gene_family}
                        The option to organize resistance genes based on a category.
  -f, --frequency       Represent samples based on resistance profile.
  -o, --output OUTPUT   Name for the output EPS and PNG files.
                        The number of files run will automatically 
                        be appended to the end of the file name.(default=RGI_heatmap)
  -clus, --cluster {samples,genes,both}
                        Option to use SciPy's hiearchical clustering algorithm to cluster rows (AMR genes) or columns (samples).
  -d, --display {plain,fill,text}
                        Specify display options for categories (deafult=plain).
  --debug               debug mode
```

