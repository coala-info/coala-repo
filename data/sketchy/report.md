# sketchy CWL Generation Report

## sketchy_check

### Tool Description
Check match between sketch and genotype file

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
- **Homepage**: https://github.com/esteinig/sketchy
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sketchy/overview
- **Total Downloads**: 18.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/esteinig/sketchy
- **Stars**: N/A
### Original Help Text
```text
sketchy-check 0.6.0
Check match between sketch and genotype file

USAGE:
    sketchy check --genotypes <genotypes> --reference <reference>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -g, --genotypes <genotypes>    Genotype file to validate with sketch file
    -r, --reference <reference>    Sketch file, format: Mash (.msh) or Finch (.fsh)
```


## sketchy_info

### Tool Description
List sketch genome order, sketch build parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
- **Homepage**: https://github.com/esteinig/sketchy
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchy/overview
- **Validation**: PASS

### Original Help Text
```text
sketchy-info 0.6.0
List sketch genome order, sketch build parameters

USAGE:
    sketchy info [FLAGS] --input <input>

FLAGS:
    -h, --help       Prints help information
    -p, --params     Display the sketch build parameters
    -V, --version    Prints version information

OPTIONS:
    -i, --input <input>    Sketch file, format: Mash (.msh) or Finch (.fsh)
```


## sketchy_predict

### Tool Description
Predict genotypes from reads or read streams

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
- **Homepage**: https://github.com/esteinig/sketchy
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchy/overview
- **Validation**: PASS

### Original Help Text
```text
sketchy-predict 0.6.0
Predict genotypes from reads or read streams

USAGE:
    sketchy predict [FLAGS] [OPTIONS] --genotypes <genotypes> --reference <reference>

FLAGS:
    -c, --consensus    Consensus prediction over top feature values
    -h, --help         Prints help information
    -H, --header       Header added to output based on genotype file
    -s, --stream       Sum of shared hashes per read output
    -V, --version      Prints version information

OPTIONS:
    -g, --genotypes <genotypes>    Reference genotype table (.tsv)
    -i, --input <input>            Fast{a,q}.{gz,xz,bz}, stdin if not present
    -l, --limit <limit>            Number of reads to process, all reads default [default: 0]
    -r, --reference <reference>    Reference sketch, Mash (.msh) or Finch (.fsh)
    -t, --top <top>                Number of top ranked prediction to output [default: 1]
```


## sketchy_shared

### Tool Description
Compute shared hashes between two sketches

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
- **Homepage**: https://github.com/esteinig/sketchy
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchy/overview
- **Validation**: PASS

### Original Help Text
```text
sketchy-shared 0.6.0
Compute shared hashes between two sketches

USAGE:
    sketchy shared --query <query> --reference <reference>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -q, --query <query>            Sketch file, matching format: Mash (.msh) or Finch (.fsh)
    -r, --reference <reference>    Sketch file, format: Mash (.msh) or Finch (.fsh)
```


## sketchy_sketch

### Tool Description
Create a sketch from input sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
- **Homepage**: https://github.com/esteinig/sketchy
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchy/overview
- **Validation**: PASS

### Original Help Text
```text
sketchy-sketch 0.6.0
Create a sketch from input sequences

USAGE:
    sketchy sketch [OPTIONS] --output <output>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -i, --input <input>...             Fast{a,q}.{gz,xz,bz}, stdin if not present
    -k, --kmer-size <kmer-size>        K-mer size [default: 16]
    -o, --output <output>              Output sketch file path
    -c, --scale <scale>                Hash scaler for finch format [default: 0.001]
    -e, --seed <seed>                  Seed for hashing k-mers [default: 0]
    -s, --sketch-size <sketch-size>    Sketch size [default: 1000]
```


## Metadata
- **Skill**: generated
