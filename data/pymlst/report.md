# pymlst CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pymlst_claMLST_create | PASS | built a classical MLST database from the 7 real A. baumannii allele files and the ST table in the pyMLST tests; info shows species and version |
| pymlst_claMLST_import | PASS | imported the PubMLST Pasteur scheme for Acinetobacter baumannii (needs --mlst) |
| pymlst_claMLST_info | PASS | printed name, species, version and the allele counts of the database made by create |
| pymlst_claMLST_remove | PASS | removed gltA allele 186; info afterwards shows 185 gltA alleles |
| pymlst_claMLST_search | PASS | two real genomes typed as ST25 with all 7 Pasteur loci found |
| pymlst_claMLST_search2 | Failed | tool bug: pyMLST 2.2.2 crashes after KMA finishes (read_genome gets a file name string: AttributeError 'str' object has no attribute 'seekable'); tested on simulated reads |
| pymlst_pyTyper_search | Failed | image problem: pytyper.db is created inside the read-only install directory on first use, so it fails for a non-root user (works only as root) |
| pymlst_wgMLST_add | PASS | 4 real A. baumannii genomes added in turn; database grew each time |
| pymlst_wgMLST_add2 | Failed | tool bug: pyMLST 2.2.2 crashes after KMA finishes (read_genome gets a file name string: AttributeError 'str' object has no attribute 'seekable'); tested on simulated reads |
| pymlst_wgMLST_create | PASS | real A. baumannii cgMLST scheme (2386 genes) from the pyMLST tests |
| pymlst_wgMLST_distance | PASS | symmetric 4x4 allele distance matrix, consistent with the MLST table |
| pymlst_wgMLST_gene | PASS | listed 2324 genes present in all 4 real A. baumannii strains with --mincover 4 |
| pymlst_wgMLST_import | PASS | imported the A. baumannii scheme from cgmlst.org (2390 genes) |
| pymlst_wgMLST_mlst | PASS | allele table of 4 strains over 2386 genes |
| pymlst_wgMLST_msa | PASS | 4 aligned sequences written (mafft) |
| pymlst_wgMLST_recombination | PASS | variation count per gene for 2324 genes from the gene list and the alignment of 4 real strains (fails with a division by zero if a listed gene is missing in the first strain) |
| pymlst_wgMLST_remove | PASS | removing strain 14A543 left 3 strains; removing 2 genes with --file --genes left 2384 core genes |
| pymlst_wgMLST_sequence | PASS | wrote 2506 allele sequences in fasta, each named with its gene, allele number and strains |
| pymlst_wgMLST_stats | PASS | reports 2386 core genes and 4 strains |
| pymlst_wgMLST_strain | PASS | listed the 4 strains with their gene counts (2338 to 2343 of 2386) |
| pymlst_wgMLST_subgraph | PASS | grouped the 4 strains at distance threshold 30 into 2 groups (3 close strains and 16A1524) in group and count modes |

## pymlst_wgMLST_create

### Tool Description
Creates a wgMLST DATABASE from a template COREGENE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST create [OPTIONS] DATABASE COREGENE

  Creates a wgMLST DATABASE from a template COREGENE.

Options:
  -f, --force         Overwrite alrealdy existing DATABASE
  -c, --concatenate   Automatically concatenates GENES with duplicated
                      sequences.
  -r, --remove        Automatically removes GENES with duplicated sequences.
  -s, --species TEXT  Name of the species
  -V, --version TEXT  Version of the database
  -h, --help          Show this message and exit.
```

## pymlst_wgMLST_add

### Tool Description
Adds a strain GENOME to the wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST add [OPTIONS] DATABASE GENOME

  Adds a strain GENOME to the wgMLST DATABASE.

Options:
  -s, --strain TEXT     Name of the strain (default:genome name).
  -i, --identity FLOAT  Minimum identity to search gene (default=0.95).
  -c, --coverage FLOAT  Minimum coverage to search gene (default=0.9).
  -h, --help            Show this message and exit.
```

## pymlst_wgMLST_mlst

### Tool Description
Extracts an MLST table from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST mlst [OPTIONS] DATABASE

  Extracts an MLST table from a wgMLST DATABASE.

Options:
  -m, --mincover INTEGER          Minimum number of strains found to retain a
                                  gene (default:0)
  -k, --keep                      Keeps only gene with different alleles (omit
                                  missing).
  -d, --duplicate                 Keeps duplicate genes (default remove).
  -V, --inverse                   Keeps only gene that do not match the filter
                                  of mincover or keep options.
  -f, --form [default|grapetree]  Specify format of output
  -o, --output FILENAME           Export strain list to (default=stdout).
  -h, --help                      Show this message and exit.
