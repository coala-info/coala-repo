cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitopoint.pl
label: mitosalt
doc: "MitoSAlt is a tool for analyzing mitochondrial DNA sequences.\n\nTool homepage:
  https://sourceforge.net/projects/mitosalt/"
inputs:
  - id: config_file
    type: File
    doc: Configuration file
    inputBinding:
      position: 1
  - id: fastq_file_1
    type: File
    doc: FASTQ file 1
    inputBinding:
      position: 2
  - id: fastq_file_2
    type: File
    doc: FASTQ file 2
    inputBinding:
      position: 3
  - id: study_name
    type: string
    doc: Study name
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_3
stdout: mitosalt.out
