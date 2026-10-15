cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dolpenny
label: phylip_dolpenny
doc: "Penny algorithm for Dollo or polymorphism parsimony: branch-and-bound search for all most parsimonious trees. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: P Dollo or polymorphism parsimony, H how many groups of 100 trees, F how often to report, S simple branch and bound, T threshold parsimony, A ancestral states, W weighted sites, M multiple data sets, 1 print the data, 2 progress indications, 3 print tree, 4 print steps in each character, 5 print states at all nodes of tree, 6 write trees to the tree file.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Binary character states in PHYLIP format (staged as 'infile')"
  - id: weights
    type:
      - 'null'
      - File
    doc: "Weights of the characters (read when menu letter W is answered; staged as 'weights')"
  - id: ancestors
    type:
      - 'null'
      - File
    doc: "Ancestral states for each character (read when menu letter A is answered; staged as 'ancestors')"
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
    doc: "Most parsimonious trees and optional character details"
    outputBinding:
      glob: outfile
  - id: outtree
    type:
      - 'null'
      - File
    doc: "Trees in Newick format"
    outputBinding:
      glob: outtree
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: infile
        entry: $(inputs.infile)
      - entryname: weights
        entry: $(inputs.weights)
      - entryname: ancestors
        entry: $(inputs.ancestors)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dolpenny.out
