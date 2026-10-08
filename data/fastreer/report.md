# fastreer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastreer_DIST2TREE | PASS |  |
| fastreer_FASTA2DIST | PASS | with 1 thread the output matches the Galaxy expected file exactly; with several threads values vary slightly between runs |
| fastreer_VCF2DIST | PASS |  |
| fastreer_VCF2EMB | Not completed | needs the biofm-eval package (missing in the image), a downloaded BioFM-265M language model and a reference genome |
| fastreer_VCF2TREE | PASS |  |

## fastreer_VCF2DIST

### Tool Description
Compute a distance matrix from one or more VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gkanogiannis/fastreeR
- **Package**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastreeR.py VCF2DIST [-h] [-i NAMED_INPUTS] [-o OUTPUT] [-t THREADS]
                            [-v] [-e EMBEDDINGS]
                            [--embeddings-format {TSV,HUGGINGFACE}]
                            [--variant-key {CHROM_POS,CHROM_POS_REF_ALT,VCF_ID}]
                            [inputs ...]

positional arguments:
  inputs                Positional input files

options:
  -h, --help            show this help message and exit
  -i, --input NAMED_INPUTS
                        Input file(s)
  -o, --output OUTPUT   Output file path (default: stdout)
  -t, --threads THREADS
                        Number of threads (default: 1)
  -v, --verbose         Print progress messages on stderr (default: false)
  -e, --embeddings EMBEDDINGS
                        Path to variant embeddings file for embedding-based
                        distance calculation
  --embeddings-format {TSV,HUGGINGFACE}
                        Embeddings file format: TSV or HUGGINGFACE (auto-
                        detected if not specified)
  --variant-key {CHROM_POS,CHROM_POS_REF_ALT,VCF_ID}
                        Variant key format for embedding lookup (default:
                        CHROM_POS_REF_ALT)
```

## fastreer_VCF2TREE

### Tool Description
Compute a phylogenetic tree (Newick) from one or more VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gkanogiannis/fastreeR
- **Package**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastreeR.py VCF2TREE [-h] [-i NAMED_INPUTS] [-o OUTPUT] [-t THREADS]
                            [-v] [-e EMBEDDINGS]
                            [--embeddings-format {TSV,HUGGINGFACE}]
                            [--variant-key {CHROM_POS,CHROM_POS_REF_ALT,VCF_ID}]
                            [-b BOOTSTRAP]
                            [inputs ...]

positional arguments:
  inputs                Positional input files

options:
  -h, --help            show this help message and exit
  -i, --input NAMED_INPUTS
                        Input file(s)
  -o, --output OUTPUT   Output file path (default: stdout)
  -t, --threads THREADS
                        Number of threads (default: 1)
  -v, --verbose         Print progress messages on stderr (default: false)
  -e, --embeddings EMBEDDINGS
                        Path to variant embeddings file for embedding-based
                        distance calculation
  --embeddings-format {TSV,HUGGINGFACE}
                        Embeddings file format: TSV or HUGGINGFACE (auto-
                        detected if not specified)
  --variant-key {CHROM_POS,CHROM_POS_REF_ALT,VCF_ID}
                        Variant key format for embedding lookup (default:
                        CHROM_POS_REF_ALT)
  -b, --bootstrap BOOTSTRAP
                        Number of bootstrap replicates to perform (default: 0,
                        no bootstrapping)
```

## fastreer_FASTA2DIST

### Tool Description
Compute a distance matrix from one or more FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gkanogiannis/fastreeR
- **Package**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastreeR.py FASTA2DIST [-h] [-i NAMED_INPUTS] [-o OUTPUT] [-k KMERSIZE]
                              [-t THREADS] [-n] [-v]
                              [inputs ...]

positional arguments:
  inputs                Positional input files

options:
  -h, --help            show this help message and exit
  -i, --input NAMED_INPUTS
                        Input file(s)
  -o, --output OUTPUT   Output file path (default: stdout)
  -k, --kmerSize KMERSIZE
                        Kmer size for D2S calculation (default: 4)
  -t, --threads THREADS
                        Number of threads (default: 1)
  -n, --normalize       Use normalization (default: false)
  -v, --verbose         Print progress messages on stderr (default: false)
```

## fastreer_DIST2TREE

### Tool Description
Compute a phylogenetic tree (Newick) from a distance matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gkanogiannis/fastreeR
- **Package**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastreeR.py DIST2TREE [-h] [-i NAMED_INPUT] [-o OUTPUT] [-v]
                             [input_file]

positional arguments:
  input_file            Input dist file

options:
  -h, --help            show this help message and exit
  -i, --input NAMED_INPUT
                        Optional input dist file (overrides positional)
  -o, --output OUTPUT   Output file path (default: stdout)
  -v, --verbose         Print progress messages on stderr (default: false)
```

## fastreer_VCF2EMB

### Tool Description
Generate variant embeddings from a VCF file using the BioFM-265M genomic language model

### Metadata
- **Docker Image**: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gkanogiannis/fastreeR
- **Package**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastreeR.py VCF2EMB [-h] [-i NAMED_INPUT] [-o OUTPUT] [-r REFERENCE]
                           [-a ANNOTATION] [-m MODEL] [-f {TSV,HUGGINGFACE}]
                           [--variant-key {CHROM_POS,CHROM_POS_REF_ALT,VCF_ID}]
                           [--max-variants MAX_VARIANTS] [--device {cuda,cpu}]
                           [-v]
                           [input_file]

Generate variant embeddings from a VCF file using the BioFM-265M genomic
language model. Requires biofm-eval package (pip install biofm-eval) and
reference genome/annotation files.

positional arguments:
  input_file            Input VCF file

options:
  -h, --help            show this help message and exit
  -i, --input NAMED_INPUT
                        Input VCF file (overrides positional)
  -o, --output OUTPUT   Output embeddings file (default: stdout)
  -r, --reference REFERENCE
                        Path to reference genome FASTA file (or set
                        BIOFM_REFERENCE_GENOME env var)
  -a, --annotation ANNOTATION
                        Path to gene annotation GFF3 file (or set
                        BIOFM_GENE_ANNOTATION env var)
  -m, --model MODEL     HuggingFace model name or local path (default:
                        m42-health/BioFM-265M)
  -f, --format {TSV,HUGGINGFACE}
                        Output format: TSV or HUGGINGFACE JSON (default: TSV)
  --variant-key {CHROM_POS,CHROM_POS_REF_ALT,VCF_ID}
                        Variant key format in output (default:
                        CHROM_POS_REF_ALT)
  --max-variants MAX_VARIANTS
                        Maximum number of variants to process (default: all)
  --device {cuda,cpu}   Device for model inference (default: auto-detect)
  -v, --verbose         Print progress messages on stderr (default: false)
```

