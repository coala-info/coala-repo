cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - drawgram
label: phylip_drawgram
doc: "Plots rooted phylogenies (cladograms, phenograms, curvograms, eurograms) from a tree file. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: 0 screen type, P final plotting device (Postscript, PCL, PICT, Windows bitmap, ...), H tree grows horizontally or vertically, S tree style, B use branch lengths, L angle of labels, R scale of branch length, D depth/breadth of tree, T stem-length/tree-depth, C character height, A ancestral nodes, F font, M margins, # pages per tree.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: intree
    type: File
    doc: "Rooted tree in Newick format (staged as 'intree')"
  - id: fontfile
    type:
      - 'null'
      - File
    doc: "Font file (only for the Hershey-font plotting devices; staged as 'fontfile')"
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line. Y accepts the settings and runs the program.
    default:
      - '0'
      - 'Y'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: plotfile
    type: File
    doc: "Plot of the tree (PostScript by default)"
    outputBinding:
      glob: plotfile
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: intree
        entry: $(inputs.intree)
      - entryname: fontfile
        entry: $(inputs.fontfile)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_drawgram.out
