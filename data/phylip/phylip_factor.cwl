cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - factor
label: phylip_factor
doc: "Multistate to binary recoding program: recodes multistate characters with character-state trees into binary characters. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: A put ancestral states in the output, F put factors information in the output, 0 terminal type, 1 progress indications.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Multistate characters with their character-state trees, in the Factor input format (staged as 'infile')"
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line. Y accepts the settings and runs the program.
    default:
      - 'Y'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: outfile
    type: File
    doc: "Binary character data in PHYLIP format"
    outputBinding:
      glob: outfile
  - id: factors
    type:
      - 'null'
      - File
    doc: "Factors information (written when menu letter F is answered)"
    outputBinding:
      glob: factors
  - id: ancestors
    type:
      - 'null'
      - File
    doc: "Ancestral states (written when menu letter A is answered)"
    outputBinding:
      glob: ancestors
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: infile
        entry: $(inputs.infile)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_factor.out
