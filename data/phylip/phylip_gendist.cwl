cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gendist
label: phylip_gendist
doc: "Computes genetic distances from gene frequencies (Nei, Cavalli-Sforza chord or Reynolds-Weir-Cockerham). The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: A all alleles present at each locus, N Nei distance, C Cavalli-Sforza chord measure, R Reynolds distance, L lower-triangular matrix, M multiple data sets.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Gene frequencies in PHYLIP format (staged as 'infile')"
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
    doc: "Distance matrix"
    outputBinding:
      glob: outfile
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
stdout: phylip_gendist.out
