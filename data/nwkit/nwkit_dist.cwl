cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit dist
label: nwkit_dist
doc: "Calculate distances between two Newick trees.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: dist
    type:
      - 'null'
      - string
    doc: Distance calculation method. RF=Robinson-Foulds
    inputBinding:
      position: 101
      prefix: --dist
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    inputBinding:
      position: 101
      prefix: --format
  - id: format2
    type:
      - 'null'
      - int
    doc: ETE tree format for --infile2.
    inputBinding:
      position: 101
      prefix: --format2
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --infile
  - id: infile2
    type:
      - 'null'
      - File
    doc: Input newick file 2.
    inputBinding:
      position: 101
      prefix: --infile2
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    inputBinding:
      position: 101
      prefix: --quoted_node_names
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
