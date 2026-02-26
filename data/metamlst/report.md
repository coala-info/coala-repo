# metamlst CWL Generation Report

## metamlst_metamlst-index.py

### Tool Description
Builds and manages the MetaMLST SQLite Databases

### Metadata
- **Docker Image**: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
- **Homepage**: https://github.com/SegataLab/metamlst
- **Package**: https://anaconda.org/channels/bioconda/packages/metamlst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metamlst/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SegataLab/metamlst
- **Stars**: N/A
### Original Help Text
```text
usage: metamlst-index.py [-h] [-t TYPINGS] [-s SEQUENCES] [-q DUMP_DB]
                         [-i BUILDINDEX] [-b BUILDBLAST] [-d DB PATH] [--list]
                         [--filter FILTER] [--version]
                         [--bowtie2_threads BOWTIE2_THREADS]
                         [--bowtie2_build BOWTIE2_BUILD]

Builds and manages the MetaMLST SQLite Databases

optional arguments:
  -h, --help            show this help message and exit
  -t TYPINGS, --typings TYPINGS
                        Typings in TAB separated file (Build New Database)
                        (default: None)
  -s SEQUENCES, --sequences SEQUENCES
                        Sequences in FASTA format (comma separated list of
                        files) (default: None)
  -q DUMP_DB, --dump_db DUMP_DB
                        Dump the entire database to file in fasta format)
                        (default: None)
  -i BUILDINDEX, --buildindex BUILDINDEX
                        Build a Bowtie2 Index from the DB (default: None)
  -b BUILDBLAST, --buildblast BUILDBLAST
                        Build a BLAST Index from the DB (default: None)
  -d DB PATH, --database DB PATH
                        MetaMLST Database File (if unset, use the default
                        database. If a file name is given, MetaMLST will
                        create a new DB or update an existing one) (default:
                        None)
  --list                Lists all the MLST keys present in the database and
                        exit (default: False)
  --filter FILTER       filters the db for a specific bacterium (default:
                        None)
  --version             Prints version informations (default: False)
  --bowtie2_threads BOWTIE2_THREADS
                        Number of Threads to use with bowtie2-build (default:
                        4)
  --bowtie2_build BOWTIE2_BUILD
                        Full path to the bowtie2-build command to use, deafult
                        assumes that 'bowtie2-build is present in the system
                        path (default: bowtie2-build)
```


## metamlst_metamlst.py

### Tool Description
Reconstruct the MLST loci from a BAMFILE aligned to the reference MLST loci

### Metadata
- **Docker Image**: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
- **Homepage**: https://github.com/SegataLab/metamlst
- **Package**: https://anaconda.org/channels/bioconda/packages/metamlst/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metamlst.py [-h] [-o OUTPUT FOLDER] [-d DB PATH]
                   [--filter species1,species2...] [--penalty PENALTY]
                   [--minscore MINSCORE] [--max_xM XM] [--min_read_len LENGTH]
                   [--min_accuracy CONFIDENCE] [--debug] [--presorted]
                   [--quiet] [--version] [--nloci NLOCI] [--log] [-a]
                   [BAMFILE]

Reconstruct the MLST loci from a BAMFILE aligned to the reference MLST loci

positional arguments:
  BAMFILE               BowTie2 BAM file containing the alignments (default:
                        None)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT FOLDER      Output Folder (default: ./out) (default: ./out)
  -d DB PATH, --database DB PATH
                        Specify a different MetaMLST-Database. If unset, use
                        the default Database. You can create a custom DB with
                        metaMLST-index.py) (default: None)
  --filter species1,species2...
                        Filter for specific set of organisms only (METAMLST-
                        KEYs, comma separated. Use metaMLST-index.py
                        --listspecies to get MLST keys) (default: None)
  --penalty PENALTY     MetaMLST penaty for under-represented alleles
                        (default: 100)
  --minscore MINSCORE   Minimum alignment score for each alignment to be
                        considered valid (default: 80)
  --max_xM XM           Maximum SNPs rate for each alignment to be considered
                        valid (BowTie2s XM value) (default: 5)
  --min_read_len LENGTH
                        Minimum BowTie2 alignment length (default: 50)
  --min_accuracy CONFIDENCE
                        Minimum threshold on Confidence score (percentage) to
                        pass the reconstruction step (default: 0.9)
  --debug               Debug Mode (default: False)
  --presorted           The input BAM file is sorted and indexed with
                        samtools. If set, MetaMLST skips this step (default:
                        False)
  --quiet               Suppress text output (default: False)
  --version             Prints version informations (default: False)
  --nloci NLOCI         Do not discard samples where at least NLOCI (percent)
                        are detected. This can lead to imperfect MLST typing
                        (default: 100)
  --log                 generate logfiles (default: False)
  -a                    Write known sequences (default: False)
```


## metamlst_metamlst-merge.py

### Tool Description
Detects the MLST profiles from a collection of intermediate files from MetaMLST.py

### Metadata
- **Docker Image**: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
- **Homepage**: https://github.com/SegataLab/metamlst
- **Package**: https://anaconda.org/channels/bioconda/packages/metamlst/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metamlst-merge.py [-h] [-d DB PATH] [--filter species1,species2...]
                         [-z ED] [--meta METADATA_PATH] [--idField IDFIELD]
                         [--outseqformat {A,A+,B,B+,C,C+}]
                         [-j subjectID,diet,age...] [--jgroup] [--version]
                         [folder]

Detects the MLST profiles from a collection of intermediate files from MetaMLST.py

positional arguments:
  folder                Path to the folder containing .nfo MetaMLST.py files

optional arguments:
  -h, --help            show this help message and exit
  -d DB PATH, --database DB PATH
                        Specify a different MetaMLST-Database. If unset, use the default Database. You can create a custom DB with metaMLST-index.py)
  --filter species1,species2...
                        Filter for specific set of organisms only (METAMLST-KEYs, comma separated. Use metaMLST-index.py --listspecies to get MLST keys)
  -z ED                 Maximum Edit Distance from the closest reference to call a new MLST allele. Default: 5
  --meta METADATA_PATH  Metadata file (CSV)
  --idField IDFIELD     Field number pointing to the 'sampleID' value in the metadata file
  --outseqformat {A,A+,B,B+,C,C+}
                        A  : Concatenated Fasta (Only Detected STs)
                        A+ : Concatenated Fasta (All STs)
                        B  : Single loci (Only New Loci)
                        B+ : Single loci (All loci)
                        C  : CSV STs Table [default]
  -j subjectID,diet,age...
                        Embed a LIST of metadata in the the output sequences (A or A+ outseqformat modes). Requires a comma separated list of field names from the metadata file specified with --meta
  --jgroup              Group the output sequences (A or A+ outseqformat modes) by ST, rather than by sample. Requires -j
  --version             Prints version informations
```

