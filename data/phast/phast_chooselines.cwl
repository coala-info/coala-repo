cwlVersion: v1.2
class: CommandLineTool
baseCommand: chooseLines
label: phast_chooselines
doc: "Randomly choose k lines from a file of n lines, for 0 < k < n.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: k
    type:
      - 'null'
      - int
    doc: Number of lines to choose (default is all lines).
    inputBinding:
      position: 1
      prefix: -k
  - id: infile
    type: File
    doc: Input file to choose lines from.
    inputBinding:
      position: 2
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the output file (chosen lines, written to standard output).
    default: chosen_lines.txt
outputs:
  - id: chosen_lines
    type: File
    doc: The chosen lines.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
