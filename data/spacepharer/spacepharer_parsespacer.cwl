cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacepharer
  - parsespacer
label: spacepharer_parsespacer
doc: "Parse spacer files (PILER-CR, CRISPRDetect and CRT/MinCED) and create sequence database\n\nTool homepage: https://github.com/soedinglab/spacepharer"
inputs:
  - id: spacer_files
    type:
      type: array
      items: File
    doc: "Spacer files (PILER-CR, CRISPRDetect or CRT/MinCED output)"
    inputBinding:
      position: 1
  - id: spacer_db
    type: string
    doc: "Output spacer database name (prefix of the database files)"
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU-cores used (all by default) [20]"
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: "Write compressed output [0]"
    inputBinding:
      position: 104
      prefix: --compressed
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]"
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_db
    type:
      type: array
      items: File
    doc: Files of the output spacer database
    outputBinding:
      glob: $(inputs.spacer_db)*
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in $(inputs.spacer_db)*; do if [ -L "$f" ]; then cp -L "$f" "$f.tmp" && mv "$f.tmp" "$f"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacepharer:5.c2e680a--hd6d6fdc_7
