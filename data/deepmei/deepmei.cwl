cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - index
label: deepmei
doc: "Generate index for BAM files\n\nTool homepage: https://github.com/Kanglu123/deepmei"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: BAM files to be indexed
    inputBinding:
      position: 1
  - id: output_index
    type:
      - 'null'
      - File
    doc: Output index file name
    inputBinding:
      position: 2
  - id: generate_bai
    type:
      - 'null'
      - boolean
    doc: Generate BAI-format index for BAM files [default]
    inputBinding:
      position: 103
      prefix: --bai
  - id: generate_csi
    type:
      - 'null'
      - boolean
    doc: Generate CSI-format index for BAM files
    inputBinding:
      position: 103
      prefix: --csi
  - id: interpret_filenames_as_files
    type:
      - 'null'
      - boolean
    doc: Interpret all filename arguments as files to be indexed
    inputBinding:
      position: 103
      prefix: -M
  - id: min_shift
    type:
      - 'null'
      - int
    doc: Set minimum interval size for CSI indices to 2^INT
    default: 14
    inputBinding:
      position: 103
      prefix: --min-shift
  - id: reference_fasta
    type: File
    doc: reference.fa is required
    inputBinding:
      position: 103
  - id: threads
    type:
      - 'null'
      - int
    doc: Sets the number of threads
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write index to FILE [alternative to <out.index> in args]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmei:1.6.24--hdfd78af_1
