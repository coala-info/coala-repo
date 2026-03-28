# phava CWL Generation Report

## phava_variation_wf

### Tool Description
PhaVa variation workflow

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Total Downloads**: 789
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/patrickwest/PhaVa
- **Stars**: N/A
### Original Help Text
```text
usage: phava variation_wf [-h] -d DIR [-t CPUS] [-l] [-i FASTA] [-f FLANKSIZE]
                          [--genes GENES] [--genesFormat {gff,gbff}]
                          [--mockGenome] [--mockNumber MOCKNUMBER] [-r FASTQ]
                          [-c MINRC] [-m MAXMISMATCH] [--keepSam]
                          [--reportAll] [-s] [-r2 FASTQ2]

options:
  -h, --help            show this help message and exit

REQUIRED PARAMETERS:
  -d DIR, --dir DIR     Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** (default: None)

SYSTEM PARAMETERS:
  -t CPUS, --cpus CPUS  Number of threads to use (default: 1)
  -l, --log             Should the logging info be output to stdout?
                        Otherwise, it will be written to 'PhaVa.log' (default:
                        False)

LOCATE PARAMETERS:
  -i FASTA, --fasta FASTA
                        Name of input assembly file to be searched (default:
                        None)

CREATE PARAMETERS:
  -f FLANKSIZE, --flankSize FLANKSIZE
                        Size flanking size to include on either side of
                        invertable regions (in bps) (default: 1000)
  --genes GENES         List of gene features in ncbi genbank format, for
                        detecting gene/inverton overlaps (default: None)
  --genesFormat {gff,gbff}
                        File format of the list of gene features. Gff must be
                        in prodigal gff format (default: gbff)
  --mockGenome          Create a mock genome where all putative IRs are
                        flipped to opposite of the reference orientation
                        (default: False)
  --mockNumber MOCKNUMBER
                        If creating a mockGenome, the number of invertons to
                        invert. A value of 0 inverts all predicted inverton
                        locations (default: 0)

RATIO PARAMETERS:
  -r FASTQ, --fastq FASTQ
                        Name of the reads file to be used for mapping
                        (default: None)
  -c MINRC, --minRC MINRC
                        The minimum count of mapped reads to an 'inverted'
                        inverton for it to be reported in the output (default:
                        3)
  -m MAXMISMATCH, --maxMismatch MAXMISMATCH
                        Maximum proportion of inverton sequence that can be
                        mismatch before a read is removed (default: 0.15)
  --keepSam             Keep the sam file from the mapping (default: False)
  --reportAll           Report mapping results for all putative invertons,
                        regardless of outcome (default: False)
  -s, --short-reads     Run the pipeline with short reads instead of long
                        reads (default: False)
  -r2 FASTQ2, --fastq2 FASTQ2
                        Name of the file with reverse reads to be used for
                        mapping (only for paired short reads!) (default: None)
```


## phava_into

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: phava [-h]
             {locate,create,ratio,variation_wf,summarize,cluster,test} ...
phava: error: argument operation: invalid choice: 'into' (choose from 'locate', 'create', 'ratio', 'variation_wf', 'summarize', 'cluster', 'test')
```


## phava_locate

### Tool Description
Directory where data and output are stored *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS ***

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phava locate [-h] -d DIR [-t CPUS] [-l] [-i FASTA]

options:
  -h, --help            show this help message and exit

REQUIRED PARAMETERS:
  -d DIR, --dir DIR     Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** (default: None)

SYSTEM PARAMETERS:
  -t CPUS, --cpus CPUS  Number of threads to use (default: 1)
  -l, --log             Should the logging info be output to stdout?
                        Otherwise, it will be written to 'PhaVa.log' (default:
                        False)

LOCATE PARAMETERS:
  -i FASTA, --fasta FASTA
                        Name of input assembly file to be searched (default:
                        None)
```


## phava_create

