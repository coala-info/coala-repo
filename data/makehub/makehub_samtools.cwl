cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: makehub_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: command
    type: string
    doc: Samtools command to execute
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
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
stdout: makehub_samtools.out
