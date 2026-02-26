cwlVersion: v1.2
class: CommandLineTool
baseCommand: circlator_get_dnaa
label: circlator_get_dnaa
doc: "Downloads and filters a file of dnaA (or other) genes from uniprot\n\nTool homepage:
  https://github.com/sanger-pathogens/circlator"
inputs:
  - id: output_prefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 1
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length in amino acids
    default: 500
    inputBinding:
      position: 102
      prefix: --max_length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length in amino acids
    default: 333
    inputBinding:
      position: 102
      prefix: --min_length
  - id: name_re
    type:
      - 'null'
      - string
    doc: Each sequence name must match this regular expression
    default: Chromosomal replication initiat(or|ion) protein.*dnaa
    inputBinding:
      position: 102
      prefix: --name_re
  - id: name_re_case_sensitive
    type:
      - 'null'
      - boolean
    doc: Do a case-sensitive match to regular expression given by --name_re. 
      Default is to ignore case.
    inputBinding:
      position: 102
      prefix: --name_re_case_sensitive
  - id: uniprot_search
    type:
      - 'null'
      - string
    doc: Uniprot search term
    default: dnaa
    inputBinding:
      position: 102
      prefix: --uniprot_search
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_get_dnaa.out
