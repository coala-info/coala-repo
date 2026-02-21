# pathoscope CWL Generation Report

## pathoscope_LIB

### Tool Description
PathoScope LIB module for creating reference libraries and mapping gi to taxonomy ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
- **Homepage**: https://github.com/PathoScope/PathoScope
- **Package**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Total Downloads**: 11.5K
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/PathoScope/PathoScope
- **Stars**: N/A
### Original Help Text
```text
Running without mySQLdb library
usage: pathoscope LIB [-h] -genomeFile LIB_REFERENCE [-taxonIds LIB_TAXON_IDS]
                      [-excludeTaxonIds LIB_EXCLUDE_TAXON_IDS] [--noDesc]
                      [--subTax] [--online] [-dbhost LIB_DBHOST]
                      [-dbport LIB_DBPORT] [-dbuser LIB_DBUSER]
                      [-dbpasswd LIB_DBPASSWD] [-db LIB_DB]
                      [-outDir LIB_OUTDIR] -outPrefix LIB_OUTPREFIX

options:
  -h, --help            show this help message and exit
  -genomeFile LIB_REFERENCE
                        Specify reference genome(Download
                        ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nt.gz)
  -taxonIds LIB_TAXON_IDS
                        Specify taxon ids of your interest with comma
                        separated (if you have multiple taxon ids). If you do
                        not specify this option, it will work on all entries
                        in the reference file. For taxonomy id lookup, refer
                        to http://www.ncbi.nlm.nih.gov/taxonomy
  -excludeTaxonIds LIB_EXCLUDE_TAXON_IDS
                        Specify taxon ids to exclude with comma separated (if
                        you have multiple taxon ids to exclude).
  --noDesc              Do not keep an additional description in original
                        fasta seq header.Depending on NGS aligner, a long
                        sequence header may slow down its mapping process.
  --subTax              To include all sub taxonomies under the query taxonomy
                        id. e.g., if you set -t 4751 --subtax, it will cover
                        all sub taxonomies under taxon id 4751 (fungi).
  --online              To enable online searching in case you cannot find a
                        correct taxonomy id for a given gi. When there are
                        many entries in nt whose gi is invalid, this option
                        may slow down the overall process.
  -dbhost LIB_DBHOST    specify hostname running mysql if you want to use
                        mysql instead of hash method in mapping gi to taxonomy
                        id
  -dbport LIB_DBPORT    provide mysql server port if different from default
                        (3306)
  -dbuser LIB_DBUSER    user name to access mysql
  -dbpasswd LIB_DBPASSWD
                        provide password associate with user
  -db LIB_DB            mysql pathoscope database name (default: pathodb)
  -outDir LIB_OUTDIR    Output Directory (Default=. (current directory))
  -outPrefix LIB_OUTPREFIX
                        specify an output prefix to name your target database
```


## pathoscope_creation

### Tool Description
A tool for PathoScope database creation (Note: The provided help text is incomplete and only indicates a missing library dependency).

### Metadata
- **Docker Image**: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
- **Homepage**: https://github.com/PathoScope/PathoScope
- **Package**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Validation**: PASS

### Original Help Text
```text
Running without mySQLdb library
```


## pathoscope_MAP

### Tool Description
PathoScope MAP module for mapping reads to target and filter reference genomes using Bowtie2

### Metadata
- **Docker Image**: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
- **Homepage**: https://github.com/PathoScope/PathoScope
- **Package**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Validation**: PASS

### Original Help Text
```text
Running without mySQLdb library
usage: pathoscope MAP [-h] [-U MAP_INPUTREAD] [-1 MAP_INPUTREAD1]
                      [-2 MAP_INPUTREAD2] [-targetRefFiles MAP_TARGETREF]
                      [-filterRefFiles MAP_FILTERREF]
                      [-targetAlignParams MAP_TARGETALIGNPARAMS]
                      [-filterAlignParams MAP_FILTERALIGNPARAMS]
                      [-outDir MAP_OUTDIR] [-outAlign MAP_OUTALIGN]
                      [-indexDir MAP_INDEXDIR]
                      [-targetIndexPrefixes MAP_TARGETINDEX]
                      [-filterIndexPrefixes MAP_FILTERINDEX]
                      [-targetAlignFiles MAP_TARGETALIGN]
                      [-filterAlignFiles MAP_FILTERALIGN] [-btHome MAP_BTHOME]
                      [-numThreads MAP_NUMTHREADS] [-expTag MAP_EXP_TAG]

options:
  -h, --help            show this help message and exit
  -U MAP_INPUTREAD      Input Read Fastq File (Unpaired/Single-end)
  -1 MAP_INPUTREAD1     Input Read Fastq File (Pair 1)
  -2 MAP_INPUTREAD2     Input Read Fastq File (Pair 2)
  -targetRefFiles MAP_TARGETREF
                        Target Reference Genome Fasta Files Full Path (Comma
                        Separated)
  -filterRefFiles MAP_FILTERREF
                        Filter Reference Genome Fasta Files Full Path (Comma
                        Separated)
  -targetAlignParams MAP_TARGETALIGNPARAMS
                        Target Mapping Bowtie2 Parameters (Default: Pathoscope
                        chosen best parameters)
  -filterAlignParams MAP_FILTERALIGNPARAMS
                        Filter Mapping Bowtie2 Parameters (Default: Use the
                        same Target Mapping Bowtie2 parameters)
  -outDir MAP_OUTDIR    Output Directory (Default=. (current directory))
  -outAlign MAP_OUTALIGN
                        Output Alignment File Name (Default=outalign.sam)
  -indexDir MAP_INDEXDIR
                        Index Directory (Default=. (current directory))
  -targetIndexPrefixes MAP_TARGETINDEX
                        Target Index Prefixes (Comma Separated)
  -filterIndexPrefixes MAP_FILTERINDEX
                        Filter Index Prefixes (Comma Separated)
  -targetAlignFiles MAP_TARGETALIGN
                        Target Alignment Files Full Path (Comma Separated)
  -filterAlignFiles MAP_FILTERALIGN
                        Filter Alignment Files Full Path (Comma Separated)
  -btHome MAP_BTHOME    Full Path to Bowtie2 binary directory (Default: Uses
                        bowtie2 in system path)
  -numThreads MAP_NUMTHREADS
                        Number of threads to use by aligner (bowtie2) if
                        different from default (8)
  -expTag MAP_EXP_TAG   Experiment Tag added to files generated for
                        identification (Default: pathomap)
```


