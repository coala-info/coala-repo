cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - bam
  - convert
label: gia_bam_convert
doc: "Convert BAM to different formats\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: "Input BAM file to process"
    inputBinding:
      position: 101
      prefix: --input
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: "Include CIGAR string in BED output"
    inputBinding:
      position: 101
      prefix: --cigar
  - id: conv
    type:
      - 'null'
      - string
    doc: "Output conversion format (bed, fastq)"
    inputBinding:
      position: 101
      prefix: --conv
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use when reading BAM file"
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: "Output file name (stdout is captured into this file)"
outputs:
  - id: output
    type: File
    doc: Converted output
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
stdout: $(inputs.output_path)
