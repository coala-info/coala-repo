cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_orf_blastp_parser.py
label: gs-tama_tama_orf_blastp_parser.py
doc: "This script parses information from the default output of blastp\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: blastp_file
    type: File
    doc: blastp file (required)
    inputBinding:
      position: 101
      prefix: -b
  - id: output_file_name
    type: string
    doc: Output file name (required)
    inputBinding:
      position: 101
      prefix: -o
  - id: db_id_format
    type:
      - 'null'
      - string
    doc: "Format of input DB ID (default is UniRef, use \"ensembl\" for Ensembl generated DB)"
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Parsed blastp results
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_orf_blastp_parser.py.out
