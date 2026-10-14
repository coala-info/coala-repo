cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - retree
label: phylip_retree
doc: "Tree rearrangement. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U initial tree (arbitrary, user, specify), N output format (PHYLIP, Nexus, XML). After Y the program shows the tree and takes commands (R, U, O, F, D, B, N, W, Q); at quit it asks whether to write the tree (Y), then whether the tree is rooted (R) or unrooted (U).\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: intree
    type: File
    doc: Tree in Newick format (staged as 'intree')
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line
    default:
      - 'Y'
      - 'Q'
      - 'Y'
      - 'U'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: outtree
    type: File
    doc: Rearranged tree in Newick format
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
stdout: phylip_retree.out
