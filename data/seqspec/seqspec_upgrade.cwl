cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec upgrade
label: seqspec_upgrade
doc: "Upgrade seqspec file from older versions to the current version.\n\nTool homepage:
  https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
