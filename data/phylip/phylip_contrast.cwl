cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - contrast
label: phylip_contrast
doc: "Continuous character comparative analysis: computes independent contrasts, covariances, regressions and correlations of continuous characters along a given tree. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: W within-population variation in data, R print correlations and regressions, C print contrasts, M analyze multiple trees, 1 print the data, 2 progress indications.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Continuous character values in PHYLIP format (staged as 'infile')"
  - id: intree
    type: File
    doc: "Tree with branch lengths in Newick format (staged as 'intree')"
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
    doc: "Contrasts, covariance matrix, regressions and correlations"
    outputBinding:
      glob: outfile
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: infile
        entry: $(inputs.infile)
      - entryname: intree
        entry: $(inputs.intree)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_contrast.out
