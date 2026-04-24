cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_peek
label: vt_peek
doc: "Summarizes the variants in a VCF file\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    inputBinding:
      position: 102
      prefix: -f
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    inputBinding:
      position: 102
      prefix: -i
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    inputBinding:
      position: 102
      prefix: -I
  - id: output_latex_dir
    type:
      - 'null'
      - Directory
    doc: output latex directory
    inputBinding:
      position: 102
      prefix: -x
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference sequence fasta file
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_pdf
    type:
      - 'null'
      - File
    doc: output pdf file
    outputBinding:
      glob: $(inputs.output_pdf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
