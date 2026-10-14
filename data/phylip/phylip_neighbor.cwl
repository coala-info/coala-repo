cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - neighbor
label: phylip_neighbor
doc: "Neighbor-Joining and UPGMA methods. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: N neighbor-joining or UPGMA, O outgroup root, L lower-triangular matrix, R upper-triangular matrix, S subreplicates, J randomize input order, M multiple data sets.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Distance matrix in PHYLIP format (staged as 'infile')
  - id: menu_answers
    type:
      type: array
      items: string
    doc: Answers typed at the program menu, one per line
    default:
      - 'Y'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: '< menu_answers.txt'
outputs:
  - id: outfile
    type: File
    doc: Tree drawing and branch lengths
    outputBinding:
      glob: outfile
  - id: outtree
    type: File
    doc: Tree in Newick format
    outputBinding:
      glob: outtree
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
stdout: phylip_neighbor.out
