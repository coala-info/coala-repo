cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sinto
  - tagtorg
label: sinto_tagtorg
doc: "Append a read tag to the read group ID of each read. Also appends the read tag
  to the SM field of the read group.\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam
    type: File
    doc: Input SAM/BAM file, '-' reads from stdin
    inputBinding:
      position: 101
      prefix: --bam
  - id: outputformat
    type:
      - 'null'
      - string
    doc: Output format. One of 't' (SAM), 'b' (BAM), or 'u' (uncompressed BAM) 
      ('t' default)
    inputBinding:
      position: 101
      prefix: --outputformat
  - id: tag
    type:
      - 'null'
      - string
    doc: Read tag to extract the value from that is appended to the read group. 
      Default is 'CB', the tag that is used in 10x sequencing to identify cells.
    inputBinding:
      position: 101
      prefix: --tag
  - id: tagfile
    type: File
    doc: List of expected tag values. Reads with tag values that are not in this
      list are not altered.
    inputBinding:
      position: 101
      prefix: --tagfile
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output SAM/BAM file, '-' outputs to stdout (default '-')
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
