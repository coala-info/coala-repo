# beamspy CWL Generation Report

## beamspy_group-features

### Tool Description
Groups features based on correlation and retention time.

### Metadata
- **Docker Image**: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/computational-metabolomics/beamspy
- **Package**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/computational-metabolomics/beamspy
- **Stars**: N/A
### Original Help Text
```text
Executing BEAMSpy version 1.2.0.
usage: beamspy group-features [-h] -l PEAKLIST -i INTENSITY_MATRIX -d DB -r
                              MAX_RT_DIFF -m {pearson,spearman} -c
                              COEFF_THRESHOLD -p PVALUE_THRESHOLD [-o] -g
                              GML_FILE [-n NCPUS]

options:
  -h, --help            show this help message and exit
  -l PEAKLIST, --peaklist PEAKLIST
                        Tab-delimited peaklist.
  -i INTENSITY_MATRIX, --intensity-matrix INTENSITY_MATRIX
                        Tab-delimited intensity matrix.
  -d DB, --db DB        Sqlite database to write results.
  -r MAX_RT_DIFF, --max-rt-diff MAX_RT_DIFF
                        Maximum difference in retention time between two
                        peaks.
  -m {pearson,spearman}, --method {pearson,spearman}
                        Method to apply for grouping features.
  -c COEFF_THRESHOLD, --coeff-threshold COEFF_THRESHOLD
                        Threshold for correlation coefficient.
  -p PVALUE_THRESHOLD, --pvalue-threshold PVALUE_THRESHOLD
                        Threshold for p-value.
  -o, --positive        Use positive correlation only otherwise use both
                        positive and negative correlation.
  -g GML_FILE, --gml-file GML_FILE
                        Write graph to GraphML format.
  -n NCPUS, --ncpus NCPUS
                        Number of central processing units (CPUs).
```


## beamspy_annotate-peak-patterns

### Tool Description
Annotate peaks with adducts, isotopes, oligomers, and neutral losses.

### Metadata
- **Docker Image**: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/computational-metabolomics/beamspy
- **Package**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing BEAMSpy version 1.2.0.
usage: beamspy annotate-peak-patterns [-h] -l PEAKLIST [-i INTENSITY_MATRIX]
                                      [-g GML_FILE] -d DB [-a]
                                      [-b ADDUCTS_LIBRARY] [-e]
                                      [-f ISOTOPES_LIBRARY] [-o] [-n]
                                      [-s NEUTRAL_LOSSES_LIBRARY] -m {pos,neg}
                                      -p PPM [-u MAX_MONOMER_UNITS]

options:
  -h, --help            show this help message and exit
  -l PEAKLIST, --peaklist PEAKLIST
                        Tab-delimited peaklist.
  -i INTENSITY_MATRIX, --intensity-matrix INTENSITY_MATRIX
                        Tab-delimited intensity matrix.
  -g GML_FILE, --gml-file GML_FILE
                        Correlation graph in GraphML format.
  -d DB, --db DB        Sqlite database to write results.
  -a, --adducts         Annotate adducts.
  -b ADDUCTS_LIBRARY, --adducts-library ADDUCTS_LIBRARY
                        List of adducts.
  -e, --isotopes        Annotate isotopes.
  -f ISOTOPES_LIBRARY, --isotopes-library ISOTOPES_LIBRARY
                        List of isotopes.
  -o, --oligomers       Annotate oligomers.
  -n, --neutral-losses  Annotate neutral losses.
  -s NEUTRAL_LOSSES_LIBRARY, --neutral-losses-library NEUTRAL_LOSSES_LIBRARY
                        List of neutral losses.
  -m {pos,neg}, --ion-mode {pos,neg}
                        Ion mode of the libraries.
  -p PPM, --ppm PPM     Mass tolerance in parts per million.
  -u MAX_MONOMER_UNITS, --max-monomer-units MAX_MONOMER_UNITS
                        Maximum number of monomer units.
