cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer count-orfs
label: ribotricer_count-orfs
doc: "Count reads for detected ORFs at gene level\n\nTool homepage: https://github.com/smithlabcode/ribotricer"
inputs:
  - id: detected_orfs
    type: File
    doc: "Path to the detected orfs file This file should be\n                   \
      \        generated using ribotricer detect-orfs"
    inputBinding:
      position: 101
      prefix: --detected_orfs
  - id: features
    type: string
    doc: ORF types separated with comma
    inputBinding:
      position: 101
      prefix: --features
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: "Whether output all ORFs including those non-\n                         \
      \  translating ones"
    inputBinding:
      position: 101
      prefix: --report_all
  - id: ribotricer_index
    type: File
    doc: "Path to the index file of ribotricer This file\n                       \
      \    should be generated using ribotricer prepare-orfs"
    inputBinding:
      position: 101
      prefix: --ribotricer_index
outputs:
  - id: out
    type: File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
