cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - protdist
label: phylip_protdist
doc: "Computes distances between protein sequences (JTT, PMB, PAM, Kimura or categories model). The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: P distance model, G gamma distribution of rates, C site categories, W weights, M multiple data sets, I interleaved input.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Protein sequences in PHYLIP format (staged as 'infile')"
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
      - entryname: weights
        entry: $(inputs.weights)
      - entryname: categories
        entry: $(inputs.categories)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_protdist.out
