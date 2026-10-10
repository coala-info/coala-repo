# metabuli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metabuli_build | PASS |  |
| metabuli_classifiedRefiner | Failed | tool bug: always prints that the refined file already exists and writes nothing |
| metabuli_classify | PASS | tiny nf-core sarscov2 database built with metabuli build; all 100 read pairs classified to SARS-CoV-2 |
| metabuli_database-report | PASS |  |
| metabuli_extract | PASS |  |
| metabuli_make-report | Failed | tool bug: stoi crash on the header line of the classify output; with the header removed the report is empty |
| metabuli_updateDB | PASS | synthetic data: the nf-core insect mitochondrial genome was mapped to an existing taxid to test the merge; the database grew |
| metabuli_validatedb | PASS |  |

## metabuli_classify

### Tool Description
By Jaebeom Kim <jbeom0731@gmail.com>

#

## metabuli_build

### Tool Description
Build a Metabuli database from a list of FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli build <database directory> <FASTA list> <accesssion2taxid> [options]
options:                        
 --taxonomy-path STR     Directory where the taxonomy dump files are stored []
 --split-num INT         A database is divided to N splits (offsets). During classification, unnecessary splits are skipped [4096]
 --accession-level INT   Build or search a database for accession-level classification [0]
 --db-name STR           Name of the database [475736873]
 --db-date STR           Date of the database creation [2026-10-10]
 --cds-info STR          List of CDS files []
 --max-ram INT           RAM usage in GiB [128]
 --make-library INT      Make library. [0]
 --gtdb INT              GTDB-based database creation [0]
 --validate-input INT    Validate format of input FASTA/FASTQ file(s) [0]
 --validate-db INT       Validate the database. It checks if all required files are present and if the k-mer count is consistent. [0]
                       
 --threads INT           Number of CPU-cores used (all by default) [20]

references:

Show an extended list of options by calling 'metabuli build -h'.
```

## metabuli_updateDB

### Tool Description
Add new sequences to an existing Metabuli database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli updateDB  <new database directory> <FASTA list> <accesssion2taxid> <old database directory> [options]
options:                        
 --split-num INT         A database is divided to N splits (offsets). During classification, unnecessary splits are skipped [4096]
 --accession-level INT   Build or search a database for accession-level classification [0]
 --db-name STR           Name of the database [475736873]
 --db-date STR           Date of the database creation [2026-10-10]
 --cds-info STR          List of CDS files []
 --max-ram INT           RAM usage in GiB [128]
 --new-taxa STR          TSV file of new taxa to be added []
 --make-library INT      Make library. [0]
 --gtdb INT              GTDB-based database creation [0]
 --validate-input INT    Validate format of input FASTA/FASTQ file(s) [0]
 --validate-db INT       Validate the database. It checks if all required files are present and if the k-mer count is consistent. [0]
                       
 --threads INT           Number of CPU-cores used (all by default) [20]

references:

Show an extended list of options by calling 'metabuli updateDB -h'.
```

## metabuli_database-report

### Tool Description
Generate a taxonomy report of a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli database-report <i: database directory>  [options]
options:                      
 --taxonomy-path STR   Directory where the taxonomy dump files are stored [DBDIR/taxonomy/]

references:
```

## metabuli_validatedb

### Tool Description
Validate a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli validatedb <i: database directory>
options: 
references:
```

## metabuli_extract

### Tool Description
Extract reads classified to a certain taxon.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli extract <i:query file(s)> <i:read-by-read result> <i:database directory> [options]
options:                       
 --taxonomy-path STR    Directory where the taxonomy dump files are stored []
 --seq-mode INT         Single-end: 1, Paired-end: 2, Long read: 3 [2]
 --tax-id INT           Tax. ID of clade to be extracted [0]
 --extract-format INT   0: original format, 1: FASTA, 2: FASTQ [0]
 --outdir STR           Output directory []

references:
```

## metabuli_make-report

### Tool Description
Generate a Kraken-style taxonomy report using read-by-read classifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli make-report <i:Binning Result> <o:OUT DIR> <o:JOB ID> <i: TAXONOMY DIR>  [options]
options:                   
 --readid-col INT   Column number of accession in classification result [1]
 --taxid-col INT    Column number of taxonomy ID in classification result [2]

references:
```

## metabuli_classifiedRefiner

### Tool Description
Refine a read-by-read classification file.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metabuli classifiedRefiner <i: classified file> <i: taxonomy dump> [options]
options:                            
 --remove-unclassified BOOL  Remove unclassified reads [0]
 --exclude-taxid STR         Exclude taxId as well as its children []
 --select-taxid STR          Select taxId as well as its children []
 --select-columns STR        Select columns with number, (7:full lineage, generated if absent) []
 --report BOOL               Make report of refined classification file [0]
 --rank STR                  Adjust classification to the specified rank []
 --rank-file-type INT        0: without higher rank, 1: with higher rank, 2: separate file for higher rank classification [0]
 --min-score FLOAT           Min. sequence similarity score (0.0-1.0) [0.000]
                           
 --threads INT               Number of CPU-cores used (all by default) [20]

references:
```

## Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/steineggerlab/Metabuli
- **Stars**: N/A
### Original Help Text
```text
usage: metabuli classify <i:query file(s)> <i:database directory> <o:output directory> <job ID>  [options]
 By Jaebeom Kim <jbeom0731@gmail.com>
options: prefilter:              
 --mask INT               Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT        Mask sequences is probablity is above threshold [0.900]
misc:                   
 --seq-mode INT           Single-end: 1, Paired-end: 2, Long read: 3 [2]
 --min-score FLOAT        Min. sequence similarity score (0.0-1.0) [0.000]
 --min-cov FLOAT          Min. query coverage (0.0-1.0) [0.000]
 --min-cons-cnt INT       Min. number of consecutive matches for prokaryote/virus classification [4]
 --min-cons-cnt-euk INT   Min. number of consecutive matches for eukaryote classification [9]
 --min-sp-score FLOAT     Min. score for species- or lower-level classification. [0.000]
 --hamming-margin INT     It allows extra Hamming distance than the minimum distance. [0]
 --taxonomy-path STR      Directory where the taxonomy dump files are stored []
 --max-ram INT            RAM usage in GiB [128]
 --match-per-kmer INT     Num. of matches per query k-mer. Larger values assign more memory for storing k-mer matches.  [4]
 --accession-level INT    Build or search a database for accession-level classification [0]
 --tie-ratio FLOAT        Best * --tie-ratio is considered as a tie [0.950]
 --skip-redundancy INT    Not storing k-mer's redundancy. [0]
 --lineage INT            Print lineage information [0]
 --validate-input INT     Validate format of input FASTA/FASTQ file(s) [0]
 --validate-db INT        Validate the database. It checks if all required files are present and if the k-mer count is consistent. [0]
common:                 
 --threads INT            Number of CPU-cores used (all by default) [20]

references:
```

