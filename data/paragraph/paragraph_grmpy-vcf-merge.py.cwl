cwlVersion: v1.2
class: CommandLineTool
baseCommand: grmpy-vcf-merge.py
label: paragraph_grmpy-vcf-merge.py
doc: 'Merge the JSON genotyping output of multigrmpy.py / grmpy back into the input VCF of variants.\n\nTool homepage: https://github.com/Illumina/paragraph'
inputs:
  - id: input
    type: File
    doc: 'Input VCF file of variants.'
    inputBinding:
      position: 101
      prefix: --input
  - id: grmpy
    type: File
    doc: 'JSON output from multigrmpy.py / grmpy'
    inputBinding:
      position: 101
      prefix: --grmpy
  - id: output_path
    type: string
    doc: 'Output file name.'
    inputBinding:
      position: 101
      prefix: --output
  - id: logfile_path
    type:
      - 'null'
      - string
    doc: 'Write logging information into file rather than to stderr'
    inputBinding:
      position: 101
      prefix: --logfile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Raise logging level from warning to info.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Set logging level to output errors only.'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Log debug level events.'
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: output
    type: File
    doc: 'Output file name.'
    outputBinding:
      glob: $(inputs.output_path)
  - id: logfile
    type:
      - 'null'
      - File
    doc: 'Log file'
    outputBinding:
      glob: $(inputs.logfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
