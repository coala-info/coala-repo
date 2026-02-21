cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainge
  - straingr
label: strainge_straingr
doc: "The provided text does not contain help information for the tool; it contains
  container runtime logs indicating a failure to build or fetch the image.\n\nTool
  homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py310hd22044e_1
stdout: strainge_straingr.out
