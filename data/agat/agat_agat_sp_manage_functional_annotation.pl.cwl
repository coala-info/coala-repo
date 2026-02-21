cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_manage_functional_annotation.pl
label: agat_agat_sp_manage_functional_annotation.pl
doc: "This tool allows managing functional annotations within a GFF file, such as
  adding information from BLAST or InterProScan results or cleaning existing annotations.\n
  \nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: blast
    type:
      - 'null'
      - File
    doc: Input blast file (tabulated format 6).
    inputBinding:
      position: 101
      prefix: --blast
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Remove all functional annotation already present in the GFF file.
    inputBinding:
      position: 101
      prefix: --clean
  - id: gff
    type: File
    doc: Input GFF3 file that will be read.
    inputBinding:
      position: 101
      prefix: --gff
  - id: interpro
    type:
      - 'null'
      - File
    doc: Input interproscan file (TSV or XML).
    inputBinding:
      position: 101
      prefix: --interpro
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output GFF3 file where the results will be written.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