```


## beamspy_annotate-mf

### Tool Description
Annotate molecular formulas for peaks.

### Metadata
- **Docker Image**: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/computational-metabolomics/beamspy
- **Package**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing BEAMSpy version 1.2.0.
usage: beamspy annotate-mf [-h] -l PEAKLIST [-i INTENSITY_MATRIX] -d DB
                           [-c DB_MF] [-a ADDUCTS_LIBRARY] -m {pos,neg} -p PPM
                           [-e] [-r] [-z MAX_MZ]

options:
  -h, --help            show this help message and exit
  -l PEAKLIST, --peaklist PEAKLIST
                        Tab-delimited peaklist.
  -i INTENSITY_MATRIX, --intensity-matrix INTENSITY_MATRIX
                        Tab-delimited intensity matrix.
  -d DB, --db DB        Sqlite database to write results.
  -c DB_MF, --db-mf DB_MF
                        Molecular formulae database (reference).
  -a ADDUCTS_LIBRARY, --adducts-library ADDUCTS_LIBRARY
                        List of adducts to search for.
  -m {pos,neg}, --ion-mode {pos,neg}
                        Ion mode of the libraries.
  -p PPM, --ppm PPM     Mass tolerance in parts per million.
  -e, --skip-patterns   Skip applying/using peak patterns (e.g. adduct and
                        isotope patterns) to filter annotations.
  -r, --skip-rules      Skip heuritic rules to filter annotations.
  -z MAX_MZ, --max-mz MAX_MZ
                        Maximum m/z value to assign molecular formula(e).
```


## beamspy_annotate-compounds

### Tool Description
Annotate compounds using a peaklist and a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/computational-metabolomics/beamspy
- **Package**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing BEAMSpy version 1.2.0.
usage: beamspy annotate-compounds [-h] -l PEAKLIST [-i INTENSITY_MATRIX] -d DB
                                  [-c DB_COMPOUNDS] -n DB_NAME
                                  [-a ADDUCTS_LIBRARY] -m {pos,neg} -p PPM
                                  [-e] [-r RT]

options:
  -h, --help            show this help message and exit
  -l PEAKLIST, --peaklist PEAKLIST
                        Tab-delimited peaklist.
  -i INTENSITY_MATRIX, --intensity-matrix INTENSITY_MATRIX
                        Tab-delimited intensity matrix.
  -d DB, --db DB        Sqlite database to write results.
  -c DB_COMPOUNDS, --db-compounds DB_COMPOUNDS
                        Metabolite database (reference).
  -n DB_NAME, --db-name DB_NAME
                        Name compound / metabolite database (within --db-
                        compounds).
  -a ADDUCTS_LIBRARY, --adducts-library ADDUCTS_LIBRARY
                        List of adducts to search for.
  -m {pos,neg}, --ion-mode {pos,neg}
                        Ion mode of the libraries.
  -p PPM, --ppm PPM     Mass tolerance in parts per million.
  -e, --skip-patterns   Skip applying/using peak patterns (e.g. adduct and
                        isotope patterns) to filter annotations.
  -r RT, --rt RT        Retention time tolerance in seconds.
```


## beamspy_summary-results

### Tool Description
Generates a summary of BEAMSpy results.

### Metadata
- **Docker Image**: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/computational-metabolomics/beamspy
- **Package**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing BEAMSpy version 1.2.0.
usage: beamspy summary-results [-h] -l PEAKLIST [-i INTENSITY_MATRIX] -o
                               OUTPUT [-p PDF] -d DB -s {tab,comma} [-r] [-c]
                               [-n NDIGITS_MZ] [-t {sec,min,None}]

options:
  -h, --help            show this help message and exit
  -l PEAKLIST, --peaklist PEAKLIST
                        Tab-delimited peaklist
  -i INTENSITY_MATRIX, --intensity-matrix INTENSITY_MATRIX
                        Tab-delimited intensity matrix.
  -o OUTPUT, --output OUTPUT
                        Output file for the summary
  -p PDF, --pdf PDF     Output pdf file for the summary plots
  -d DB, --db DB        Sqlite database that contains the results from the
                        previous steps.
  -s {tab,comma}, --sep {tab,comma}
                        Values on each line of the output are separated by
                        this character.
  -r, --single-row      Concatenate the annotations for each spectral feature
                        and represent in a single row.
  -c, --single-column   Concatenate the annotations for each spectral feature
                        and keep seperate columns for molecular formula,
                        adduct, name, etc.
  -n NDIGITS_MZ, --ndigits-mz NDIGITS_MZ
                        Digits after the decimal point for m/z values.
  -t {sec,min,None}, --convert-rt {sec,min,None}
                        Covert the retention time to seconds or minutes. An
                        additional column will be added.
```


## beamspy_start-gui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/computational-metabolomics/beamspy
- **Package**: https://anaconda.org/channels/bioconda/packages/beamspy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Executing BEAMSpy version 1.2.0.
usage: beamspy start-gui [-h]

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: not generated
