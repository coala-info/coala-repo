cwlVersion: v1.2
class: CommandLineTool
baseCommand: corona_lineage_dynamics
label: corona_lineage_dynamics
doc: "A tool for analyzing corona lineage dynamics. Note: The provided help text appears
  to be a system error log regarding a container build failure and does not contain
  usage information or argument definitions.\n\nTool homepage: https://github.com/hzi-bifo/corona_lineage_dynamics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/corona_lineage_dynamics:0.1.7--r44h6a1216f_0
stdout: corona_lineage_dynamics.out
