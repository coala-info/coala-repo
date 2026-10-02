cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - index
label: samtools_index
doc: Generate index for BAM/CRAM files
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM file(s) to index
    inputBinding:
      position: 1
  - id: output_index_positional
    type:
      - 'null'
      - string
    doc: Output index file name (single file mode)
    inputBinding:
      position: 2
  - id: bai
    type:
      - 'null'
      - boolean
    doc: Generate BAI-format index for BAM files [default]
    inputBinding:
      position: 103
      prefix: --bai
  - id: csi
    type:
      - 'null'
      - boolean
    doc: Generate CSI-format index for BAM files
    inputBinding:
      position: 103
      prefix: --csi
  - id: min_shift
    type:
      - 'null'
      - int
    doc: Set minimum interval size for CSI indices to 2^INT
    inputBinding:
      position: 103
      prefix: --min-shift
  - id: multiple_files
    type:
      - 'null'
      - boolean
    doc: Interpret all filename arguments as files to be indexed
    inputBinding:
      position: 103
      prefix: -M
  - id: output_file
    type:
      - 'null'
      - string
    doc: Write index to FILE [alternative to <out.index> in args]
    inputBinding:
      position: 103
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Sets the number of additional threads
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_output_index_positional
    type:
      - 'null'
      - File
    doc: Output index file name (single file mode)
    outputBinding:
      glob: $(inputs.output_index_positional)
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Write index to FILE [alternative to <out.index> in args]
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
