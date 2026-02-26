cwlVersion: v1.2
class: CommandLineTool
baseCommand: screed
label: screed_dump_fastq
doc: "Convert a screed database to a FASTA file\n\nTool homepage: http://github.com/dib-lab/screed/"
inputs:
  - id: dbfile
    type: string
    inputBinding:
      position: 1
  - id: outputfile
    type:
      - 'null'
      - File
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0
stdout: screed_dump_fastq.out
