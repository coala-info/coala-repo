cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-info
label: genomedata_genomedata-info
doc: "Print information about a genomedata archive.\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: command
    type: string
    doc: available commands
    inputBinding:
      position: 1
  - id: gdarchive
    type: File
    doc: genomedata archive
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-info.out
