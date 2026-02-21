cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-query
label: genomedata_genomedata-query
doc: "A tool for querying genomedata archives. (Note: The provided help text contained
  system error messages rather than usage information; no arguments could be extracted.)\n
  \nTool homepage: http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-query.out
