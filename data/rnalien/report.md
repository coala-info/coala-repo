# rnalien CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rnalien | Not completed | needs the NCBI BLAST web service or a local nt database and runs for hours; flags were rewritten from the help |
| rnalien_RNAcentralHTTPRequest | Failed | tool bug: the RNAcentral web request runs but the answer no longer parses (key count not found) |
| rnalien_RNAlienScan | Not completed | run on the E. coli genome with the TPP riboswitch alignment took 17 minutes and ended with 'model.stockholm does not exist' in iteration 1, so no result could be checked |
| rnalien_RNAlienStatistics | PASS |  |
| rnalien_cmsearchToBed | PASS |  |

## rnalien

### Tool Description
RNAlien is a tool for the construction of RNA family models. It automatically collects sequences, performs structural alignments, and creates covariance models.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnalien:1.8.0--1
- **Homepage**: http://rna.tbi.univie.ac.at/rnalien/tool
- **Package**: https://anaconda.org/channels/bioconda/packages/rnalien/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnalien/overview
- **Total Downloads**: 47.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/rnalien:1.8.0--1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


## rnalien_RNAlienScan

### Tool Description
Scans genomes for members of an RNA family given as alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnalien:1.8.0--1
- **Homepage**: https://github.com/eggzilla/RNAlien
- **Package**: https://anaconda.org/channels/bioconda/packages/rnalien/overview
- **Validation**: PASS

### Original Help Text
```text
RNAlienScan 1.8.0

options [OPTIONS]
  Florian Eggenhofer - 2019

Common flags:
  -i --inputfastafilepath=ITEM         Path to input fasta file
  -p --inputalignmentfilepath=ITEM     Path to input alignment file
  -b --inputgenomesfastafilepath=ITEM  Path to input genome fasta files
  -o --outputpath=ITEM                 Path to output directory. Default:
                                       current working directory
  -z --inputnscicutoff=NUM             Only candidate sequences with a
                                       normalized structure conservation index
                                       (nSCI) higher than this value are
                                       accepted. Default: 1
  -e --inputevaluecutoff=NUM           Evalue cutoff for cmsearch filtering.
                                       Default: 0.001
  -l --lengthfilter                    Filter blast hits per genomic length.
                                       Default: True
  -a --coveragefilter                  Filter blast hits by coverage of at
                                       least 80%. Default: True
  -s --singlehitpertax                 Only the best blast hit per taxonomic
                                       entry is considered. Default: False
  -f --blastsoftmasking                Toggles blast query softmasking,
                                       meaning masking of non-conserved regions
                                       on the query. Default: False
  -m --inputqueryselectionmethod=ITEM  Method for selection of queries
                                       (filtering,clustering). Default:
                                       filtering
  -n --inputquerynumber=INT            Number of queries used for candidate
                                       search. Default: 5
  -c --threads=INT                     Number of available cpu slots/cores.
                                       Default: 1
  -d --sessionidentificator=ITEM       Optional session id that is used
                                       instead of automatically generated one.
  -x --performevaluation               Perform evaluation step. Default: True
  -g --checksetup                      Just prints installed tool versions
                                       and performs connection check. Default:
                                       False
  -? --help                            Display help message
  -V --version                         Print version information
     --numeric-version                 Print just the version number
  -v --verbose                         Loud verbosity
  -q --quiet                           Quiet verbosity
```

## rnalien_RNAlienStatistics

### Tool Description
Compares an RNAlien covariance model with an Rfam covariance model.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnalien:1.8.0--1
- **Homepage**: https://github.com/eggzilla/RNAlien
- **Package**: https://anaconda.org/channels/bioconda/packages/rnalien/overview
- **Validation**: PASS

### Original Help Text
```text
RNAlienStatistics

options [OPTIONS]
  Florian Eggenhofer - >2013

Common flags:
  -i --aliencovariancemodelpath=ITEM  Path to alienCovarianceModelPath
  -z --alienrnazpath=ITEM             Path to alienRNAzResult
  -w --alienrnacodepath=ITEM          Path to alienRNAcodeResult
  -m --aliencmstatpath=ITEM           Path to aliencmstatResult
  -r --rfamcovariancemodelpath=ITEM   Path to rfamCovarianceModelPath
  -g --rfamfastafilepath=ITEM         Path to rfamFastaFile
  -a --alienfastafilepath=ITEM        Path to alienFastaFile
  -n --rfammodelname=ITEM             Rfam model name
  -d --rfammodelid=ITEM               Rfam model id
  -x --rfamthreshold=NUM              Bitscore threshold for Rfam model hits
                                      on Alien fasta, default 20
  -t --alienthreshold=NUM             Bitscore threshold for RNAlien model
                                      hits on Rfam fasta, default 20
  -k --databasesize=NUM               Cmsearch database size in mega bases.
                                      default not set
  -o --outputdirectorypath=ITEM       Path to output directory
  -b --benchmarkindex=INT             Index used to identify sRNA tagged RNA
                                      families
  -s --thresholdselection=ITEM        Selection method, (bitscore, evalue),
                                      default bitscore
  -l --linkscores                     Triggers computation of linkscores via
                                      CMCompare
  -c --threads=INT                    Number of available cpu slots/cores,
                                      default 1
  -? --help                           Display help message
  -V --version                        Print version information
  -v --verbose                        Loud verbosity
  -q --quiet                          Quiet verbosity
```

## rnalien_cmsearchToBed

### Tool Description
Converts cmsearch file hits to BED file entries.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnalien:1.8.0--1
- **Homepage**: https://github.com/eggzilla/RNAlien
- **Package**: https://anaconda.org/channels/bioconda/packages/rnalien/overview
- **Validation**: PASS

### Original Help Text
```text
cmsearchToBED - Converts cmsearch file hits to BED file entries

options [OPTIONS]
  Florian Eggenhofer 2016

Common flags:
  -i --cmsearchpath=ITEM           Path to input cmsearch file
  -b --inputbrowsersettings=ITEM   Browser settings. Default: browser hide
                                   all
  -y --inputbedvisibility=INT      Visibility setting of track. Default: 2
  -n --inputtrackname=ITEM         Name of the track Default: PredictedRNA
  -d --inputtrackdescription=ITEM  Description of the track. Default: RNA
                                   loci predicted by cmsearch
  -r --inputitemrgb                RGB Color of the track. Default: True
  -c --inputtrackcolor=ITEM        RGB Color of the track. Default: 255,0,0
  -s --sortbed                     Sort entries of Bed file by start end end
                                   cooridinates. Default: True
  -w --withheader                  Output contains bed header. Default: True
  -? --help                        Display help message
  -V --version                     Print version information
  -v --verbose                     Loud verbosity
  -q --quiet                       Quiet verbosity
```

## rnalien_RNAcentralHTTPRequest

### Tool Description
Queries the RNAcentral web service with an input sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnalien:1.8.0--1
- **Homepage**: https://github.com/eggzilla/RNAlien
- **Package**: https://anaconda.org/channels/bioconda/packages/rnalien/overview
- **Validation**: PASS

### Original Help Text
```text
RNAcentralHTTPRequest

options [OPTIONS]
  Florian Eggenhofer 2016

Common flags:
  -i --inputsequence=ITEM  input sequence
  -? --help                Display help message
  -V --version             Print version information
  -v --verbose             Loud verbosity
  -q --quiet               Quiet verbosity
```

## Metadata
- **Skill**: not generated
