cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - FastqSplitter
label: biopet_tool_FastqSplitter
doc: "Split a FASTQ file into several output files.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input_file
    type: File
    doc: Path to input file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output
    type:
      type: array
      items: string
      inputBinding:
        prefix: --output
    doc: Path to output file (give several to split into chunks)
    inputBinding:
      position: 101
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_fastq
    type:
      type: array
      items: File
    doc: Output FASTQ chunks
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
