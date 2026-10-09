# jali CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jali | PASS |  |
| jscan | PASS |  |
| jsearch | PASS |  |

## jali

### Tool Description
Performs sequence alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/jali:1.3--0
- **Homepage**: http://bibiserv.cebitec.uni-bielefeld.de/jali
- **Package**: https://anaconda.org/channels/bioconda/packages/jali/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jali/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: jali [options] sequence.fasta alignment.fasta

Options:
  -w weights_filename      //amino acid similarity matrix
  -i gap_initiation_cost   //must be smaller or equal to zero
  -e gap_extension_cost    //must be smaller or equal to zero
  -j jump_cost             //must be smaller or equal to zero
  -f format_ID             //0:ASCII (default) 1:HTML 2:double-spaced HTML
  -p                       //print alignment
  -o                       //run in verbose mode
  -v                       //print version
  -h                       //print this help message
```


## jsearch

### Tool Description
Compares all proteins of a protein database to a multiple alignment of a protein family with jumping alignments, and outputs the database sorted by alignment score.

### Metadata
- **Docker Image**: quay.io/biocontainers/jali:1.3--0
- **Homepage**: http://bibiserv.cebitec.uni-bielefeld.de/jali
- **Package**: https://anaconda.org/channels/bioconda/packages/jali/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: jsearch [options] sequence-db.fasta alignment.fasta

Options:
  -w weights_filename      //amino acid similarity matrix
  -i gap_initiation_cost   //must be smaller or equal to zero
  -e gap_extension_cost    //must be smaller or equal to zero
  -j jump_cost             //must be smaller or equal to zero
  -o                       //run in verbose mode
  -v                       //print version
  -h                       //print this help message
```

## jscan

### Tool Description
Compares a protein sequence to a database of multiple alignments (PRODOM format) with jumping alignments, and outputs the cluster names with their scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/jali:1.3--0
- **Homepage**: http://bibiserv.cebitec.uni-bielefeld.de/jali
- **Package**: https://anaconda.org/channels/bioconda/packages/jali/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: jscan [options] sequence.fasta alignment-db.prodom

Options:
  -w weights_filename      //amino acid similarity matrix
  -i gap_initiation_cost   //must be smaller or equal to zero
  -e gap_extension_cost    //must be smaller or equal to zero
  -j jump_cost             //must be smaller or equal to zero
  -l lines_of_output       //print best l scores
  -o                       //run in verbose mode
  -v                       //print version
  -h                       //print this help message
```

## Metadata
- **Skill**: generated
