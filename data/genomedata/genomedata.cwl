cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata
label: genomedata
doc: "Genomedata is a tool for efficient storage and access of large-scale functional
  genomics data (Note: The provided text is a container runtime error log and does
  not contain usage information).\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata.out
