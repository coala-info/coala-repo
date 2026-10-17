cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psirc-quant
  - h5dump
label: psirc_h5dump
doc: "Converts HDF5-formatted results to plaintext\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: abundance_h5
    type: File
    doc: "HDF5-formatted abundance file"
    inputBinding:
      position: 10
  - id: output_dir
    type: string
    doc: "Directory to write output to"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output
    type: Directory
    doc: "Output directory with the plaintext results"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
