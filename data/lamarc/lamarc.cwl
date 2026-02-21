cwlVersion: v1.2
class: CommandLineTool
baseCommand: lamarc
label: lamarc
doc: "Likelihood Analysis with Metropolis Algorithm using Random Coalescence (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/ChristopherBiscardi/lamarck"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lamarc:v2.1.10.1dfsg-3-deb_cv1
stdout: lamarc.out
