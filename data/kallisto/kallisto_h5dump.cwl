cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - h5dump
label: kallisto_h5dump
doc: "Converts HDF5-formatted results (abundance.h5) to plaintext\n\nTool homepage: https://pachterlab.github.io/kallisto"
inputs:
  - id: abundance_h5
    type: File
    doc: HDF5-formatted kallisto results (abundance.h5)
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: Directory to write output to
    inputBinding:
      position: 1
      prefix: --output-dir
outputs:
  - id: output_output_dir
    type: Directory
    doc: Directory with the plaintext results
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
