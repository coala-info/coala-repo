cwlVersion: v1.2
class: CommandLineTool
baseCommand: maracluster
label: maracluster
doc: "MaRaCluster is a tool for clustering tandem mass spectra. (Note: The provided
  help text contains only system error logs and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
stdout: maracluster.out
