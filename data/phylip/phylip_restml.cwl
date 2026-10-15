cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - restml
label: phylip_restml
doc: "Maximum likelihood estimation of phylogenies from restriction site data. The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: U user trees, A all sites detected, S speedier but rougher analysis, G global rearrangements, J randomize input order (asks for an odd seed), L site length, O outgroup, M multiple data sets, I interleaved input.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: "Restriction site data in PHYLIP format; the first line holds the numbers of species, sites and enzymes (staged as 'infile')"
  - id: intree
    type:
      - 'null'
      - File
    doc: "User tree(s) in Newick format (read when the menu option for user trees is chosen) (staged as 'intree')"
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
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_restml.out
