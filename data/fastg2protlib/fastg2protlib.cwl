cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastg2protlib
label: fastg2protlib
doc: "A tool to convert FASTG files to protein libraries. (Note: The provided help
  text contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/galaxyproteomics/fastg2protlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastg2protlib:1.0.2--py_0
stdout: fastg2protlib.out
