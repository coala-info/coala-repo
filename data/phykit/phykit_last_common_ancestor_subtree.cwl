cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - last_common_ancestor_subtree
label: phykit_last_common_ancestor_subtree
doc: Obtains subtree from a phylogeny by getting the last common ancestor from a
  list of taxa.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: list_of_taxa
    type:
      - 'null'
      - File
    doc: list of taxa to get the last common ancestor subtree for
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: optional argument to name the outputted tree file
    inputBinding:
      position: 103
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 103
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: optional argument to name the outputted tree file
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
