# lorikeet CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lorikeet_fix-lineages | Not completed | no real tree and SNP matrix; a planted case runs but makes no correction, so the result cannot be confirmed |
| lorikeet_merge-spoligotypes | PASS |  |
| lorikeet_multi-type | PASS |  |
| lorikeet_spoligotype | PASS |  |

## lorikeet_merge-spoligotypes

### Tool Description
Merges spoligotype files from input directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet:20--hdfd78af_1
- **Homepage**: https://github.com/AbeelLab/lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Missing option --input
Usage: java -jar lorikeet.jar merge-spoligotypes [options]

  -i <value> | --input <value>
        Input directory that contains all spoligotype files. You can specify multiple -i arguments
  -o <value> | --output <value>
        Output prefix
  -r | --recursive
        Search input directories recursively [Default=true]
  -p <value> | --pattern <value>
        File name pattern for the input files. [Default=".*.spoligotype]"
```

## lorikeet_multi-type

### Tool Description
Performs multi-typing analysis using spoligotype files.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet:20--hdfd78af_1
- **Homepage**: https://github.com/AbeelLab/lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Missing option --input
Error: Missing option --output
Usage: java -jar lorikeet.jar multi-typing [options]

  -i <value> | --input <value>
        Input directory that contains all spoligotype files. You can specify multiple -i arguments
  -o <value> | --output <value>
        Output prefix
  -t <value> | --threshold <value>
        Minimum threshold
  -r | --recursive
        Search input directories recursively [Default=true]
  -p <value> | --pattern <value>
        File name pattern for the input files. [Default=".*.spoligotype]"
```

## lorikeet_fix-lineages

### Tool Description
Fixes lineages based on input lineage information, phylogenetic tree, and SNP matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet:20--hdfd78af_1
- **Homepage**: https://github.com/AbeelLab/lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Missing option --input
Error: Missing option --output
Error: Missing option --tree
Error: Missing option --snpmatrix
Usage: java -jar lorikeet.jar fix-lineages [options]

  -i <value> | --input <value>
        Input lineage information. (Output of merge-spoligotypes)
  -o <value> | --output <value>
        Output file.
  -t <value> | --tree <value>
        Phylogenetic tree file in NWK format.
  -s <value> | --snpmatrix <value>
        Matrix with pairwise SNP distances (created with pelican)
  --distance <value>
        Maximum distance to consider closest neighbors. [Default=500]
  --fraction <value>
        Fraction of closest neighbors that need to agree to perform change. [Default=0.6]
```

## lorikeet_spoligotype

### Tool Description
Spoligotype BAM, SAM or FASTQ reads of M. tuberculosis based on digital spoligotyping.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet:20--hdfd78af_1
- **Homepage**: https://github.com/AbeelLab/lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: java -jar lorikeet.jar spoligotype [options] <file>...

  -o <value> | --output <value>
        Required: File where you want the output to be written
  -s <value> | --spacer <value>
        Optional: File containing spacers.
  --debug
        Optional: Show debug output.
  <file>...
        Required: Input files. BAM, SAM, fastq and fastq.gz format are supported.
```

## Metadata
- **Skill**: generated
