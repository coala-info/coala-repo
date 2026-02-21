cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtm
label: fis-gtm
doc: "FIS-GT.M is a high-performance, hierarchical database engine and application
  development platform.\n\nTool homepage: https://github.com/luisibanez/fis-gtm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fis-gtm:v6.3-007-1-deb_cv1
stdout: fis-gtm.out
