cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-histogram
label: genomedata_genomedata-histogram
doc: "The provided text contains system error messages regarding a container runtime
  failure (no space left on device) and does not contain the help documentation or
  usage instructions for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-histogram.out
