cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree.py
label: frogs_tree
doc: "Phylogenetic tree reconstruction\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program."
    inputBinding:
      position: 1
      prefix: --debug
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: input_fasta
    type: File
    doc: "Path to input FASTA file of ASV seed sequences. Warning: FROGS Tree is only working on less than 10000 sequences!"
    inputBinding:
      position: 3
      prefix: --input-fasta
  - id: input_biom
    type: File
    doc: "Path to the abundance BIOM file."
    inputBinding:
      position: 4
      prefix: --input-biom
  - id: output_tree_path
    type: ['null', string]
    doc: "Path to store resulting Newick tree file. (format: nwk) [Default: tree.nwk]"
    inputBinding:
      position: 5
      prefix: --output-tree
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: tree.html]"
    inputBinding:
      position: 6
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 7
      prefix: --log-file
outputs:
  - id: output_tree
    type: ['null', File]
    doc: "Path to store resulting Newick tree file. (format: nwk) [Default: tree.nwk]"
    outputBinding:
      glob: '${ return inputs.output_tree_path ? inputs.output_tree_path : ''tree.nwk''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: tree.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''tree.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''tree_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: tree_stdout.txt
