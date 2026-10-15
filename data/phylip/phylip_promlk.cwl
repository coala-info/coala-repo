cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - promlk
label: phylip_promlk
doc: "Maximum likelihood estimation of phylogenies from protein sequences assuming a molecular clock. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U user trees, P JTT, PMB or PAM model, C site categories (asks for the number of categories and their rates), R rate variation (gamma or hidden Markov model; asks for the coefficient of variation after Y), A correlated rates (asks for the mean block length), W weights, G global rearrangements, J randomize input order (asks for an odd seed), O outgroup, M multiple data sets, I interleaved input, 5 reconstruct hypothetical sequences.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Protein sequences in PHYLIP format (staged as 'infile')"
  - id: intree
    type:
      - 'null'
      - File
    doc: "User tree(s) in Newick format (read when the menu option for user trees is chosen) (staged as 'intree')"
  - id: weights
    type:
      - 'null'
      - File
    doc: "Character or site weights, one digit per site (read when the menu option W is chosen) (staged as 'weights')"
  - id: categories
    type:
      - 'null'
      - File
    doc: "Site rate categories, one digit 1-9 per site (read when the menu option C is chosen) (staged as 'categories')"
  - id: menu_answers
    type:
      type: array
      items: string
    doc: "Answers typed at the program menu and at later prompts, one per line"
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
    type: File
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
      - entryname: categories
        entry: $(inputs.categories)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_promlk.out
