cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnainvar
label: phylip_dnainvar
doc: "Nucleic acid sequence invariants method (four species only). The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: W weights, M multiple data sets, I interleaved input, 1 print data, 2 progress, 3 print counts of patterns, 4 print invariants.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: DNA sequences of exactly four species in PHYLIP format (staged as 'infile')
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
    doc: Pattern counts and invariants tests
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
stdout: phylip_dnainvar.out
