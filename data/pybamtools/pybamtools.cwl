cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybamtools
label: pybamtools
doc: "A tool for processing BAM files (Note: The provided text contains container
  build logs rather than CLI help documentation).\n\nTool homepage: https://github.com/blankenberg/pyBamTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybamtools:0.0.4--py27h24bf2e0_1
stdout: pybamtools.out
