cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamslice
label: bamslice
doc: "Extract byte ranges from BAM files and convert to interleaved FASTQ format for
  parallel processing\n\nTool homepage: https://github.com/nebiolabs/bamslice"
inputs:
  - id: end_offset
    type: int
    doc: Ending byte offset (will process until reaching a block at or after 
      this offset)
    inputBinding:
      position: 101
      prefix: --end-offset
  - id: input
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level (off, error, warn, info, debug, trace)
    inputBinding:
      position: 101
      prefix: --log-level
  - id: start_offset
    type: int
    doc: Starting byte offset (will find next BGZF block at or after this 
      offset)
    inputBinding:
      position: 101
      prefix: --start-offset
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
    doc: 'Output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamslice:0.1.7--h67a98e6_0
