cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec split
label: seqspec_split
doc: "Split seqspec file into one file per modality.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Path to output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
