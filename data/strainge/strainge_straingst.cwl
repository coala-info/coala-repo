cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainge
  - straingst
label: strainge_straingst
doc: "Strain-level profiling of metagenomic samples (Note: The provided text contains
  container execution errors and no help documentation; therefore, no arguments could
  be parsed).\n\nTool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py310hd22044e_1
stdout: strainge_straingst.out
