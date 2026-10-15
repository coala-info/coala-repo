cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnaml
label: phylip_dnaml
doc: "Nucleic acid sequence maximum likelihood method. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U search for best tree or use user trees, T transition/transversion ratio, F empirical base frequencies, C categories of site rates (then type the number of categories and their rates), R rate variation among sites (constant, gamma, gamma plus invariant sites), W weighted sites, S speedier but rougher analysis, G global rearrangements, J randomize input order of sequences, O outgroup root, M multiple data sets, I interleaved input, 1 print the data, 2 progress indications, 3 print tree, 4 write trees to the tree file, 5 reconstruct hypothetical sequences.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
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
  - id: categories
    type:
      - 'null'
      - File
    doc: "Rate category of each site, one digit per site (read when menu letter C is answered; staged as 'categories')"
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
    doc: "Tree drawing, log likelihood and branch lengths"
    outputBinding:
      glob: outfile
  - id: outtree
    type:
      - 'null'
      - File
    doc: "Tree in Newick format"
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
      - entryname: categories
        entry: $(inputs.categories)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnaml.out
