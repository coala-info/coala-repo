# genomepy CWL Generation Report

## genomepy_annotation

### Tool Description
Quickly inspect the metadata of each GTF annotation available for the given genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Total Downloads**: 124.5K
- **Last updated**: 2025-09-30
- **GitHub**: https://github.com/vanheeringen-lab/genomepy
- **Stars**: N/A
### Original Help Text
```text
Usage: genomepy annotation [OPTIONS] NAME

  Quickly inspect the metadata of each GTF annotation available for the given
  genome.

  For UCSC, up to 4 gene annotation styles are available: "ncbiRefSeq",
  "refGene", "ensGene", "knownGene" (respectively).

  For NCBI, the chromosome names are not yet sanitized.

Options:
  -p, --provider TEXT  only search this provider
  -n, --lines INTEGER  number of lines to print
  -h, --help           Show this message and exit.
```


## genomepy_clean

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: genomepy clean [OPTIONS]

  Remove cached data on providers (e.g. available genomes).

Options:
  -h, --help  Show this message and exit.
```


## genomepy_config

### Tool Description
Manage configuration

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomepy config [OPTIONS] COMMAND

  Manage configuration

  genomepy config file        return config filepath

  genomepy config show        return config content

  genomepy config generate    create new config file

Options:
  -h, --help  Show this message and exit.
```


## genomepy_genomes

### Tool Description
List all available genomes.

  Returns the metadata of each found genome, including the availability of a
  gene annotation. For UCSC, up to 4 gene annotation styles are available:
  "ncbiRefSeq", "refGene", "ensGene", "knownGene" (respectively).

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomepy genomes [OPTIONS]

  List all available genomes.

  Returns the metadata of each found genome, including the availability of a
  gene annotation. For UCSC, up to 4 gene annotation styles are available:
  "ncbiRefSeq", "refGene", "ensGene", "knownGene" (respectively).

Options:
  -p, --provider TEXT  provider
  -s, --size           show absolute genome size
  -h, --help           Show this message and exit.
```


## genomepy_install

### Tool Description
Install a genome & run active plugins.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomepy install [OPTIONS] NAME

  Install a genome & run active plugins.

  NAME (and more) can be obtained from genomepy search.

Options:
  -p, --provider TEXT             download from this provider
  -g, --genomes_dir TEXT          create output directory here
  -l, --localname TEXT            custom name
  -m, --mask TEXT                 DNA masking: hard/soft/none (default: soft)
  -k, --keep-alt                  keep alternative regions
  -r, --regex TEXT                regex to filter sequences
  -n, --no-match                  select sequences that *don't* match regex
  -b, --bgzip                     bgzip genome
  -t, --threads INTEGER           build index using multithreading
  -f, --force                     overwrite existing files
  
Annotation options:
  -a, --annotation                download annotation
  -o, --only_annotation           only download annotation (sets -a)
  -sm, --skip_matching            skip matching contigs between the gene
                                  annotation and the genome (sets -a)
  -sf, --skip_filter              skip filtering out contigs in the gene
                                  annotation missing from the genome (sets -a)
  
Provider specific options:
  --Ensembl-toplevel              always download toplevel-genome
  --Ensembl-version INTEGER       select release version
  --UCSC-annotation TEXT          specify annotation to download: ncbiRefSeq,
                                  refGene, ensGene, knownGene (case-
                                  insensitive)
  --Local-path-to-annotation TEXT
                                  link to the annotation file, required if
                                  this is not in the same directory as the
                                  fasta file
  --URL-to-annotation TEXT        link to the annotation file, required if
                                  this is not in the same directory as the
                                  fasta file
  -h, --help                      Show this message and exit.
```


## genomepy_plugin

### Tool Description
Enable or disable plugins.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomepy plugin [OPTIONS] COMMAND [NAME]...

  Enable or disable plugins.

  genomepy plugin list                 show plugins and status

  genomepy plugin enable  [NAME(S)]    enable plugins

  genomepy plugin disable [NAME(S)]    disable plugins

Options:
  -h, --help  Show this message and exit.
```


## genomepy_providers

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: genomepy providers [OPTIONS]
Try 'genomepy providers -h' for help.

Error: No such option: --h Did you mean --help?
```


## genomepy_search

### Tool Description
Search for genomes that contain TERM in their name, description, accession (must start with GCA_ or GCF_) or taxonomy (start).

Search is case-insensitive, name/description search accepts multiple terms and regex.

Returns the metadata of each found genome, including the availability of a gene annotation. For UCSC, up to 4 gene annotation styles are available: "ncbiRefSeq", "refGene", "ensGene", "knownGene" (respectively). Each with different naming schemes.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
- **Homepage**: https://github.com/vanheeringen-lab/genomepy
- **Package**: https://anaconda.org/channels/bioconda/packages/genomepy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomepy search [OPTIONS] [TERM]...

  Search for genomes that contain TERM in their name, description, accession
  (must start with GCA_ or GCF_) or taxonomy (start).

  Search is case-insensitive, name/description search accepts multiple terms
  and regex.

  Returns the metadata of each found genome, including the availability of a
  gene annotation. For UCSC, up to 4 gene annotation styles are available:
  "ncbiRefSeq", "refGene", "ensGene", "knownGene" (respectively). Each with
  different naming schemes.

Options:
  -p, --provider TEXT  only search this provider
  -e, --exact          exact matches only
  -s, --size           show absolute genome size
  -h, --help           Show this message and exit.
```


## Metadata
- **Skill**: generated
