cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - validate
label: harpy_validate
doc: "File format checks for linked-read data. This is useful to make sure your input
  files are formatted correctly for the processing pipeline before you are surprised
  by errors hours into an analysis.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: The validation subcommand to run (bam or fastq)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_validate.out
