# crisprbact CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crisprbact_predict_from-seq | PASS |  |
| crisprbact_predict_from-str | PASS |  |

## Metadata
- **Skill**: not generated

## crisprbact_predict_from-seq

### Tool Description
Outputs candidate guide RNAs for the S. pyogenes dCas9 with predicted on-target activity from a target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprbact:0.3.11--py_0
- **Homepage**: https://gitlab.pasteur.fr/dbikard/crisprbact
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprbact/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprbact/overview
- **Total Downloads**: 22.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A

### Original Help Text
```text
Usage: crisprbact predict from-seq [OPTIONS] [OUTPUT_FILE]

  Outputs candidate guide RNAs for the S. pyogenes dCas9 with predicted on-
  target activity from a target gene.

  [OUTPUT_FILE] file where the candidate guide RNAs are saved. Default =
  "stdout"

Options:
  -t, --target FILENAME           Sequence file to target  [required]
  -f, --seq-format [fasta|gb|genbank]
                                  Sequence file to target format  [default:
                                  fasta]

  -s, --off-target-sequence FILENAME
                                  Sequence in which you want to find off-
                                  targets

  -w, --off-target-sequence-format [fasta|gb|genbank]
                                  Sequence in which you want to find off-
                                  targets format  [default: genbank]

  --help                          Show this message and exit.
```

## crisprbact_predict_from-str

### Tool Description
Outputs candidate guide RNAs for the S. pyogenes dCas9 with predicted on-target activity from a target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprbact:0.3.11--py_0
- **Homepage**: https://gitlab.pasteur.fr/dbikard/crisprbact
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprbact/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprbact/overview
- **Total Downloads**: 22.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A

### Original Help Text
```text
Usage: crisprbact predict from-str [OPTIONS] [OUTPUT_FILE]

  Outputs candidate guide RNAs for the S. pyogenes dCas9 with predicted on-
  target activity from a target gene.

  [OUTPUT_FILE] file where the candidate guide RNAs are saved. Default =
  "stdout"

Options:
  -t, --target TEXT               Sequence file to target  [required]
  -s, --off-target-sequence FILENAME
                                  Sequence in which you want to find off-
                                  targets

  -w, --off-target-sequence-format [fasta|gb|genbank]
                                  Sequence in which you want to find off-
                                  targets format  [default: genbank]

  --help                          Show this message and exit.
```
