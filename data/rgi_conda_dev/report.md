# rgi_conda_dev CWL Generation Report

## rgi_conda_dev_rgi

### Tool Description
Resistance Gene Identifier - Version 3.1.2

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi_conda_dev:3.1.2--py27_1
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rgi_conda_dev/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: rgi [-h] [-t INTYPE] [-i INPUTSEQ] [-n THREADS] [-o OUTPUT]
           [-e CRITERIA] [-c CLEAN] [-d DATA] [-l VERBOSE] [-a ALIGNER]
           [-r DATABASE] [-sv] [-dv]

Resistance Gene Identifier - Version 3.1.2

optional arguments:
  -h, --help            show this help message and exit
  -t INTYPE, --input_type INTYPE
                        must be one of contig, orf, protein, read (default:
                        contig)
  -i INPUTSEQ, --input_sequence INPUTSEQ
                        input file must be in either FASTA (contig and
                        protein), FASTQ(read) or gzip format! e.g
                        myFile.fasta, myFasta.fasta.gz
  -n THREADS, --num_threads THREADS
                        Number of threads (CPUs) to use in the BLAST search
                        (default=32)
  -o OUTPUT, --output_file OUTPUT
                        Output JSON file (default=Report)
  -e CRITERIA, --loose_criteria CRITERIA
                        The options are YES to include loose hits and NO to
                        exclude loose hits. (default=NO to exclude loose hits)
  -c CLEAN, --clean CLEAN
                        This removes temporary files in the results directory
                        after run. Options are NO or YES (default=YES for
                        remove)
  -d DATA, --data DATA  Specify a data-type, i.e. wgs, chromosome, plasmid,
                        etc. (default = NA)
  -l VERBOSE, --verbose VERBOSE
                        log progress to file. Options are OFF or ON (default =
                        OFF for no logging)
  -a ALIGNER, --alignment_tool ALIGNER
                        choose between BLAST and DIAMOND. Options are BLAST or
                        DIAMOND (default = BLAST)
  -r DATABASE, --db DATABASE
                        specify path to CARD blast databases (default: None)
  -sv, --software_version
                        Prints software number
  -dv, --data_version   Prints data version number
```


## rgi_conda_dev_rgi main

### Tool Description
Resistance Gene Identifier - Version 3.1.2

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi_conda_dev:3.1.2--py27_1
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi [-h] [-t INTYPE] [-i INPUTSEQ] [-n THREADS] [-o OUTPUT]
           [-e CRITERIA] [-c CLEAN] [-d DATA] [-l VERBOSE] [-a ALIGNER]
           [-r DATABASE] [-sv] [-dv]

Resistance Gene Identifier - Version 3.1.2

optional arguments:
  -h, --help            show this help message and exit
  -t INTYPE, --input_type INTYPE
                        must be one of contig, orf, protein, read (default:
                        contig)
  -i INPUTSEQ, --input_sequence INPUTSEQ
                        input file must be in either FASTA (contig and
                        protein), FASTQ(read) or gzip format! e.g
                        myFile.fasta, myFasta.fasta.gz
  -n THREADS, --num_threads THREADS
                        Number of threads (CPUs) to use in the BLAST search
                        (default=32)
  -o OUTPUT, --output_file OUTPUT
                        Output JSON file (default=Report)
  -e CRITERIA, --loose_criteria CRITERIA
                        The options are YES to include loose hits and NO to
                        exclude loose hits. (default=NO to exclude loose hits)
  -c CLEAN, --clean CLEAN
                        This removes temporary files in the results directory
                        after run. Options are NO or YES (default=YES for
                        remove)
  -d DATA, --data DATA  Specify a data-type, i.e. wgs, chromosome, plasmid,
                        etc. (default = NA)
  -l VERBOSE, --verbose VERBOSE
                        log progress to file. Options are OFF or ON (default =
                        OFF for no logging)
  -a ALIGNER, --alignment_tool ALIGNER
                        choose between BLAST and DIAMOND. Options are BLAST or
                        DIAMOND (default = BLAST)
  -r DATABASE, --db DATABASE
                        specify path to CARD blast databases (default: None)
  -sv, --software_version
                        Prints software number
  -dv, --data_version   Prints data version number
```


## rgi_conda_dev_rgi bwt

