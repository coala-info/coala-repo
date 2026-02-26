cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq
label: pyfastaq_fastaq
doc: "A command-line tool for manipulating FASTA and FASTQ files.\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: command
    type: string
    doc: The command to execute.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
stdout: pyfastaq_fastaq.out
