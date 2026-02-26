cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome stat
label: metaquantome_stat
doc: "The stat module is the third step in the metaQuantome analysis workflow. The
  purpose of the stat module is to perform differential expression analysis between
  2 experimental conditions. metaQuantome offers paired and unpaired tests, as well
  as parametric and non-parametric options.\n\nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs:
  - id: control_group
    type: string
    doc: Sample group name of control samples (will be used as denominator for 
      fold change).
    inputBinding:
      position: 101
      prefix: --control_group
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to data directory. The default is <metaquantome_pkg_dir>/data
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: file
    type: File
    doc: Output file from metaquantome expand.
    inputBinding:
      position: 101
      prefix: --file
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
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Perform paired tests.
    inputBinding:
      position: 101
      prefix: --paired
  - id: parametric
    type:
      - 'null'
      - boolean
    doc: Choose the type of test. If --parametric True is provided,then a 
      standard t-test is performed. If --parametric False (the default) is 
      provided, then a Wilcoxon test is performed.
    inputBinding:
      position: 101
      prefix: --parametric
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
