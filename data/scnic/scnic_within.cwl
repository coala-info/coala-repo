cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SCNIC_analysis.py, within]
label: scnic_within
doc: "Find pairwise correlations within a table\n\nTool homepage: https://github.com/lozuponelab/SCNIC"
inputs:
  - id: input_loc
    type: File
    doc: location of input biom file
    inputBinding:
      prefix: -i
  - id: output_loc
    type: string
    doc: output directory
    inputBinding:
      prefix: -o
  - id: correl_method
    type: ['null', string]
    doc: 'correlation method (default: sparcc)'
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
  - id: procs
    type: ['null', int]
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      prefix: --procs
  - id: sparcc_filter
    type: ['null', boolean]
    doc: filter as described in SparCC paper
    inputBinding:
      prefix: --sparcc_filter
  - id: sparcc_p
    type: ['null', int]
    doc: Calculate p-value for sparCC R value, give number of bootstraps
    inputBinding:
      prefix: --sparcc_p
  - id: verbose
    type: ['null', boolean]
    doc: give verbose messages to STDOUT
    inputBinding:
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the correlation results
    outputBinding:
      glob: $(inputs.output_loc)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
