cwlVersion: v1.2
class: CommandLineTool
baseCommand: screed
label: screed_command
doc: "Available commands: db, dump_fasta, dump_fastq\n\nTool homepage: http://github.com/dib-lab/screed/"
inputs:
  - id: command
    type: string
    doc: The command to run (db, dump_fasta, dump_fastq)
    inputBinding:
      position: 1
  - id: db
    type: File
    doc: Screed database to dump from
    inputBinding:
      position: 2
  - id: db_filename
    type: File
    doc: Filename for creating a screed database
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Output file for dumped data
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0
