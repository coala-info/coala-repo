cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - index
label: samtools_index
doc: "Generate an index for BAM/CRAM files\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM file(s) to be indexed
    inputBinding:
      position: 1
  - id: all_filenames
    type:
      - 'null'
      - boolean
    doc: Interpret all filename arguments as files to be indexed
    inputBinding:
      position: 102
      prefix: -M
  - id: bai
    type:
      - 'null'
      - boolean
    doc: Generate BAI-format index for BAM files [default]
    inputBinding:
      position: 102
      prefix: --bai
  - id: csi
    type:
      - 'null'
      - boolean
    doc: Generate CSI-format index for BAM files
    inputBinding:
      position: 102
      prefix: --csi
  - id: min_shift
    type:
      - 'null'
      - int
    doc: Set minimum interval size for CSI indices to 2^INT
    default: 14
    inputBinding:
      position: 102
      prefix: --min-shift
  - id: threads
    type:
      - 'null'
      - int
    doc: Sets the number of additional threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_index
    type:
      - 'null'
      - File
    doc: Optional output index file name
    outputBinding:
      glob: '*.out'
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write index to FILE [alternative to <out.index> in args]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
