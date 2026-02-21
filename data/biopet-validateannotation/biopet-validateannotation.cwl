cwlVersion: v1.2
class: CommandLineTool
baseCommand: ValidateAnnotation
label: biopet-validateannotation
doc: "A tool to validate annotation files such as Refflat, GTF, and check them against
  a reference fasta.\n\nTool homepage: https://github.com/biopet/validateannotation"
inputs:
  - id: disable_fail
    type:
      - 'null'
      - boolean
    doc: Do not fail on error. The tool will still exit when encountering an error,
      but will do so with exit code 0
    inputBinding:
      position: 101
      prefix: --disableFail
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: Gtf files to check
    inputBinding:
      position: 101
      prefix: --gtfFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: reference
    type: File
    doc: Reference fasta to check vcf file against
    inputBinding:
      position: 101
      prefix: --reference
  - id: refflat_file
    type:
      - 'null'
      - File
    doc: Refflat file to check
    inputBinding:
      position: 101
      prefix: --refflatFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-validateannotation:0.1--0
stdout: biopet-validateannotation.out
