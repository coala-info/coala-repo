cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome filter
label: metaquantome_filter
doc: "The filter module is the second step in the metaQuantome analysis workflow.
  The purpose of the filter module is to filter expanded terms to those that are representative
  and well-supported by the data. Please see the manuscript (https://doi.org/10.1074/mcp.ra118.001240)
  for further details about filtering.\n\nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to data directory.
    default: <metaquantome_pkg_dir>/data
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: expand_file
    type:
      - 'null'
      - File
    doc: Output from metaquantome expand.
    inputBinding:
      position: 101
      prefix: --expand_file
  - id: min_child_nsamp
    type:
      - 'null'
      - string
    doc: Number of samples per group that must meet or exceed min_child_nsamp. 
      Can either be a nonnegative integer or 'all'.
    inputBinding:
      position: 101
      prefix: --min_child_nsamp
  - id: min_children_non_leaf
    type:
      - 'null'
      - int
    doc: Used for filtering to informative annotations. A term is retained if it
      has a number of children greater than or equal to min_children_non_leaf.
    default: 0
    inputBinding:
      position: 101
      prefix: --min_children_non_leaf
  - id: min_pep_nsamp
    type:
      - 'null'
      - string
    doc: Number of samples per group that must meet or exceed min_peptides. Can 
      either be a nonnegative integer or 'all'.
    inputBinding:
      position: 101
      prefix: --min_pep_nsamp
  - id: min_peptides
    type:
      - 'null'
      - int
    doc: Used for filtering to well-supported annotations. The number of 
      peptides providing evidence for a term is the number of peptides directly 
      annotated with that term plus the number of peptides annotated with any of
      its descendants. Terms with a number of peptides greater than or equal to 
      min_peptides are retained.
    default: 0
    inputBinding:
      position: 101
      prefix: --min_peptides
  - id: mode
    type: string
    doc: Analysis mode. If ft is chosen, both function and taxonomy files must 
      be provided
    inputBinding:
      position: 101
      prefix: --mode
  - id: ontology
    type:
      - 'null'
      - string
    doc: Which functional terms to use. Ignored (and not required) if mode is 
      not f or ft.
    inputBinding:
      position: 101
      prefix: --ontology
  - id: qthreshold
    type:
      - 'null'
      - int
    doc: Minimum number of intensities in each sample group. Any 
      functional/taxonomic term with lower number of per-group intensities will 
      be filtered out. The default is 3, because this is the minimum number for 
      t-tests.
    default: 3
    inputBinding:
      position: 101
      prefix: --qthreshold
  - id: samps
    type: string
    doc: 'Give the column names in the intensity file that correspond to a given sample
      group. This can either be JSON formatted or be a path to a tabular file. JSON
      example of two experimental groups and two samples in each group: {"A": ["A1",
      "A2"], "B": ["B1", "B2"]}'
    inputBinding:
      position: 101
      prefix: --samps
outputs:
  - id: outfile
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
