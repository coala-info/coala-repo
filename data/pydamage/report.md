# pydamage CWL Generation Report

## pydamage_analyze

### Tool Description
Analyze BAM files for DNA damage.

### Metadata
- **Docker Image**: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/pydamage
- **Package**: https://anaconda.org/channels/bioconda/packages/pydamage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pydamage/overview
- **Total Downloads**: 18.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxibor/pydamage
- **Stars**: N/A
### Original Help Text
```text
Usage: pydamage analyze [OPTIONS] BAM
Try 'pydamage analyze --help' for help.

Error: Missing argument 'BAM'.
```


## pydamage_filter

### Tool Description
Filter PyDamage results on predicted accuracy and qvalue thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/pydamage
- **Package**: https://anaconda.org/channels/bioconda/packages/pydamage/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pydamage filter [OPTIONS] CSV

  Filter PyDamage results on predicted accuracy and qvalue thresholds.

  CSV: path to PyDamage result file

Options:
  --help  Show this message and exit.
```


## pydamage_binplot

### Tool Description
Plot Damage patterns for a given bin fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/pydamage
- **Package**: https://anaconda.org/channels/bioconda/packages/pydamage/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pydamage binplot [OPTIONS] CSV FASTA

  Plot Damage patterns for a given bin fasta file

  CSV: path to PyDamage result file

  FASTA: path to bin fasta file

Options:
  --help  Show this message and exit.
```


## pydamage_cite

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/pydamage
- **Package**: https://anaconda.org/channels/bioconda/packages/pydamage/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
@article{borry_pydamage_2021,
    author = {Borry, Maxime and Hübner, Alexander and Rohrlach, Adam B. and Warinner, Christina},
    doi = {10.7717/peerj.11845},
    issn = {2167-8359},
    journal = {PeerJ},
    language = {en},
    month = {July},
    note = {Publisher: PeerJ Inc.},
    pages = {e11845},
    shorttitle = {PyDamage},
    title = {PyDamage: automated ancient damage identification and estimation for contigs in ancient DNA de novo assembly},
    url = {https://peerj.com/articles/11845},
    urldate = {2021-07-27},
    volume = {9},
    year = {2021}
}
```


## Metadata
- **Skill**: generated
