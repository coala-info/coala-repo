cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAhybrid
label: rnahybrid
doc: "RNAhybrid is a tool for finding the minimum free energy hybridization of a long
  and a short RNA. (Note: The provided text contains system error messages from a
  container runtime and does not include command-line usage or argument descriptions.)\n
  \nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnahybrid"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rnahybrid:v2.1.2-5-deb_cv1
stdout: rnahybrid.out
