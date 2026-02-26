cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaboot
label: msaboot
doc: "This program bootstraps FASTA input data.\n\nTool homepage: https://github.com/phac-nml/msaboot"
inputs:
  - id: input_location
    type: File
    doc: The file name of the FASTA file to be used as input.
    inputBinding:
      position: 101
      prefix: --input
  - id: num_replicates
    type: int
    doc: The number of bootstrap replicates.
    inputBinding:
      position: 101
      prefix: --number
outputs:
  - id: out_location
    type: File
    doc: The file name of the bootstrapped alignment data output, stored in 
      relaxed PHYLIP format.
    outputBinding:
      glob: $(inputs.out_location)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaboot:0.1.2--py_1
