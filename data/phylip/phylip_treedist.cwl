cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treedist
label: phylip_treedist
doc: "Computes distances between trees (symmetric difference or branch score distance). The program has no command-line options: it reads a menu from standard input (menu_answers) and reads fixed file names from the working directory. Menu letters: D distance type (branch score or symmetric difference), R rooted trees, 2 tree pairing submenu (A adjacent pairs, P all pairs in one file, C corresponding pairs of two files, L all pairs between two files), T terminal type. The pairing and output-format letters (F full matrix, V verbose, S sparse) are typed at the prompts right after the option 2 answer.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: intree
    type: File
    doc: "Trees in Newick format, with branch lengths for the branch score distance (staged as 'intree')"
  - id: intree2
    type:
      - 'null'
      - File
    doc: "Second tree file (read when a tree-pair option that needs two files is chosen) (staged as 'intree2')"
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
    doc: "Tree distances"
    outputBinding:
      glob: outfile
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: intree
        entry: $(inputs.intree)
      - entryname: intree2
        entry: $(inputs.intree2)
      - entryname: menu_answers.txt
        entry: $(inputs.menu_answers.join("\n") + "\n")
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_treedist.out