```

## pymlst_wgMLST_distance

### Tool Description
Extracts a distance matrix from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST distance [OPTIONS] DATABASE

  Extracts a distance matrix from a wgMLST DATABASE.

Options:
  -m, --mincover INTEGER  Minimum number of strains found to retain a gene
                          (default:0)
  -k, --keep              Keeps only gene with different alleles (omit
                          missing).
  -d, --duplicate         Keeps duplicate genes (default remove).
  -V, --inverse           Keeps only gene that do not match the filter of
                          mincover or keep options.
  -o, --output FILENAME   Export distance to (default=stdout).
  -h, --help              Show this message and exit.
```

## pymlst_wgMLST_msa

### Tool Description
Computes Multiple Sequence Alignment from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST msa [OPTIONS] DATABASE

  Computes Multiple Sequence Alignment from a wgMLST DATABASE.

Options:
  -o, --output FILENAME  Output result in fasta format (default:stdout).
  -f, --file FILENAME    file containing list of coregenes to extract
                         (default:all coregenes).
  -r, --realign          Realigns genes with same length (Default:No).
  -h, --help             Show this message and exit.
```

## pymlst_wgMLST_stats

### Tool Description
Extracts stats from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST stats [OPTIONS] DATABASE

  Extracts stats from a wgMLST DATABASE.

Options:
  -h, --help  Show this message and exit.
```

## pymlst_wgMLST_import

### Tool Description
Creates a wgMLST DATABASE from an online resource.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST import [OPTIONS] DATABASE [SPECIES]...

  Creates a wgMLST DATABASE from an online resource.

  The research can be filtered by adding a SPECIES name.

Options:
  -f, --force             Overwrite alrealdy existing DATABASE
  --prompt / --no-prompt  Do not prompt if multiple choices are found, fail
                          instead.
  -h, --help              Show this message and exit.
```

## pymlst_claMLST_import

### Tool Description
Creates a claMLST DATABASE from an online resource.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: claMLST import [OPTIONS] DATABASE [SPECIES]...

  Creates a claMLST DATABASE from an online resource.

  The research can be filtered by adding a SPECIES name.

Options:
  -f, --force                     Overwrites alrealdy existing DATABASE
  --prompt / --no-prompt          Do not prompt if multiple choices are found,
                                  fail instead.
  -m, --mlst TEXT                 Specifies the desired MLST scheme name.
  -r, --repository [pubmlst|pasteur]
                                  Choose the online repository to use
  -h, --help                      Show this message and exit.
```

## pymlst_claMLST_search

### Tool Description
Searches ST number for an assembly GENOME using an mlst DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: claMLST search [OPTIONS] DATABASE [GENOMES]...

  Searches ST number for an assembly GENOME using an mlst DATABASE.

Options:
  -i, --identity FLOAT   Minimum identity to search gene (default=0.9).
  -c, --coverage FLOAT   Minimum coverage to search gene (default=0.9).
  -f, --fasta FILENAME   Writes fasta file with gene allele.
  -o, --output FILENAME  Writes ST search result to (default:stdout).
  -h, --help             Show this message and exit.
```

## pymlst_pyTyper_search

### Tool Description
Searches strain type using specified METHOD for an assembly GENOME.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyTyper search [OPTIONS] {fim|spa|clmt} GENOMES...

  Searches strain type using specified METHOD for an assembly GENOME.

  fim: fimH typing for Escherichia coli

  spa: spa typing for Staphylococcus aureus

  clmt: Phylogouping using ClermontTyping method for Escherichia coli

Options:
  -i, --identity FLOAT   Minimum identity to search gene.
  -c, --coverage FLOAT   Minimum coverage to search gene.
  -f, --fasta FILENAME   Writes fasta file with gene allele.
  -o, --output FILENAME  Writes search result to (default:stdout).
  -h, --help             Show this message and exit.
```

## pymlst_claMLST_create

### Tool Description
Creates a classical MLST DATABASE from a txt PROFILE and fasta ALLELES files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: claMLST create [OPTIONS] DATABASE PROFILE ALLELES...

  Creates a classical MLST DATABASE from a txt PROFILE and fasta ALLELES
  files.

Options:
  -f, --force         Overwrites alrealdy existing DATABASE
  -s, --species TEXT  Name of the species
  -V, --version TEXT  Version of the database
  -h, --help          Show this message and exit.
```

## pymlst_claMLST_info

### Tool Description
Output the information about a classical MLST DATABASE

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: claMLST info [OPTIONS] DATABASE

  Output the information about  a classical MLST DATABASE

Options:
  -o, --output FILENAME  Writes ST search result to (default:stdout).
  -h, --help             Show this message and exit.
```

## pymlst_claMLST_remove

### Tool Description
Removes ALLELE sequence from the GENE on a mlst DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: claMLST remove [OPTIONS] DATABASE GENE ALLELE

  Removes ALLELE sequence from the GENE on a mlst DATABASE.