### Tool Description
Create PhaVa data structures

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phava create [-h] -d DIR [-t CPUS] [-l] [-f FLANKSIZE] [--genes GENES]
                    [--genesFormat {gff,gbff}] [--mockGenome]
                    [--mockNumber MOCKNUMBER] [-i FASTA] [--irs IRS]

options:
  -h, --help            show this help message and exit

REQUIRED PARAMETERS:
  -d DIR, --dir DIR     Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** (default: None)

SYSTEM PARAMETERS:
  -t CPUS, --cpus CPUS  Number of threads to use (default: 1)
  -l, --log             Should the logging info be output to stdout?
                        Otherwise, it will be written to 'PhaVa.log' (default:
                        False)

CREATE PARAMETERS:
  -f FLANKSIZE, --flankSize FLANKSIZE
                        Size flanking size to include on either side of
                        invertable regions (in bps) (default: 1000)
  --genes GENES         List of gene features in ncbi genbank format, for
                        detecting gene/inverton overlaps (default: None)
  --genesFormat {gff,gbff}
                        File format of the list of gene features. Gff must be
                        in prodigal gff format (default: gbff)
  --mockGenome          Create a mock genome where all putative IRs are
                        flipped to opposite of the reference orientation
                        (default: False)
  --mockNumber MOCKNUMBER
                        If creating a mockGenome, the number of invertons to
                        invert. A value of 0 inverts all predicted inverton
                        locations (default: 0)

CREATE SPECIFIC PARAMETERS:
  -i FASTA, --fasta FASTA
                        Name of input assembly file to be searched (default:
                        None)
  --irs IRS             Table of identified invertable repeats (eg. if locate
                        command was never run) (default: None)
```


## phava_ratio

### Tool Description
Run the pipeline with short reads instead of long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phava ratio [-h] -d DIR [-t CPUS] [-l] [-r FASTQ] [-c MINRC]
                   [-m MAXMISMATCH] [--keepSam] [--reportAll] [-s]
                   [-r2 FASTQ2] [--inv INV]

options:
  -h, --help            show this help message and exit

REQUIRED PARAMETERS:
  -d DIR, --dir DIR     Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** (default: None)

SYSTEM PARAMETERS:
  -t CPUS, --cpus CPUS  Number of threads to use (default: 1)
  -l, --log             Should the logging info be output to stdout?
                        Otherwise, it will be written to 'PhaVa.log' (default:
                        False)

RATIO PARAMETERS:
  -r FASTQ, --fastq FASTQ
                        Name of the reads file to be used for mapping
                        (default: None)
  -c MINRC, --minRC MINRC
                        The minimum count of mapped reads to an 'inverted'
                        inverton for it to be reported in the output (default:
                        3)
  -m MAXMISMATCH, --maxMismatch MAXMISMATCH
                        Maximum proportion of inverton sequence that can be
                        mismatch before a read is removed (default: 0.15)
  --keepSam             Keep the sam file from the mapping (default: False)
  --reportAll           Report mapping results for all putative invertons,
                        regardless of outcome (default: False)
  -s, --short-reads     Run the pipeline with short reads instead of long
                        reads (default: False)
  -r2 FASTQ2, --fastq2 FASTQ2
                        Name of the file with reverse reads to be used for
                        mapping (only for paired short reads!) (default: None)

RATIO SPECIFIC PARAMETERS:
  --inv INV             Fasta file of forward and inverted repeats (ie.
                        generated from create command) (default: None)
```


## phava_orientation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: phava [-h]
             {locate,create,ratio,variation_wf,summarize,cluster,test} ...
phava: error: argument operation: invalid choice: 'orientation' (choose from 'locate', 'create', 'ratio', 'variation_wf', 'summarize', 'cluster', 'test')
```


## phava_summarize

### Tool Description
Directory where data and output are stored

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phava summarize [-h] -d DIR [-t CPUS] [-l]

options:
  -h, --help            show this help message and exit

REQUIRED PARAMETERS:
  -d DIR, --dir DIR     Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** (default: None)

SYSTEM PARAMETERS:
  -t CPUS, --cpus CPUS  Number of threads to use (default: 1)
  -l, --log             Should the logging info be output to stdout?
                        Otherwise, it will be written to 'PhaVa.log' (default:
                        False)
```


