# odamnet CWL Generation Report

## odamnet_overlap

### Tool Description
Perform Overlap analysis between genes targeted by chemicals and rare diseases pathways.

### Metadata
- **Docker Image**: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/ODAMNet/1.1.0/
- **Package**: https://anaconda.org/channels/bioconda/packages/odamnet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/odamnet/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MOohTus/ODAMNet
- **Stars**: N/A
### Original Help Text
```text
Usage: odamnet overlap [OPTIONS]

  Perform Overlap analysis between genes targeted by chemicals and rare
  diseases pathways.

Options:
  Extract target genes list from: [mutually_exclusive, required]
                                  Choice the way to extract target genes
    -c, --chemicalsFile FILENAME  Chemicals file name
    -r, --CTD_file FILENAME       CTD file name
    -t, --targetGenesFile FILENAME
                                  Target genes file name
  --directAssociation BOOLEAN     True: Extract target genes from chemicals
                                  False: Extract target genes from chemicals +
                                  its child chemicals  [default: True]
  --nbPub INTEGER                 Minimum number of publications to keep an
                                  interaction  [default: 2]
  --GMT FILENAME                  Pathways of interest file name (GMT file)
                                  NOTE: This argument is required if
                                  backgroundFile chosen.
  --backgroundFile FILENAME       Background genes file name NOTE: This
                                  argument is required if pathOfInterestGMT
                                  chosen.
  -o, --outputPath PATH           Output folder name to save results
                                  [default: OutputResults]
  -h, --help                      Show this message and exit.
```


## odamnet_domino

### Tool Description
Perform Active module identification analysis between genes targeted by
  chemicals and rare diseases pathways using DOMINO.

  1. DOMINO on network using target genes as seed 2. Overlap analysis between
  identified active modules and rare disease pahtways

### Metadata
- **Docker Image**: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/ODAMNet/1.1.0/
- **Package**: https://anaconda.org/channels/bioconda/packages/odamnet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: odamnet domino [OPTIONS]

  Perform Active module identification analysis between genes targeted by
  chemicals and rare diseases pathways using DOMINO.

  1. DOMINO on network using target genes as seed 2. Overlap analysis between
  identified active modules and rare disease pahtways

Options:
  Extract target genes list from: [mutually_exclusive, required]
                                  Choice the way to extract target genes
    -c, --chemicalsFile FILENAME  Chemicals file name
    -r, --CTD_file FILENAME       CTD file name
    -t, --targetGenesFile FILENAME
                                  Target genes file name
  --directAssociation BOOLEAN     True: Extract target genes from chemicals
                                  False: Extract target genes from chemicals +
                                  its child chemicals  [default: True]
  --nbPub INTEGER                 Minimum number of publications to keep an
                                  interaction  [default: 2]
  -n, --networkFile FILENAME      Network file name  [required]
  --netUUID TEXT                  NDEx network ID
  --GMT FILENAME                  Pathways of interest file name (GMT file)
                                  NOTE: This argument is required if
                                  backgroundFile chosen.
  --backgroundFile FILENAME       Background genes file name NOTE: This
                                  argument is required if pathOfInterestGMT
                                  chosen.
  -o, --outputPath PATH           Output folder name to save results
                                  [default: OutputResults]
  -h, --help                      Show this message and exit.
```


## odamnet_multixrank

### Tool Description
Performs a Random Walk with Restart analysis using multiXrank with genes and diseases multilayers.

### Metadata
- **Docker Image**: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/ODAMNet/1.1.0/
- **Package**: https://anaconda.org/channels/bioconda/packages/odamnet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: odamnet multixrank [OPTIONS]

  Performs a Random Walk with Restart analysis using multiXrank with genes and
  diseases multilayers.

Options:
  Extract target genes list from: [mutually_exclusive, required]
                                  Choice the way to extract target genes
    -c, --chemicalsFile FILENAME  Chemicals file name
    -r, --CTD_file FILENAME       CTD file name
    -t, --targetGenesFile FILENAME
                                  Target genes file name
  --directAssociation BOOLEAN     True: Extract target genes from chemicals
                                  False: Extract target genes from chemicals +
                                  its child chemicals  [default: True]
  --nbPub INTEGER                 Minimum number of publications to keep an
                                  interaction  [default: 2]
  --configPath PATH               Configurations file path name  [required]
  --networksPath PATH             Network directory path  [required]
  --seedsFile FILENAME            Seeds file path name  [required]
  --sifFileName FILENAME          Name of the output file network SIF
                                  [required]
  --top INTEGER                   Top number of results to write into output
                                  file  [default: 10]
  -o, --outputPath PATH           Output folder name to save results
                                  [default: OutputResults]
  -h, --help                      Show this message and exit.
```


## odamnet_networkCreation

### Tool Description
Creates network (GR format) from WikiPathways request or pathways of interest given in GMT file.

### Metadata
- **Docker Image**: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/ODAMNet/1.1.0/
- **Package**: https://anaconda.org/channels/bioconda/packages/odamnet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: odamnet networkCreation [OPTIONS]

  Creates network (GR format) from WikiPathways request or pathways of
  interest given in GMT file.

Options:
  --networksPath PATH       Output path to save the network  [required]
  --networksName FILENAME   Network output name  [default:
                            WP_RareDiseasesNetwork.gr]
  --bipartitePath PATH      Output path to save the bipartite  [required]
  --bipartiteName FILENAME  Bipartite output name  [default:
                            Bipartite_WP_RareDiseases_geneSymbols.gr]
  --GMT FILENAME            Pathways of interest in GMT like format (e.g. from
                            WP request).
  -o, --outputPath PATH     Output path name (for complementary output files)
                            [default: OutputResults]
  -h, --help                Show this message and exit.
```


## odamnet_networkDownloading

### Tool Description
Download networks from NDEx using the UUID network. Create SIF (3 columns
  with header) or GR (2 columns without header) network

### Metadata
- **Docker Image**: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/ODAMNet/1.1.0/
- **Package**: https://anaconda.org/channels/bioconda/packages/odamnet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: odamnet networkDownloading [OPTIONS]

  Download networks from NDEx using the UUID network. Create SIF (3 columns
  with header) or GR (2 columns without header) network

Options:
  --netUUID TEXT          NDEx network ID  [required]
  --networkFile FILENAME  Network file name  [required]
  --simple BOOLEAN        Remove interaction column and header
  -h, --help              Show this message and exit.
```


## Metadata
- **Skill**: generated
