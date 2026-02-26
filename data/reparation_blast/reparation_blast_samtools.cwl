cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: reparation_blast_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
inputs:
  - id: command
    type: string
    doc: The samtools command to execute
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the samtools command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
stdout: reparation_blast_samtools.out
