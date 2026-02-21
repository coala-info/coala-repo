cwlVersion: v1.2
class: CommandLineTool
baseCommand: reapr
label: reapr
doc: "REAPR (Recognition of Errors in Assemblies using Paired Reads) is a tool that
  evaluates the accuracy of a genome assembly using mapped paired-end reads.\n\nTool
  homepage: https://github.com/tadelv/reaprime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reapr:v1.0.18dfsg-4-deb_cv1
stdout: reapr.out
