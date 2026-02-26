cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotate
label: haplomap_annotate
doc: "Convert ensembl-vep to eblocks (-g) input\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: in_vep_txt
    type: File
    doc: Input ensembl-VEP tab format file name
    inputBinding:
      position: 1
  - id: csq
    type:
      - 'null'
      - boolean
    doc: Output a annotation with impact score and sample names.
    inputBinding:
      position: 102
      prefix: --csq
  - id: prioritize
    type:
      - 'null'
      - boolean
    doc: Whether aggregate variant annotation by max impact score.
    default: false
    inputBinding:
      position: 102
      prefix: --prioritize
  - id: samples
    type:
      - 'null'
      - boolean
    doc: Only write annotation for the input samples (e.g. eblocks -s).
    inputBinding:
      position: 102
      prefix: --samples
  - id: type
    type:
      - 'null'
      - string
    doc: 'Select variant type: [snp|indel|sv|all].'
    default: all
    inputBinding:
      position: 102
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output file name, for (eblocks -g)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
