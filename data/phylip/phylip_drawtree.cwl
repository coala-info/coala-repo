cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - drawtree
label: phylip_drawtree
doc: "Plots an unrooted tree diagram. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: 0 screen type, P plotting device (Postscript, PCL, PICT, Windows bitmap, X bitmap, ...), B use branch lengths, L angle of labels, R rotation, I iteration, D avoid label overlap, S scale, C character height, F font, M margins, # page size.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: intree
    type: File
    doc: Tree in Newick format (staged as 'intree')
  - id: fontfile
    type:
      - 'null'
      - File
    doc: Font file (only for the Hershey-font plotting devices) (staged as 'fontfile')
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line
    default:
      - '0'
      - 'L'
      - 'M'
      - 'Y'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: plotfile
    type: File
    doc: Plot of the tree (PostScript by default)
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
stdout: phylip_drawtree.out
