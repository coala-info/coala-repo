cwlVersion: v1.2
class: CommandLineTool
baseCommand: SAMstats
label: samstats_SAMstats
doc: "Compute SAM file mapping statistics for a SAM file sorted by read name\n\nTool
  homepage: https://github.com/kundajelab/SAMstats"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of lines to read a time from sortedSamFile
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: sorted_sam_file
    type: File
    doc: Input SAM file. Use '-' if input is being piped from stdin. File must 
      be sorted by read name.
    inputBinding:
      position: 101
      prefix: --sorted_sam_file
  - id: outf_path
    type: string
    doc: Output file name to store alignment statistics. The
    inputBinding:
      position: 102
      prefix: --outf
outputs:
  - id: outf
    type:
      - 'null'
      - File
    doc: Output file name to store alignment statistics. The statistics will be 
      printed to stdout if no file is provided
    outputBinding:
      glob: $(inputs.outf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samstats:0.2.2--py_0
