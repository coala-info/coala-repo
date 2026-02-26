cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec methods
label: seqspec_methods
doc: "Convert seqspec file into methods section.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: modality
    type: string
    doc: Modality
    inputBinding:
      position: 102
      prefix: --modality
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
