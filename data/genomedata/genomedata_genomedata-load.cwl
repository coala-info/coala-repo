cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-load
label: genomedata_genomedata-load
doc: "The provided text does not contain help information or usage instructions for
  genomedata-load. It contains system error logs related to a container runtime failure
  (no space left on device).\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-load.out
