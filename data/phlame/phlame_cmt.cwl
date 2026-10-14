cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phlame
  - cmt
label: phlame_cmt
doc: "Build a candidate mutation table (compressed CMT) from several counts files.\n\
  \nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: counts_files
    type: File
    doc: Path to file (newline-separated) listing counts files, in same order as
      sample names (required).
    inputBinding:
      position: 101
      prefix: -i
  - id: counts_data
    type:
      type: array
      items: File
    doc: The counts files named in the list file, staged in the working
      directory so the names in the list resolve.
  - id: sample_names
    type: File
    doc: Path to file (newline-separated) listing sample names (required).
    inputBinding:
      position: 101
      prefix: -s
  - id: reference_genome
    type: File
    doc: Path to reference genome (required, fasta format).
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: -r
  - id: output_cmt_path
    type: string
    doc: Path to output compressedCMT file (required).
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_cmt
    type: File
    doc: Path to output compressedCMT file (required).
    outputBinding:
      glob: $(inputs.output_cmt_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.counts_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
