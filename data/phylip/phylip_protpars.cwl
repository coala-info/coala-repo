cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - protpars
label: phylip_protpars
doc: "Protein parsimony: finds trees of minimum number of amino acid changes using a genetic code. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U user trees (the program then also asks for an odd random number seed after Y), J randomize input order (asks for an odd seed), O outgroup, T threshold, C genetic code, W weights, M multiple data sets, I interleaved input.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
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
    doc: "Most parsimonious trees and step counts"
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
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_protpars.out
