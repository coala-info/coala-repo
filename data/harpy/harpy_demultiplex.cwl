cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - demultiplex
label: harpy_demultiplex
doc: "Demultiplex haplotagged FASTQ files. Check that you are using the correct haplotagging
  method/technology, since the different barcoding approaches have very different
  demultiplexing strategies.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: The haplotagging technology/command to use (e.g., meier2021)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specific demultiplexing command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_demultiplex.out
