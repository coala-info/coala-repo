cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-report
label: genomedata_genomedata-report
doc: "Print a report (mean and variance per track) of a Genomedata archive.\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: gdarchive
    type:
      - File
      - Directory
    doc: genomedata archive
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-report.out