### Tool Description
Resistance Gene Identifier - Version 3.1.2

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi_conda_dev:3.1.2--py27_1
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi [-h] [-t INTYPE] [-i INPUTSEQ] [-n THREADS] [-o OUTPUT]
           [-e CRITERIA] [-c CLEAN] [-d DATA] [-l VERBOSE] [-a ALIGNER]
           [-r DATABASE] [-sv] [-dv]

Resistance Gene Identifier - Version 3.1.2

optional arguments:
  -h, --help            show this help message and exit
  -t INTYPE, --input_type INTYPE
                        must be one of contig, orf, protein, read (default:
                        contig)
  -i INPUTSEQ, --input_sequence INPUTSEQ
                        input file must be in either FASTA (contig and
                        protein), FASTQ(read) or gzip format! e.g
                        myFile.fasta, myFasta.fasta.gz
  -n THREADS, --num_threads THREADS
                        Number of threads (CPUs) to use in the BLAST search
                        (default=32)
  -o OUTPUT, --output_file OUTPUT
                        Output JSON file (default=Report)
  -e CRITERIA, --loose_criteria CRITERIA
                        The options are YES to include loose hits and NO to
                        exclude loose hits. (default=NO to exclude loose hits)
  -c CLEAN, --clean CLEAN
                        This removes temporary files in the results directory
                        after run. Options are NO or YES (default=YES for
                        remove)
  -d DATA, --data DATA  Specify a data-type, i.e. wgs, chromosome, plasmid,
                        etc. (default = NA)
  -l VERBOSE, --verbose VERBOSE
                        log progress to file. Options are OFF or ON (default =
                        OFF for no logging)
  -a ALIGNER, --alignment_tool ALIGNER
                        choose between BLAST and DIAMOND. Options are BLAST or
                        DIAMOND (default = BLAST)
  -r DATABASE, --db DATABASE
                        specify path to CARD blast databases (default: None)
  -sv, --software_version
                        Prints software number
  -dv, --data_version   Prints data version number
```


## rgi_conda_dev_rgi kmer_query

### Tool Description
Resistance Gene Identifier - Version 3.1.2

### Metadata
- **Docker Image**: quay.io/biocontainers/rgi_conda_dev:3.1.2--py27_1
- **Homepage**: https://card.mcmaster.ca
- **Package**: https://anaconda.org/channels/bioconda/packages/rgi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rgi [-h] [-t INTYPE] [-i INPUTSEQ] [-n THREADS] [-o OUTPUT]
           [-e CRITERIA] [-c CLEAN] [-d DATA] [-l VERBOSE] [-a ALIGNER]
           [-r DATABASE] [-sv] [-dv]

Resistance Gene Identifier - Version 3.1.2

optional arguments:
  -h, --help            show this help message and exit
  -t INTYPE, --input_type INTYPE
                        must be one of contig, orf, protein, read (default:
                        contig)
  -i INPUTSEQ, --input_sequence INPUTSEQ
                        input file must be in either FASTA (contig and
                        protein), FASTQ(read) or gzip format! e.g
                        myFile.fasta, myFasta.fasta.gz
  -n THREADS, --num_threads THREADS
                        Number of threads (CPUs) to use in the BLAST search
                        (default=32)
  -o OUTPUT, --output_file OUTPUT
                        Output JSON file (default=Report)
  -e CRITERIA, --loose_criteria CRITERIA
                        The options are YES to include loose hits and NO to
                        exclude loose hits. (default=NO to exclude loose hits)
  -c CLEAN, --clean CLEAN
                        This removes temporary files in the results directory
                        after run. Options are NO or YES (default=YES for
                        remove)
  -d DATA, --data DATA  Specify a data-type, i.e. wgs, chromosome, plasmid,
                        etc. (default = NA)
  -l VERBOSE, --verbose VERBOSE
                        log progress to file. Options are OFF or ON (default =
                        OFF for no logging)
  -a ALIGNER, --alignment_tool ALIGNER
                        choose between BLAST and DIAMOND. Options are BLAST or
                        DIAMOND (default = BLAST)
  -r DATABASE, --db DATABASE
                        specify path to CARD blast databases (default: None)
  -sv, --software_version
                        Prints software number
  -dv, --data_version   Prints data version number
```

