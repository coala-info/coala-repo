cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-validateannotation
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
      - type: array
        items: File
        inputBinding:
          prefix: --gtfFile
    doc: Gtf files to check (option can be given more than once)
    inputBinding:
      position: 101
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
    secondaryFiles:
      - .fai
      - pattern: ^.dict
        required: false
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
  - id: log
    type: stderr
    doc: Validation log (the tool writes its result messages to stderr)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-validateannotation:0.1--0
stderr: biopet-validateannotation.log
