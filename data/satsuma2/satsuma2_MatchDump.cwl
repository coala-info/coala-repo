cwlVersion: v1.2
class: CommandLineTool
baseCommand: [MatchDump]
label: satsuma2_MatchDump
doc: "Prints a binary KMatch output file as text (columns: query id, target id, query size, query start, target start, length, reverse, probability, identity).\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: kmatch_output_file
    type: File
    doc: "KMatch output file (binary)"
    inputBinding:
      position: 1
outputs:
  - id: matches_text
    type: stdout
    doc: "Text dump of the matches, written to standard output"
stdout: $(inputs.kmatch_output_file.nameroot).dump.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
