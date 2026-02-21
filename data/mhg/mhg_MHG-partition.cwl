cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhg
  - MHG-partition
label: mhg_MHG-partition
doc: "MHG-partition tool (Note: The provided text contains system error messages and
  does not include usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/NakhlehLab/Maximal-Homologous-Groups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
stdout: mhg_MHG-partition.out
