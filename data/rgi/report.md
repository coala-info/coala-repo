# rgi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rgi_rgi_auto_load | PASS | downloads and loads the current CARD release with k-mers (about 8 GB of output); loaded_databases.json shows CARD 4.0.2 and 61-mers |
| rgi_rgi_bwt | PASS | synthetic data: paired reads simulated from the real pBR322 and pUC19 plasmid sequences; TEM-1 and tet(C) found |
| rgi_rgi_card_annotation | PASS |  |
| rgi_rgi_heatmap | PASS |  |
| rgi_rgi_kmer_build | Not completed | needs the large CARD prevalence data directory; without it the tool crashes (None path) |
| rgi_rgi_kmer_query | PASS | needs the 8 GB local database from rgi auto_load (--local); 1070 AMR k-mers found in pBR322 |
| rgi_rgi_load | PASS |  |
| rgi_rgi_main | PASS |  |
| rgi_rgi_parser | PASS |  |
| rgi_rgi_remove_duplicates | PASS | synthetic data: three planted prevalence records made from a real CARD sequence (duplicate and shorter copy removed); real prevalence data is very large |
| rgi_rgi_tab | PASS |  |
| rgi_rgi_tm | Failed | image problem: melt.pl (UNAFold) stops with 'stack file is corrupt', so the output is an empty JSON |
| rgi_rgi_wildcard_annotation | Not completed | needs the WildCARD variants download (about 1 GB) and was not fetched |

## rgi_rgi_main

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


## rgi_rgi_bwt

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


## rgi_rgi_kmer_query

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


## rgi_rgi_load

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


## rgi_rgi_heatmap

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


## rgi_rgi_tab

### Tool Description
Creates a tab-delimited file from an RGI JSON result file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi tab [-h] -i AFILE

Resistance Gene Identifier - 6.0.5 - Tab-delimited

options:
  -h, --help         show this help message and exit
  -i, --afile AFILE  must be a rgi json result file
```

## rgi_rgi_parser

### Tool Description
Creates categorical JSON files for the RGI wheel visualization.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi parser [-h] -i INPUT [-o OUTPUT] [--include_loose] [-t TYPE]

Resistance Gene Identifier - 6.0.5 - Parser 

Creates categorical .json files RGI wheel visualization. An input .json file containing the RGI results must be input.

options:
  -h, --help           show this help message and exit
  -i, --input INPUT    RGI results in a .json file
  -o, --output OUTPUT  Name/identifier for the output categorical .json files
  --include_loose      Include loose hits in addition to strict and perfect hits
  -t, --type TYPE      type of input sequence: contig, protein or read
```

## rgi_rgi_card_annotation

### Tool Description
Creates card annotations for RGI BWT from card.json.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi card_annotation [-h] -i INPUT [--ncbi] [--debug]

Resistance Gene Identifier - 6.0.5 - CARD Annotation 

Creates card annotations for RGI BWT from card.json

options:
  -h, --help         show this help message and exit
  -i, --input INPUT  card.json file
  --ncbi             adds ncbi accession to FASTA headers (default: False)
  --debug            debug mode (default: False)
```

## rgi_rgi_remove_duplicates

### Tool Description
Removes duplicate sequences from an annotated FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi remove_duplicates [-h] -i INPUT_FASTA_FILE
                             --card_annotation CARD_ANNOTATION
                             -o OUTPUT_FASTA_FILE [--debug]

Resistance Gene Identifier - 6.0.5 - Remove duplicates 

Removes duplicates sequences from annotationed fasta file.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT_FASTA_FILE
                        input fasta file
  --card_annotation CARD_ANNOTATION
                        card_annotation input fasta file
  -o, --output OUTPUT_FASTA_FILE
                        output fasta file
  --debug               debug mode
```

## rgi_rgi_tm

### Tool Description
Calculates the melting temperature of baits (probes).

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi tm [-h] [-i INPUT_FILE] [-o OUTPUT_FILE] [-t FILTER_TEMPERATURE]
              [--clean] [--debug]

Resistance Gene Identifier - 6.0.5 - TM

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        input_file
  -o, --output_file OUTPUT_FILE
                        output_file
  -t, --filter_temperature FILTER_TEMPERATURE
                        desired melting temperature (default=65).
  --clean               removes temporary files
  --debug               debug mode
```

## rgi_rgi_kmer_build

### Tool Description
Builds the k-mer sets for CARD*kmers.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi kmer_build [-h] [-i INPUT_DIRECTORY] -c CARD_FASTA -k K [--skip]
                      [-n THREADS] [--batch_size BATCH_SIZE]

Resistance Gene Identifier - 6.0.5 - Kmer Build 

Builds the kmer sets for CARD*kmers

options:
  -h, --help            show this help message and exit
  -i, --input_directory INPUT_DIRECTORY
                        input directory of prevalence data
  -c, --card CARD_FASTA
                        fasta file of CARD reference sequences. If missing, run 'rgi card_annotation' to generate.
  -k K                  k-mer size (e.g., 61)
  --skip                skips the concatenation and splitting of the CARD*R*V sequences.
  -n, --threads THREADS
                        number of threads (CPUs) to use (default=1)
  --batch_size BATCH_SIZE
                        number of kmers to query at a time using pyahocorasick--the greater the number the more memory usage (default=100,000)
```

## rgi_rgi_wildcard_annotation

### Tool Description
Creates card annotations for RGI BWT from Variants or WildCARD data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi wildcard_annotation [-h] -i INPUT_DIRECTORY -v VERSION -j CARD_JSON
                               [--debug]

Resistance Gene Identifier - 6.0.5 - WildCARD Annotation 

Creates card annotations for RGI BWT from Variants or Wilcard data

options:
  -h, --help            show this help message and exit
  -i, --input_directory INPUT_DIRECTORY
                        input directory for wildcard
  -v, --version VERSION
                        specify version downloaded for wildcard / variants
  -j, --card_json CARD_JSON
                        card.json file
  --debug               debug mode (default: False)
```

## rgi_rgi_auto_load

### Tool Description
Automatically loads the CARD database, annotations and k-mer database.

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi auto_load [-h] [--local] [--clean] [--debug]

Resistance Gene Identifier - 6.0.5 - Automatic Load

options:
  -h, --help  show this help message and exit
  --local     use local database (default: uses database in executable
              directory)
  --clean     removes temporary files
  --debug     debug mode
```

## Metadata
- **Skill**: generated
