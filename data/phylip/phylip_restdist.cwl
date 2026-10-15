cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - restdist
label: phylip_restdist
doc: "Computes distances between species from restriction sites or restriction fragments. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: R sites or fragments, N original or modified Nei/Li model, G gamma distribution of rates, T transition/transversion ratio, S site length, L lower-triangular matrix, M multiple data sets, I interleaved input.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Restriction data in PHYLIP format; the first line holds the numbers of species, sites and enzymes (staged as 'infile')"
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
stdout: phylip_restdist.out
