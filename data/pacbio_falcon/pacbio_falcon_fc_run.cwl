cwlVersion: v1.2
class: CommandLineTool
baseCommand: fc_run
label: pacbio_falcon_fc_run
doc: "PacBio FALCON genome assembly tool. (Note: The provided help text contains only
  system error logs and does not list command-line arguments.)\n\nTool homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon_fc_run.out
