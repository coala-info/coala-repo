cwlVersion: v1.2
class: CommandLineTool
baseCommand: telometer
label: telometer
doc: "Calculate telomere length from a BAM file.\n\nTool homepage: https://github.com/santiago-es/Telometer"
inputs:
  - id: bam_file
    type: File
    doc: The path to the sorted BAM file.
    inputBinding:
      position: 101
      prefix: --bam
  - id: max_gap_len
    type:
      - 'null'
      - int
    doc: Maximum allowed gap length between telomere regions.
    inputBinding:
      position: 101
      prefix: --maxgaplen
  - id: mem_limit
    type:
      - 'null'
      - string
    doc: "Maximum amount of memory to commit per batch of reads\nwhile processing.
      Optional, default = 8 Gb"
    inputBinding:
      position: 101
      prefix: --memlimit
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: "Minimum read length to consider (Default: 1000 for\ntelomere capture, use
      4000 for WGS)."
    inputBinding:
      position: 101
      prefix: --minreadlen
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processing threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: The path to the output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telometer:1.1--pyhdfd78af_0
