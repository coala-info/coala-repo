cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SCNIC_analysis.py, between]
label: scnic_between
doc: "Find correlations between two tables\n\nTool homepage: https://github.com/lozuponelab/SCNIC"
inputs:
  - id: table1
    type: File
    doc: table to be correlated
    inputBinding:
      prefix: '-1'
  - id: table2
    type: File
    doc: second table to be correlated
    inputBinding:
      prefix: '-2'
  - id: output_loc
    type: string
    doc: output file location
    inputBinding:
      prefix: -o
  - id: correl_method
    type: ['null', string]
    doc: 'correlation method (default: spearman)'
    inputBinding:
      prefix: -m
  - id: p_adjust
    type: ['null', string]
    doc: 'p-value adjustment (default: fdr_bh)'
    inputBinding:
      prefix: -a
  - id: min_sample
    type: ['null', int]
    doc: minimum number of samples present in
    inputBinding:
      prefix: -s
  - id: max_p
    type: ['null', double]
    doc: max p-value to determine edges
    inputBinding:
      prefix: --max_p
  - id: min_r
    type: ['null', double]
    doc: minimum R to determine edges
    inputBinding:
      prefix: --min_r
  - id: sparcc_filter
    type: ['null', boolean]
    doc: filter using parameters from SparCC publication
    inputBinding:
      prefix: --sparcc_filter
  - id: procs
    type: ['null', int]
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      prefix: --procs
  - id: force
    type: ['null', boolean]
    doc: force overwrite output folder if it already exists
    inputBinding:
      prefix: -f
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder with the between-table correlations
    outputBinding:
      glob: $(inputs.output_loc)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
