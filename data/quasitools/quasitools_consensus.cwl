cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - consensus
label: quasitools_consensus
doc: "Generate consensus sequences from BAM files.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 2
  - id: id
    type:
      - 'null'
      - string
    doc: specify default FASTA sequence identifier to be used for sequences 
      without an RG tag.
    inputBinding:
      position: 103
      prefix: --id
  - id: percentage
    type:
      - 'null'
      - int
    doc: percentage to include base in mixture.
    inputBinding:
      position: 103
      prefix: --percentage
  - id: output_filename_path
    type: string
    doc: Output or path parameter `output_filename_path`
    inputBinding:
      position: 104
      prefix: --output-filename
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