## pathoscope_ID

### Tool Description
PathoScope ID: Identification and quantification of microbes from sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
- **Homepage**: https://github.com/PathoScope/PathoScope
- **Package**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Validation**: PASS

### Original Help Text
```text
Running without mySQLdb library
usage: pathoscope ID [-h] [--outMatrix] [--noUpdatedAlignFile]
                     [--noDisplayCutoff] [-scoreCutoff ID_SCORE_CUTOFF]
                     [-emEpsilon ID_EMEPSILON] [-maxIter ID_MAXITER]
                     [-piPrior ID_PIPRIOR] [-thetaPrior ID_THETAPRIOR]
                     [-expTag ID_EXP_TAG] [-outDir ID_OUTDIR]
                     [-fileType ID_ALI_FORMAT] -alignFile ID_ALI_FILE

options:
  -h, --help            show this help message and exit
  --outMatrix           Output alignment matrix
  --noUpdatedAlignFile  Do not generate an updated alignment file
  --noDisplayCutoff     Do not cutoff display of genomes, even if it is
                        insignificant
  -scoreCutoff ID_SCORE_CUTOFF
                        Score Cutoff
  -emEpsilon ID_EMEPSILON
                        EM Algorithm Epsilon cutoff
  -maxIter ID_MAXITER   EM Algorithm maximum iterations
  -piPrior ID_PIPRIOR   EM Algorithm Pi Prior equivalent to adding n unique
                        reads (Default: n=0)
  -thetaPrior ID_THETAPRIOR
                        EM Algorithm Theta Prior equivalent to adding n non-
                        unique reads (Default: n=0)
  -expTag ID_EXP_TAG    Experiment tag added to output file for easy
                        identification (Default: pathoid)
  -outDir ID_OUTDIR     Output Directory (Default=. (current directory))
  -fileType ID_ALI_FORMAT
                        Alignment Format: sam/bl8/gnu-sam (Default: sam)
  -alignFile ID_ALI_FILE
                        Alignment file path
```


## pathoscope_REP

### Tool Description
PathoScope REP module for generating reports from SAM alignment files, including optional MySQL database integration for taxonomy mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
- **Homepage**: https://github.com/PathoScope/PathoScope
- **Package**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Validation**: PASS

### Original Help Text
```text
Running without mySQLdb library
usage: pathoscope REP [-h] [-samtoolsHome REP_SAMTOOLSHOME]
                      [-dbhost REP_DBHOST] [-dbport REP_DBPORT]
                      [-dbuser REP_DBUSER] [-dbpasswd REP_DBPASSWD]
                      [-db REP_DB] [-outDir REP_OUTDIR] [--contig]
                      -samfile REP_ALI_FILE [--noDisplayCutoff]

options:
  -h, --help            show this help message and exit
  -samtoolsHome REP_SAMTOOLSHOME
                        Full Path to samtools binary directory (Default: Uses
                        samtools in system path)
  -dbhost REP_DBHOST    specify hostname running mysql if you want to use
                        mysql instead of hash method in mapping gi to taxonomy
                        id
  -dbport REP_DBPORT    provide mysql server port if different from default
                        (3306)
  -dbuser REP_DBUSER    user name to access mysql
  -dbpasswd REP_DBPASSWD
                        provide password associate with user
  -db REP_DB            mysql pathoscope database name (default: pathodb)
  -outDir REP_OUTDIR    Output Directory
  --contig              Generate Contig Information (Needs samtools package
                        installed)
  -samfile REP_ALI_FILE
                        SAM Alignment file path
  --noDisplayCutoff     Do not cutoff display of genomes, even if it is
                        insignificant
```


## pathoscope_sequencing

### Tool Description
Running without mySQLdb library

### Metadata
- **Docker Image**: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
- **Homepage**: https://github.com/PathoScope/PathoScope
- **Package**: https://anaconda.org/channels/bioconda/packages/pathoscope/overview
- **Validation**: PASS

### Original Help Text
```text
Running without mySQLdb library
```


## Metadata
- **Skill**: not generated
