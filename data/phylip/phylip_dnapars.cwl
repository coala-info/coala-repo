cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnapars
label: phylip_dnapars
doc: "DNA parsimony program. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U user trees, S search option, J randomize input order, O outgroup, T threshold, N use weights, W sites weighted, M multiple data sets, I interleaved input.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: DNA sequences in PHYLIP format (staged as 'infile')
  - id: intree
    type:
      - 'null'
      - File
    doc: User trees in Newick format (needed when the menu option U is chosen) (staged as 'intree')
  - id: weightfile
    type:
      - 'null'
      - File
    doc: Site weights (needed when the menu option W is chosen) (staged as 'weightfile')
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
    doc: Most parsimonious trees and their step counts
    outputBinding:
      glob: outfile
  - id: outtree
    type: File
    doc: Trees in Newick format
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
      - entryname: weightfile
        entry: $(inputs.weightfile)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnapars.out
