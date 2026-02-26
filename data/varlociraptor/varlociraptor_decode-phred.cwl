cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlociraptor decode-phred
label: varlociraptor_decode-phred
doc: "Decode PHRED-scaled values to human readable probabilities.\n\nTool homepage:
  https://varlociraptor.github.io"
inputs:
  - id: input_bcf
    type: File
    doc: Input BCF file
    inputBinding:
      position: 1
outputs:
  - id: output_bcf
    type: File
    doc: Output BCF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
