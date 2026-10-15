cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnamove
label: phylip_dnamove
doc: "Interactive DNA parsimony. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: O outgroup root, W weighted sites, T threshold parsimony, I interleaved input, U initial tree (arbitrary, user, specify). After Y the program shows the tree and takes editing commands (R rearrange, + - S show sites, T try rearrangements, U undo, O outgroup, F flip, W write tree, Q quit); at quit it asks whether to write the tree (Y), and because the program has already created the empty tree file, it then asks whether to replace it (R).\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "DNA sequences in PHYLIP format (interleaved by default; answer I at the menu for sequential) (staged as 'infile')"
  - id: intree
    type:
      - 'null'
      - File
    doc: "Starting tree in Newick format (read when menu letter U selects a user tree; staged as 'intree')"
  - id: weights
    type:
      - 'null'
      - File
    doc: "Weights of the sites, 0 or 1 (read when menu letter W is answered; staged as 'weights')"
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line. Y accepts the settings and runs the program.
    default:
      - 'Y'
      - 'Q'
      - 'Y'
      - 'R'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: outtree
    type: File
    doc: "Final tree in Newick format"
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
      - entryname: weights
        entry: $(inputs.weights)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnamove.out
