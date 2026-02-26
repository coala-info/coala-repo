cwlVersion: v1.2
class: CommandLineTool
baseCommand: screed
label: screed_dump_fasta
doc: "Convert a screed database to a FASTA file\n\nTool homepage: http://github.com/dib-lab/screed/"
inputs:
  - id: dbfile
    type: File
    inputBinding:
      position: 1
outputs:
  - id: outputfile
    type:
      - 'null'
      - File
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0
