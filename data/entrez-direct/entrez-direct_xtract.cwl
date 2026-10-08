cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtract
label: entrez-direct_xtract
doc: "Converts XML data into a tab-delimited table. -pattern places the data from\n\
  individual records into separate rows, -element extracts values from specified\n\
  fields into separate columns.\n\
  \nThe order of the exploration arguments matters (-pattern, then -group, -block,\n\
  -subset, then -element and the other constraints), so pass them in order in\n\
  the expression input.\n\
  \nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Remove HTML and MathML tags
    inputBinding:
      position: 1
      prefix: -strict
  - id: mixed
    type:
      - 'null'
      - boolean
    doc: Allow mixed content XML
    inputBinding:
      position: 1
      prefix: -mixed
  - id: self
    type:
      - 'null'
      - boolean
    doc: Allow detection of empty self-closing tags
    inputBinding:
      position: 1
      prefix: -self
  - id: accent
    type:
      - 'null'
      - boolean
    doc: Excise Unicode accents and diacritical marks
    inputBinding:
      position: 1
      prefix: -accent
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Unicode to numeric HTML character entities
    inputBinding:
      position: 1
      prefix: -ascii
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress runs of spaces
    inputBinding:
      position: 1
      prefix: -compress
  - id: stops
    type:
      - 'null'
      - boolean
    doc: Retain stop words in selected phrases
    inputBinding:
      position: 1
      prefix: -stops
  - id: xml_input
    type: File
    doc: XML file, sent to xtract on standard input (xtract -input fails when
      standard input is also open)
  - id: transform
    type:
      - 'null'
      - File
    doc: File of substitutions for -translate
    inputBinding:
      position: 3
      prefix: -transform
  - id: aliases
    type:
      - 'null'
      - File
    doc: Mappings file for -classify operation
    inputBinding:
      position: 3
      prefix: -aliases
  - id: pattern
    type:
      - 'null'
      - string
    doc: Name of record within set
    inputBinding:
      position: 4
      prefix: -pattern
  - id: expression
    type:
      - 'null'
      - type: array
        items: string
    doc: "Remaining arguments in the order xtract needs them, for example -block,\n\
      Author, -element, LastName. Covers -group, -block, -subset, -path, -if,\n\
      -unless, -and, -or, -else, -position, the string and numeric constraints,\n\
      -element, -first, -last, -num, -sum, -min, -max, -avg, -sep, -tab, -ret,\n\
      -pfx, -sfx, -def, -lbl, -insd, -hgvs, -molwt, -fasta, -set, -rec, -wrp,\n\
      -enc, -tag, -att, -atr, -cls, -slf, -end and the other element and format\n\
      commands."
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdin: $(inputs.xml_input.path)
stdout: entrez-direct_xtract.out
