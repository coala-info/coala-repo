cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxtgen]
label: phyx_pxtgen
doc: |-
  Generate all tree topologies for n taxa.
  Random tree samples are a-coming.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: ntax
    type: int
    doc: "number of taxa"
    inputBinding:
      prefix: -n
  - id: rooted
    type: ['null', boolean]
    doc: "whether generated trees are rooted (default: false)"
    inputBinding:
      prefix: -r
  - id: count
    type: ['null', boolean]
    doc: "give the number of possible trees for n taxa and exit"
    inputBinding:
      prefix: -c
  - id: label
    type: ['null', string]
    doc: "prefix label for taxon names (default: 't')"
    inputBinding:
      prefix: -l
  - id: out_file_path
    type: ['null', string]
    doc: "output file name (standard output otherwise)"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: ['null', File]
    doc: "all tree topologies (newick, one per line)"
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: stdout_text
    type: stdout
    doc: "standard output (the number of possible trees with count)"
stdout: pxtgen.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
