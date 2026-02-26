cwlVersion: v1.2
class: CommandLineTool
baseCommand: jgoslin-cli
label: jgoslin
doc: "Parses lipid names using various grammars.\n\nTool homepage: https://github.com/lifs-tools/jgoslin"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: Input a file name to read from for lipid name for parsing. Each lipid 
      name must be on a separate line.
    inputBinding:
      position: 101
      prefix: --file
  - id: grammar
    type:
      - 'null'
      - string
    doc: 'Use the provided grammar explicitly instead of all grammars. Options are:
      [GOSLIN, GOSLINFRAGMENTS, LIPIDMAPS, SWISSLIPIDS, HMDB, SHORTHAND2020, FATTYACIDS,
      NONE]'
    inputBinding:
      position: 101
      prefix: --grammar
  - id: name
    type:
      - 'null'
      - string
    doc: Input a lipid name for parsing.
    inputBinding:
      position: 101
      prefix: --name
  - id: strip_whitespace
    type:
      - 'null'
      - boolean
    doc: Strip leading and trailing whitespace of names passed to goslin. Be 
      aware that original names in output will contain the stripped names!
    inputBinding:
      position: 101
      prefix: --stripWhitespace
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to file 'goslin-out.tsv' instead of to std out.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jgoslin:2.2.0--hdfd78af_0
