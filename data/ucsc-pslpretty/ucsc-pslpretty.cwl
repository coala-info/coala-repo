cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPretty
label: ucsc-pslpretty
doc: "Convert PSL to human-readable output. It is recommended that the psl file be sorted by target if it contains multiple targets; otherwise this will be extremely slow.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file."
    inputBinding:
      position: 1
  - id: target_lst
    type: File
    doc: "Target sequences: FASTA, 2bit or nib file, or a list of these files, one per line."
    inputBinding:
      position: 2
  - id: query_lst
    type: File
    doc: "Query sequences: FASTA, 2bit or nib file, or a list of these files, one per line."
    inputBinding:
      position: 3
  - id: pretty_out
    type: string
    doc: "Output file name."
    inputBinding:
      position: 4
  - id: axt
    type:
      - 'null'
      - boolean
    doc: "Save in format like Scott Schwartz's axt format. Gaps in both sequences are still allowed in the output."
    inputBinding:
      position: 0
      prefix: "-axt"
  - id: dot
    type:
      - 'null'
      - int
    doc: "Output a dot every N records."
    inputBinding:
      position: 0
      prefix: "-dot="
      separate: false
  - id: long
    type:
      - 'null'
      - boolean
    doc: "Don't abbreviate long inserts."
    inputBinding:
      position: 0
      prefix: "-long"
  - id: check
    type:
      - 'null'
      - string
    doc: "Output alignment checks to this file."
    inputBinding:
      position: 0
      prefix: "-check="
      separate: false
outputs:
  - id: pretty_file
    type: File
    doc: "Human-readable alignments."
    outputBinding:
      glob: $(inputs.pretty_out)
  - id: check_file
    type:
      - 'null'
      - File
    doc: "Alignment checks."
    outputBinding:
      glob: $(inputs.check)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpretty:482--h0b57e2e_0
stderr: ucsc-pslpretty.err
