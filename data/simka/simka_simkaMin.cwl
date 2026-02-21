cwlVersion: v1.2
class: CommandLineTool
baseCommand: simkaMin
label: simka_simkaMin
doc: "SimkaMin is a tool for fast comparative metagenomics. (Note: The provided help
  text contains only container runtime error logs and does not list usage or arguments.)\n
  \nTool homepage: https://github.com/GATB/simka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simka:1.5.3--he513fc3_0
stdout: simka_simkaMin.out
