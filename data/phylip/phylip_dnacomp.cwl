cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnacomp
label: phylip_dnacomp
doc: "DNA compatibility algorithm: finds the trees that have the largest number of sites compatible with them. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U search for best tree or use user trees, J randomize input order of sequences, O outgroup root, W weighted sites, M multiple data sets, I interleaved input, 1 print the data, 2 progress indications, 3 print tree, 4 print steps and compatibility at sites, 5 print sequences at all nodes of tree, 6 write trees to the tree file.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "DNA sequences in PHYLIP format (interleaved by default; answer I at the menu for sequential) (staged as 'infile')"
  - id: intree
    type:
      - 'null'
      - File
    doc: "User trees in Newick format (read when menu letter U selects user trees; staged as 'intree')"
  - id: weights
    type:
      - 'null'
      - File
    doc: "Weights of the sites (read when menu letter W is answered; staged as 'weights')"
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
    doc: "Trees, compatibility counts and optional site details"
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
      - entryname: intree
        entry: $(inputs.intree)
      - entryname: weights
        entry: $(inputs.weights)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnacomp.out
