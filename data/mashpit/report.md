# mashpit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mashpit_build | PASS |  |
| mashpit_query | PASS |  |
| mashpit_update | Failed | tool bug: for accession databases update_accession calls import_metadata without the connection argument (TypeError) |

## mashpit_build

### Tool Description
Build a mashpit database from a pathogen taxon or a list of BioSample accessions.

### Metadata
- **Docker Image**: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
- **Homepage**: https://github.com/tongzhouxu/mashpit
- **Package**: https://anaconda.org/channels/bioconda/packages/mashpit/overview
- **Validation**: PASS

### Original Help Text
```text


usage: mashpit build [-h] [--quiet] [--number NUMBER] [--ksize KSIZE]
                     [--species SPECIES] [--email EMAIL] [--key KEY]
                     [--pd_version PD_VERSION] [--list LIST]
                     {taxon,accession} name

positional arguments:
  {taxon,accession}     mashpit database type
  name                  mashpit database name

optional arguments:
  -h, --help            show this help message and exit
  --quiet               disable logs
  --number NUMBER       maximum number of hashes for sourmash, default is 1000
  --ksize KSIZE         kmer size for sourmash, default is 31
  --species SPECIES     species name
  --email EMAIL         Entrez email
  --key KEY             Entrez api key
  --pd_version PD_VERSION
                        a specified Pathogen Detection version (PDG
                        accession). Default is the latest.
  --list LIST           Path to a list of NCBI BioSample accessions
```

## mashpit_query

### Tool Description
Query a mashpit database for the most similar isolates.

### Metadata
- **Docker Image**: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
- **Homepage**: https://github.com/tongzhouxu/mashpit
- **Package**: https://anaconda.org/channels/bioconda/packages/mashpit/overview
- **Validation**: PASS

### Original Help Text
```text


usage: mashpit query [-h] [--number NUMBER] [--threshold THRESHOLD]
                     [--annotation ANNOTATION]
                     sample database

positional arguments:
  sample                file path to the query sample
  database              path to the database folder

optional arguments:
  -h, --help            show this help message and exit
  --number NUMBER       number of isolates in the query output, default is 200
  --threshold THRESHOLD
                        minimum jaccard similarity for mashtree, default is
                        0.85
  --annotation ANNOTATION
                        mashtree tip annotation, default is none
```

## mashpit_update

### Tool Description
Update a mashpit database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
- **Homepage**: https://github.com/tongzhouxu/mashpit
- **Package**: https://anaconda.org/channels/bioconda/packages/mashpit/overview
- **Validation**: PASS

### Original Help Text
```text


usage: mashpit update [-h] [--metadata METADATA] [--quiet] database name

positional arguments:
  database             path for the database folder
  name                 database name

optional arguments:
  -h, --help           show this help message and exit
  --metadata METADATA  metadata file in csv format
  --quiet              disable logs
```
