cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - root_tree
label: phykit_root_tree
doc: Roots phylogeny using user-specified taxa. A list of taxa to root the 
  phylogeny on should be specified using the -r argument. The root_taxa file 
  should be a single-column file with taxa names. The outputted file will have 
  the same name as the inputted tree file but with the suffix ".rooted".
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: root
    type:
      - 'null'
      - File
    doc: single column file with tip names of root taxa
    inputBinding:
      position: 102
      prefix: --root
  - id: output
    type: string
    doc: optional argument to write the rooted tree file to. Default output will
      have the same name as the input file but with the suffix ".rooted"
    inputBinding:
      position: 102
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: optional argument to write the rooted tree file to. Default output will
      have the same name as the input file but with the suffix ".rooted"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
