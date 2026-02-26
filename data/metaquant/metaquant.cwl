cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquant
label: metaquant
doc: "metaquant [-h] --mode {fn,tax,taxfn} --samps SAMPS --int_file INT_FILE --pep_colname
  PEP_COLNAME --outfile OUTFILE [--func_file FUNC_FILE] [--ontology {go,cog}] [--obo_path
  OBO_PATH] [--slim_path SLIM_PATH] [--slim_down] [--update_obo] [--tax_file TAX_FILE]
  [--tax_colname TAX_COLNAME] [--test] [--paired] [--threshold THRESHOLD]\n\nTool
  homepage: The package home page"
inputs:
  - id: func_file
    type:
      - 'null'
      - File
    doc: Path to file with function. The file must be tabular, with a peptide 
      sequence column and either a GO-term column (named "go") and/or a COG 
      column (named "cog").
    inputBinding:
      position: 101
      prefix: --func_file
  - id: int_file
    type: File
    doc: Path to the file with intensity data. Must be tabular, have a peptide 
      sequence column, and be raw, untransformed intensity values. Missing 
      values can be 0, NA, or NaN- transformed to NA for analysis
    inputBinding:
      position: 101
      prefix: --int_file
  - id: mode
    type: string
    doc: Analysis mode. If taxfun is chosen, both function and taxonomy files 
      must be provided
    inputBinding:
      position: 101
      prefix: --mode
  - id: obo_path
    type:
      - 'null'
      - File
    doc: Path to full obo. If obo_path does not exist, the file will be 
      downloaded.
    inputBinding:
      position: 101
      prefix: --obo_path
  - id: ontology
    type:
      - 'null'
      - string
    doc: Which functional terms to use. This also corresponds to the column name
      in func_file
    inputBinding:
      position: 101
      prefix: --ontology
  - id: paired
    type:
      - 'null'
      - boolean
    doc: If --test and --paired are provided, perform paired t-tests.
    inputBinding:
      position: 101
      prefix: --paired
  - id: pep_colname
    type: string
    doc: The column name within the intensity, function, and/or taxonomy file 
      that corresponds to the peptide sequences.
    inputBinding:
      position: 101
      prefix: --pep_colname
  - id: samps
    type: string
    doc: 'Give the column names in the intensity file that correspond to a given sample
      group. This can either be JSON formatted or be a path to a tabular file. JSON
      example of two experimental groups and two samples in each group: {"A": ["A1",
      "A2"], "B": ["B1", "B2"]}'
    inputBinding:
      position: 101
      prefix: --samps
  - id: slim_down
    type:
      - 'null'
      - boolean
    doc: Flag. If provided, terms are mapped from the full OBO to the slim OBO. 
      Terms not in the full OBO will be skipped.
    inputBinding:
      position: 101
      prefix: --slim_down
  - id: slim_path
    type:
      - 'null'
      - File
    doc: Path to generic slim obo. If slim_path does not exist, the file will be
      downloaded.
    inputBinding:
      position: 101
      prefix: --slim_path
  - id: tax_colname
    type:
      - 'null'
      - string
    doc: Name of taxonomy column in tax file. The column must be either NCBI 
      taxids (strongly preferred) or taxonomy names. Unipept name output is 
      known to function well, but other formats may not work.
    inputBinding:
      position: 101
      prefix: --tax_colname
  - id: tax_file
    type:
      - 'null'
      - File
    doc: Path to (tabular) file with taxonomy assignments. There should be a 
      peptide sequence column with name pep_colname, and a taxonomy column with 
      name tax_colname
    inputBinding:
      position: 101
      prefix: --tax_file
  - id: test
    type:
      - 'null'
      - boolean
    doc: Perform t-tests on the summed intensities.FDR-corrected q-values are 
      returned.
    inputBinding:
      position: 101
      prefix: --test
  - id: threshold
    type:
      - 'null'
      - int
    doc: Minimum number of intensities in each sample group. Anything with lower
      number of intensities will be filtered out.Only applies when testing, not 
      to descriptive statistics.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: update_obo
    type:
      - 'null'
      - boolean
    doc: 'Flag. If provided, the most recent OBO file is downloaded to obo_path, and
      if slim_down, the most recent generic slim is downloaded as well. Caution: will
      overwrite anything at these locations.'
    inputBinding:
      position: 101
      prefix: --update_obo
outputs:
  - id: outfile
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquant:0.1.2--py35_0
