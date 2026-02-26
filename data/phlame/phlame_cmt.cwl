cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phlame
  - cmt
label: phlame_cmt
doc: "This tool is part of the phlame suite and is used for processing count data.\n\
  \nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: counts_files
    type:
      type: array
      items: File
    doc: Path to file (newline-separated) listing counts files, in same order as
      sample names
    inputBinding:
      position: 101
      prefix: -i
  - id: reference_genome
    type: File
    doc: Path to reference genome (fasta format)
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_names
    type:
      type: array
      items: File
    doc: Path to file (newline-separated) listing sample names
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_cmt
    type: File
    doc: Path to output compressedCMT file
    outputBinding:
      glob: $(inputs.output_cmt)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
