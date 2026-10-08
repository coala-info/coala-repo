cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplomap
  - annotate
label: haplomap_annotate
doc: "Convert ensembl-vep to eblocks (-g) input\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: csq
    type:
      - 'null'
      - string
    doc: "Output file name for an annotation with impact score and sample names."
    inputBinding:
      position: 1
      prefix: --csq
  - id: prioritize
    type:
      - 'null'
      - boolean
    doc: "Whether aggregate variant annotation by max impact score. Default: false"
    inputBinding:
      position: 1
      prefix: -p
  - id: samples
    type:
      - 'null'
      - File
    doc: "Only write annotation for the input samples (e.g. eblocks -s)."
    inputBinding:
      position: 1
      prefix: --samples
  - id: type
    type:
      - 'null'
      - string
    doc: "Select variant type: [snp|indel|sv|all]. Default: all"
    inputBinding:
      position: 1
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: output_path
    type: string
    doc: "Output file name, for (eblocks -g)"
    inputBinding:
      position: 1
      prefix: --output
  - id: in_vep_txt
    type: File
    doc: "Input ensembl-VEP tab format file name"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "Annotation file for eblocks -g"
    outputBinding:
      glob: $(inputs.output_path)
  - id: csq_out
    type:
      - 'null'
      - File
    doc: "Annotation with impact score and sample names, written with --csq"
    outputBinding:
      glob: $(inputs.csq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
