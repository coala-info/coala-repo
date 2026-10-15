cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consense
label: phylip_consense
doc: "Consensus tree program: reads a file of trees and computes their majority-rule (extended), strict or Ml consensus tree. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: C consensus type (MRe, strict, MR, Ml), O outgroup root, R trees treated as rooted, 1 print sets of species, 2 progress indications, 3 print tree, 4 write consensus tree to the tree file.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: intree
    type: File
    doc: "File of trees in Newick format, one per line (staged as 'intree')"
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
    doc: "Sets of species and consensus tree drawing"
    outputBinding:
      glob: outfile
  - id: outtree
    type:
      - 'null'
      - File
    doc: "Consensus tree in Newick format"
    outputBinding:
      glob: outtree
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: intree
        entry: $(inputs.intree)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_consense.out
