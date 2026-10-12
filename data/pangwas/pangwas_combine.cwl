cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - combine
label: pangwas_combine
doc: "Combine variants from multiple Rtab files.\n\nTakes as input a list of file paths to Rtab files. Outputs an Rtab file with\nthe variants concatenated, ensuring consistent ordering of the sample columns.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: rtab
    type:
      type: array
      items: File
    doc: "Rtab variants files."
    inputBinding:
      position: 101
      prefix: --rtab
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: combined_rtab
    type: File
    doc: "Rtab file with the variants concatenated"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'combine.Rtab')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
