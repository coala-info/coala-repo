cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnadist
label: phylip_dnadist
doc: "Computes distances between sequences. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: D distance model (F84, Kimura, Jukes-Cantor, LogDet, similarity table), G gamma distances, C categories of rates, T transition/transversion ratio, F empirical base frequencies, L square or lower-triangular matrix, M multiple data sets, I interleaved input.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: DNA sequences in PHYLIP format (interleaved by default; answer I at the menu for sequential) (staged as 'infile')
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
    doc: Distance matrix
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
stdout: phylip_dnadist.out
