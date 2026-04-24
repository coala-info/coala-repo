cwlVersion: v1.2
class: CommandLineTool
baseCommand: revtag
label: revtag
doc: "Reverse (and complement) array-like SAM tags for negative facing alignments.\n\
  \nTool homepage: https://github.com/clintval/revtag"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input SAM/BAM/CRAM file or stream
    inputBinding:
      position: 101
      prefix: --input
  - id: rev
    type:
      - 'null'
      - type: array
        items: string
    doc: SAM tags with array values to reverse
    inputBinding:
      position: 101
      prefix: --rev
  - id: revcomp
    type:
      - 'null'
      - type: array
        items: string
    doc: SAM tags with array values to reverse complement
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: threads
    type:
      - 'null'
      - int
    doc: Extra threads for BAM/CRAM compression/decompression
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output SAM/BAM/CRAM file or stream
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revtag:1.0.0--h3ab6199_0
