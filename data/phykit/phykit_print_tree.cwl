cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - print_tree
label: phykit_print_tree
doc: Print ascii tree of input phylogeny. Phylogeny can be printed with or 
  without branch lengths. By default, the phylogeny will be printed with branch 
  lengths but branch lengths can be removed using the -r/--remove argument.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: remove
    type:
      - 'null'
      - boolean
    doc: optional argument to print the phylogeny without branch lengths
    inputBinding:
      position: 102
      prefix: --remove
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_print_tree.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
