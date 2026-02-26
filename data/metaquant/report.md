# metaquant CWL Generation Report

## metaquant

### Tool Description
metaquant [-h] --mode {fn,tax,taxfn} --samps SAMPS --int_file INT_FILE --pep_colname PEP_COLNAME --outfile OUTFILE [--func_file FUNC_FILE] [--ontology {go,cog}] [--obo_path OBO_PATH] [--slim_path SLIM_PATH] [--slim_down] [--update_obo] [--tax_file TAX_FILE] [--tax_colname TAX_COLNAME] [--test] [--paired] [--threshold THRESHOLD]

### Metadata
- **Docker Image**: quay.io/biocontainers/metaquant:0.1.2--py35_0
- **Homepage**: The package home page
- **Package**: https://anaconda.org/channels/bioconda/packages/metaquant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaquant/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/caleb-easterly/metaquant
- **Stars**: N/A
### Original Help Text
```text
usage: metaquant [-h] --mode {fn,tax,taxfn} --samps SAMPS --int_file INT_FILE
                 --pep_colname PEP_COLNAME --outfile OUTFILE
                 [--func_file FUNC_FILE] [--ontology {go,cog}]
                 [--obo_path OBO_PATH] [--slim_path SLIM_PATH] [--slim_down]
                 [--update_obo] [--tax_file TAX_FILE]
                 [--tax_colname TAX_COLNAME] [--test] [--paired]
                 [--threshold THRESHOLD]

optional arguments:
  -h, --help            show this help message and exit

Required for all analyses:
  --mode {fn,tax,taxfn}, -m {fn,tax,taxfn}
                        Analysis mode. If taxfun is chosen, both function and
                        taxonomy files must be provided
  --samps SAMPS, -s SAMPS
                        Give the column names in the intensity file that
                        correspond to a given sample group. This can either be
                        JSON formatted or be a path to a tabular file. JSON
                        example of two experimental groups and two samples in
                        each group: {"A": ["A1", "A2"], "B": ["B1", "B2"]}
  --int_file INT_FILE, -i INT_FILE
                        Path to the file with intensity data. Must be tabular,
                        have a peptide sequence column, and be raw,
                        untransformed intensity values. Missing values can be
                        0, NA, or NaN- transformed to NA for analysis
  --pep_colname PEP_COLNAME
                        The column name within the intensity, function, and/or
                        taxonomy file that corresponds to the peptide
                        sequences.
  --outfile OUTFILE     Output file

Function:
  --func_file FUNC_FILE, -f FUNC_FILE
                        Path to file with function. The file must be tabular,
                        with a peptide sequence column and either a GO-term
                        column (named "go") and/or a COG column (named "cog").
  --ontology {go,cog}   Which functional terms to use. This also corresponds
                        to the column name in func_file
  --obo_path OBO_PATH   Path to full obo. If obo_path does not exist, the file
                        will be downloaded.
  --slim_path SLIM_PATH
                        Path to generic slim obo. If slim_path does not exist,
                        the file will be downloaded.
  --slim_down           Flag. If provided, terms are mapped from the full OBO
                        to the slim OBO. Terms not in the full OBO will be
                        skipped.
  --update_obo          Flag. If provided, the most recent OBO file is
                        downloaded to obo_path, and if slim_down, the most
                        recent generic slim is downloaded as well. Caution:
                        will overwrite anything at these locations.

Taxonomy:
  --tax_file TAX_FILE, -t TAX_FILE
                        Path to (tabular) file with taxonomy assignments.
                        There should be a peptide sequence column with name
                        pep_colname, and a taxonomy column with name
                        tax_colname
  --tax_colname TAX_COLNAME
                        Name of taxonomy column in tax file. The column must
                        be either NCBI taxids (strongly preferred) or taxonomy
                        names. Unipept name output is known to function well,
                        but other formats may not work.

Statistics:
  --test                Perform t-tests on the summed intensities.FDR-
                        corrected q-values are returned.
  --paired              If --test and --paired are provided, perform paired
                        t-tests.
  --threshold THRESHOLD
                        Minimum number of intensities in each sample group.
                        Anything with lower number of intensities will be
                        filtered out.Only applies when testing, not to
                        descriptive statistics.
```


## Metadata
- **Skill**: generated
