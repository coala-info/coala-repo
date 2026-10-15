cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clique
label: phylip_clique
doc: "Largest clique program: finds the largest sets of mutually compatible binary characters and the trees they imply. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: A ancestral states in input file, F factors information, W weighted sites, C minimum clique size, O outgroup root, M multiple data sets, 1 print the data, 2 progress indications, 3 print compatibility matrix, 4 print tree, 5 write trees to the tree file.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Binary character states in PHYLIP format (staged as 'infile')"
  - id: ancestors
    type:
      - 'null'
      - File
    doc: "Ancestral states for each character (read when menu letter A is answered; staged as 'ancestors')"
  - id: factors
    type:
      - 'null'
      - File
    doc: "Factors information that groups characters (read when menu letter F is answered; staged as 'factors')"
  - id: weights
    type:
      - 'null'
      - File
    doc: "Weights of the characters, 0 or 1 (read when menu letter W is answered; staged as 'weights')"
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
    doc: "Cliques, compatibility information and trees"
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
      - entryname: ancestors
        entry: $(inputs.ancestors)
      - entryname: factors
        entry: $(inputs.factors)
      - entryname: weights
        entry: $(inputs.weights)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_clique.out
