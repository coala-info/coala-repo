cwlVersion: v1.2
class: CommandLineTool
baseCommand: selscan
label: selscan
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/szpiech/selscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selscan:1.2.0a--hb66fcc3_7
stdout: selscan.out
