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
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