## phava_cluster

### Tool Description
Cluster PhaVa database

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phava cluster [-h] -d DIR [-t CPUS] [-l] [-p PIDENT] [-n NEW_DIR]
                     [-f FLANKSIZE]

options:
  -h, --help            show this help message and exit

REQUIRED PARAMETERS:
  -d DIR, --dir DIR     Directory where data and output are stored    
                        *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** (default: None)

SYSTEM PARAMETERS:
  -t CPUS, --cpus CPUS  Number of threads to use (default: 1)
  -l, --log             Should the logging info be output to stdout?
                        Otherwise, it will be written to 'PhaVa.log' (default:
                        False)

CLUSTER PARAMETERS:
  -p PIDENT, --pident PIDENT
                        Percent identity for the clustering (default: 0.95)
  -n NEW_DIR, --new_dir NEW_DIR
                        New PhaVa directory for the clustered database
                        (defaults to '-d' if not supplied or './phava_out' for
                        multiple genomes). To cluster the invertons from
                        multiple genomes, supply a comma-separated list of
                        PhaVa directories to the '-d' parameter (default:
                        ./phava_out)
  -f FLANKSIZE, --flankSize FLANKSIZE
                        Size flanking size to include on either side of
                        invertable regions (in bps) (default: 1000)
```


## phava_test

### Tool Description
PhaVa tool for locating, creating, and analyzing inverted repeats.

### Metadata
- **Docker Image**: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/patrickwest/PhaVa
- **Package**: https://anaconda.org/channels/bioconda/packages/phava/overview
- **Validation**: PASS

### Original Help Text
```text
PhaVa Locate:
INFO:root:------Beginning IR locating operation------
INFO:root:------Beginning IR search------
INFO:root:einverted -maxrepeat 750  -gap 100 -threshold 51 -match 5 -mismatch -9 -outfile /usr/local/tests/test_outputs/intermediate/einverted.51.outfile -outseq /usr/local/tests/test_outputs/intermediate/einverted.51.outseq -sequence /usr/local/tests/test_small.fna
INFO:root:b'Find inverted repeats in nucleotide sequences'
INFO:root:einverted -maxrepeat 750  -gap 100 -threshold 75 -match 5 -mismatch -15 -outfile /usr/local/tests/test_outputs/intermediate/einverted.75.outfile -outseq /usr/local/tests/test_outputs/intermediate/einverted.75.outseq -sequence /usr/local/tests/test_small.fna
INFO:root:b"Find inverted repeats in nucleotide sequences\nWarning: No sequences written to output file '/usr/local/tests/test_outputs/intermediate/einverted.75.outseq'"
INFO:root:------Finished IR search------
INFO:root:------Finished pickling IR database------
INFO:root:------Finished IR locating operation------


PhaVa Create:
INFO:root:------Beginning IR create operation------
INFO:root:------Beginning mock IR creation------
INFO:root:------Finished unpickling IR database------
INFO:root:------Finished mock IR creation------
INFO:root:------Finished pickling IR database------
INFO:root:------Finished IR create operation------


PhaVa Ratio:
INFO:root:------Beginning IR ratio operation------
INFO:root:------Beginning IR ratio calculation------
INFO:root:------Finished unpickling IR database------
INFO:root:minimap2 -a --MD -o /usr/local/tests/test_outputs/intermediate/simulated_reads.fastq_vs_test_small.fna.sam -t 1 /usr/local/tests/test_outputs/data/invertedSeqs.fasta /usr/local/tests/simulated_reads.fastq
test_genome:9567-9590-9803-9826	7	5	0.4166666666666667	simulated_reads.fastq
INFO:root:------Finished IR ratio calculation------
INFO:root:------Finished IR ratio operation------
```


## Metadata
- **Skill**: generated