Options:
  -h, --help  Show this message and exit.
```

## pymlst_claMLST_search2

### Tool Description
Searches ST number from FASTQS(.gz) raw reads using an mlst DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: claMLST search2 [OPTIONS] DATABASE [FASTQS]...

  Searches ST number from FASTQS(.gz) raw reads using an mlst DATABASE.

Options:
  -i, --identity FLOAT   Minimum identity to search gene (default=0.9).
  -c, --coverage FLOAT   Minimum coverage to search gene (default=0.95).
  -r, --reads INTEGER    Minimum reads coverage to search gene (default=10).
  --paired / --single    Defines type of fastqs files.
  -f, --fasta FILENAME   Writes fasta file with gene allele.
  -o, --output FILENAME  Writes ST search result to (default:stdout).
  -h, --help             Show this message and exit.
```

## pymlst_wgMLST_add2

### Tool Description
Adds a strain from FASTQS(.gz) reads to the wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST add2 [OPTIONS] DATABASE [FASTQS]...

  Adds a strain from FASTQS(.gz) reads to the wgMLST DATABASE.

Options:
  -s, --strain TEXT     Name of the strain (default:genome name).
  -i, --identity FLOAT  Minimum identity to search gene (default=0.95).
  -c, --coverage FLOAT  Minimum coverage to search gene (default=0.9).
  -r, --reads INTEGER   Minimum reads coverage to search a gene (default=10).
  -h, --help            Show this message and exit.
```

## pymlst_wgMLST_gene

### Tool Description
Extracts a list of genes from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST gene [OPTIONS] DATABASE

  Extracts a list of genes from a wgMLST DATABASE.

Options:
  -m, --mincover INTEGER  Minimum number of strains found to retain a gene
                          (default:0)
  -k, --keep              Keeps only gene with different alleles (omit
                          missing).
  -d, --duplicate         Keeps duplicate genes (default remove).
  -V, --inverse           Keeps only gene that do not match the filter of
                          mincover or keep options.
  -o, --output FILENAME   Export GENE list to (default=stdout).
  -h, --help              Show this message and exit.
```

## pymlst_wgMLST_strain

### Tool Description
Extracts a list of strains from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST strain [OPTIONS] DATABASE

  Extracts a list of strains from a wgMLST DATABASE.

Options:
  -m, --mincover INTEGER  Minimum number of strains found to retain a gene
                          (default:0)
  -k, --keep              Keeps only gene with different alleles (omit
                          missing).
  -d, --duplicate         Keeps duplicate genes (default remove).
  -V, --inverse           Keeps only gene that do not match the filter of
                          mincover or keep options.
  -c, --count             Count the number of gene present in the database for
                          each strains.
  -o, --output FILENAME   Export strain list to (default=stdout).
  -h, --help              Show this message and exit.
```

## pymlst_wgMLST_recombination

### Tool Description
Searches potential gene recombinations from wgMLST database export.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST recombination [OPTIONS] GENES ALIGNMENT

  Searches potential gene recombinations from wgMLST database export.

Options:
  -o, --output FILENAME  Output number of variations by genes
                         (default:stdout).
  -h, --help             Show this message and exit.
```

## pymlst_wgMLST_remove

### Tool Description
Removes STRAINS or GENES from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST remove [OPTIONS] DATABASE [GENES_OR_STRAINS]...

  Removes STRAINS or GENES from a wgMLST DATABASE.

Options:
  --strains / --genes  Choose the item you wish to remove  [default:
                       (strains)]
  -f, --file FILENAME  File list of genes or strains to removed on the wgMLST
                       database.
  -h, --help           Show this message and exit.
```

## pymlst_wgMLST_sequence

### Tool Description
Extracts sequences from a wgMLST DATABASE.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST sequence [OPTIONS] DATABASE

  Extracts sequences from a wgMLST DATABASE.

Options:
  -o, --output FILENAME  Output result in fasta format (default:stdout).
  -f, --file FILENAME    File containing list of coregenes to extract
                         (default:all coregenes).
  --reference            Return sequence of the reference instead of strains
                         alleles
  -h, --help             Show this message and exit.
```

## pymlst_wgMLST_subgraph

### Tool Description
Searches group of strains at a DISTANCE threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/bvalot/pyMLST
- **Package**: https://anaconda.org/channels/bioconda/packages/pymlst/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wgMLST subgraph [OPTIONS] DISTANCE

  Searches group of strains at a DISTANCE threshold.

Options:
  -o, --output FILENAME           Output group files (default:stdout).
  -t, --threshold INTEGER         Minimum distance to conserve for extraction
                                  of group (default:50).
  -e, --export [list|count|group]
                                  Export type (default:list).
  -h, --help                      Show this message and exit.
```

