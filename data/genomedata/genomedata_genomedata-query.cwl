cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-query
label: genomedata_genomedata-query
doc: "print data from genomedata archive in specified trackname and coordinates\n\n\
  Tool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: gdarchive
    type: string
    doc: genomedata archive
    inputBinding:
      position: 1
  - id: trackname
    type: string
    doc: track name
    inputBinding:
      position: 2
  - id: chrom
    type: string
    doc: chromosome name
    inputBinding:
      position: 3
  - id: begin
    type: int
    doc: chromosome start
    inputBinding:
      position: 4
  - id: end
    type: int
    doc: chromosome end
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-query.out
