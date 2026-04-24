cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit intersection
label: nwkit_intersection
doc: "Computes the intersection of two phylogenetic trees.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
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
    doc: Input newick file 2. The intersected version of this file will not be 
      generated, so if necessary, replace --infile and --infile2 and run again.
    inputBinding:
      position: 101
      prefix: --infile2
  - id: match
    type:
      - 'null'
      - string
    doc: Method for ID matching.
    inputBinding:
      position: 101
      prefix: --match
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
  - id: seqformat
    type:
      - 'null'
      - string
    doc: Alignment format for --seqfile. See https://biopython.org/wiki/SeqIO
    inputBinding:
      position: 101
      prefix: --seqformat
  - id: seqin
    type:
      - 'null'
      - File
    doc: Input sequence file.
    inputBinding:
      position: 101
      prefix: --seqin
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
  - id: seqout
    type:
      - 'null'
      - File
    doc: Output sequence file.
    outputBinding:
      glob: $(inputs.seqout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
