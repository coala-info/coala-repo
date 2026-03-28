# ms2pip CWL Generation Report

## ms2pip_annotate-spectra

### Tool Description
Annotate observed spectra.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
- **Homepage**: http://compomics.github.io/projects/ms2pip_c
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Total Downloads**: 23.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/compomics/ms2pip_c
- **Stars**: N/A
### Original Help Text
```text
MS²PIP (v4.1.0)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Declercq et al. NAR (2023)

Usage: ms2pip annotate-spectra [OPTIONS] PSMS SPECTRUM_FILE

  Annotate observed spectra.

Options:
  -t, --psm-filetype [flashlfq|ionbot|idxml|msms|mzid|peprec|pepxml|percolator|proteome_discoverer|proteoscape|xtandem|msamanda|sage_tsv|sage_parquet|fragpipe|alphadia|diann|parquet|tsv|sage]
  -o, --output-name TEXT
  -p, --spectrum-id-pattern TEXT
  --model [CID|HCD2019|TTOF5600|TMT|iTRAQ|iTRAQphospho|HCDch2|CIDch2|HCD2021|Immuno-HCD|CID-TMT|timsTOF2023|timsTOF2024|HCD|timsTOF]
  --ms2-tolerance FLOAT
  -n, --processes INTEGER
  --help                          Show this message and exit.
```


## ms2pip_correlate

### Tool Description
Compare predicted and observed intensities and optionally compute correlations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
- **Homepage**: http://compomics.github.io/projects/ms2pip_c
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Validation**: PASS

### Original Help Text
```text
MS²PIP (v4.1.0)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Declercq et al. NAR (2023)

Usage: ms2pip correlate [OPTIONS] PSMS SPECTRUM_FILE

  Compare predicted and observed intensities and optionally compute
  correlations.

Options:
  -t, --psm-filetype [flashlfq|ionbot|idxml|msms|mzid|peprec|pepxml|percolator|proteome_discoverer|proteoscape|xtandem|msamanda|sage_tsv|sage_parquet|fragpipe|alphadia|diann|parquet|tsv|sage]
  -o, --output-name TEXT
  -p, --spectrum-id-pattern TEXT
  -x, --compute-correlations
  -r, --add-retention-time
  -i, --add-ion-mobility
  --model [CID|HCD2019|TTOF5600|TMT|iTRAQ|iTRAQphospho|HCDch2|CIDch2|HCD2021|Immuno-HCD|CID-TMT|timsTOF2023|timsTOF2024|HCD|timsTOF]
  --model-dir TEXT
  --ms2-tolerance FLOAT
  -n, --processes INTEGER
  --help                          Show this message and exit.
```


## ms2pip_get-training-data

### Tool Description
Extract feature vectors and target intensities from observed spectra for training.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
- **Homepage**: http://compomics.github.io/projects/ms2pip_c
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Validation**: PASS

### Original Help Text
```text
MS²PIP (v4.1.0)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Declercq et al. NAR (2023)

Usage: ms2pip get-training-data [OPTIONS] PSMS SPECTRUM_FILE

  Extract feature vectors and target intensities from observed spectra for
  training.

Options:
  -t, --psm-filetype [flashlfq|ionbot|idxml|msms|mzid|peprec|pepxml|percolator|proteome_discoverer|proteoscape|xtandem|msamanda|sage_tsv|sage_parquet|fragpipe|alphadia|diann|parquet|tsv|sage]
  -o, --output-name TEXT
  -p, --spectrum-id-pattern TEXT
  --model [CID|HCD2019|TTOF5600|TMT|iTRAQ|iTRAQphospho|HCDch2|CIDch2|HCD2021|Immuno-HCD|CID-TMT|timsTOF2023|timsTOF2024|HCD|timsTOF]
  --ms2-tolerance FLOAT
  -n, --processes INTEGER
  --help                          Show this message and exit.
```


## ms2pip_predict-batch

### Tool Description
Predict fragmentation spectra for a batch of peptides.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
- **Homepage**: http://compomics.github.io/projects/ms2pip_c
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Validation**: PASS

### Original Help Text
```text
MS²PIP (v4.1.0)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Declercq et al. NAR (2023)

Usage: ms2pip predict-batch [OPTIONS] PSMS

  Predict fragmentation spectra for a batch of peptides.

Options:
  -t, --psm-filetype [flashlfq|ionbot|idxml|msms|mzid|peprec|pepxml|percolator|proteome_discoverer|proteoscape|xtandem|msamanda|sage_tsv|sage_parquet|fragpipe|alphadia|diann|parquet|tsv|sage]
  -o, --output-name TEXT
  -f, --output-format [tsv|msp|mgf|spectronaut|bibliospec|dlib]
  -r, --add-retention-time
  -i, --add-ion-mobility
  --model [CID|HCD2019|TTOF5600|TMT|iTRAQ|iTRAQphospho|HCDch2|CIDch2|HCD2021|Immuno-HCD|CID-TMT|timsTOF2023|timsTOF2024|HCD|timsTOF]
  --model-dir TEXT
  -n, --processes INTEGER
  --help                          Show this message and exit.
```


## ms2pip_predict-library

### Tool Description
Predict spectral library from protein FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
- **Homepage**: http://compomics.github.io/projects/ms2pip_c
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Validation**: PASS

### Original Help Text
```text
MS²PIP (v4.1.0)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Declercq et al. NAR (2023)

Usage: ms2pip predict-library [OPTIONS] [FASTA_FILE]

  Predict spectral library from protein FASTA file.

Options:
  -c, --config FILE
  -o, --output-name TEXT
  -f, --output-format [tsv|msp|mgf|spectronaut|bibliospec|dlib]
  -r, --add-retention-time
  -i, --add-ion-mobility
  --model [CID|HCD2019|TTOF5600|TMT|iTRAQ|iTRAQphospho|HCDch2|CIDch2|HCD2021|Immuno-HCD|CID-TMT|timsTOF2023|timsTOF2024|HCD|timsTOF]
  --model-dir TEXT
  --batch-size INTEGER
  -n, --processes INTEGER
  --help                          Show this message and exit.
```


## ms2pip_predict-single

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
- **Homepage**: http://compomics.github.io/projects/ms2pip_c
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2pip/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
MS²PIP (v4.1.0)
Developed at CompOmics, VIB / Ghent University, Belgium.
Please cite: Declercq et al. NAR (2023)
```


## Metadata
- **Skill**: generated
