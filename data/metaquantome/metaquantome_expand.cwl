cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome expand
label: metaquantome_expand
doc: "The expand module is the first analysis step in the metaQuantome analysis workflow,
  and can be run to analyze function, taxonomy, or function and taxonomy together.\n\
  \nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to data directory. The default is <metaquantome_pkg_dir>/data
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: ft_tar_rank
    type:
      - 'null'
      - string
    doc: Desired rank for taxonomy. The default is 'genus'.
    default: genus
    inputBinding:
      position: 101
      prefix: --ft_tar_rank
  - id: func_colname
    type:
      - 'null'
      - string
    doc: Name of the functional column
    inputBinding:
      position: 101
      prefix: --func_colname
  - id: func_file
    type:
      - 'null'
      - File
    doc: Path to file with function. The file must be tabular, with a peptide 
      sequence column and either a GO-term column, COG column, or EC number 
      column. The name of the functional column should be given in 
      --func_colname. Other columns will be ignored.
    inputBinding:
      position: 101
      prefix: --func_file
  - id: int_file
    type:
      - 'null'
      - File
    doc: Path to the file with intensity data. Must be tabular, have a peptide 
      sequence column, and be raw, untransformed intensity values. Missing 
      values can be 0, NA, or NaN- transformed to NA for modules
    inputBinding:
      position: 101
      prefix: --int_file
  - id: mode
    type: string
    doc: Analysis mode. If ft is chosen, both function and taxonomy files must 
      be provided
    inputBinding:
      position: 101
      prefix: --mode
  - id: nopep
    type:
      - 'null'
      - boolean
    doc: If provided, need to provide a --nopep_file.
    inputBinding:
      position: 101
      prefix: --nopep
  - id: nopep_file
    type:
      - 'null'
      - File
    doc: File with functional or taxonomic annotations and intensities.
    inputBinding:
      position: 101
      prefix: --nopep_file
  - id: ontology
    type:
      - 'null'
      - string
    doc: Which functional terms to use. Ignored (and not required) if mode is 
      not f or ft.
    inputBinding:
      position: 101
      prefix: --ontology
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Flag. The most relevant database (GO or EC) is downloaded to data_dir, 
      overwriting any previously downloaded databases at these locations.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pep_colname_func
    type:
      - 'null'
      - string
    doc: The column name within the function file that corresponds to the 
      peptide sequences.
    inputBinding:
      position: 101
      prefix: --pep_colname_func
  - id: pep_colname_int
    type:
      - 'null'
      - string
    doc: The column name within the intensity file that corresponds to the 
      peptide sequences.
    inputBinding:
      position: 101
      prefix: --pep_colname_int
  - id: pep_colname_tax
    type:
      - 'null'
      - string
    doc: The column name within the taxonomy file that corresponds to the 
      peptide sequences.
    inputBinding:
      position: 101
      prefix: --pep_colname_tax
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
outputs:
  - id: outfile
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
