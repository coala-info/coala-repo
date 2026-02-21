cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacbio_falcon_variantCaller
label: pacbio_falcon_variantCaller
doc: "A tool for variant calling within the PacBio FALCON assembly pipeline. Note:
  The provided text contains system error messages and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon_variantCaller.out
