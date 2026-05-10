cwlVersion: v1.2
class: CommandLineTool
baseCommand: bellerophon
label: bellerophon
doc: "Filter chimeric reads.\n\nTool homepage: https://github.com/davebx/bellerophon/"
inputs:
  - id: forward
    type: File
    doc: SAM/BAM/CRAM file with the first set of reads.
    inputBinding:
      position: 101
      prefix: --forward
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level.
    inputBinding:
      position: 101
      prefix: --log-level
  - id: quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality.
    inputBinding:
      position: 101
      prefix: --quality
  - id: reverse
    type: File
    doc: SAM/BAM/CRAM file with the second set of reads.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output BAM file for filtered and paired reads.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellerophon:1.0--pyh5e36f6f_0
