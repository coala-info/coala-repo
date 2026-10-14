cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dolmove
label: phylip_dolmove
doc: "Interactive Dollo or polymorphism parsimony. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: P Dollo or polymorphism parsimony, A ancestral states, F factors, W weights, T threshold, U initial tree (arbitrary, user, specify). After Y the program shows the tree and takes editing commands (R rearrange, + - move, O outgroup, W write tree, Q quit); at quit it asks whether to write the tree (Y).\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Binary character states in PHYLIP format (staged as 'infile')
  - id: intree
    type: File
    doc: Starting tree in Newick format (read because the default menu answers choose U, user tree) (staged as 'intree')
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line
    default:
      - 'U'
      - 'Y'
      - 'Q'
      - 'Y'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: outtree
    type: File
    doc: Final tree in Newick format
    outputBinding:
      glob: outtree
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: infile
        entry: $(inputs.infile)
      - entryname: intree
        entry: $(inputs.intree)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dolmove.out
