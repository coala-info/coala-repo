cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloseq_structure.py
label: frogs_phyloseq_structure
doc: "Visulization of data structure with heatmap plot and ordination plot of Phyloseq.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: var_exp
    type: string
    doc: "The experiment variable you want to analyse. [Default: None]"
    inputBinding:
      position: 2
      prefix: --var-exp
  - id: ordination_method
    type: ['null', {type: enum, symbols: [MDS, NMDS, DPCoA, PCoA]}]
    doc: "The ordination methods. [Default: MDS]"
    inputBinding:
      position: 3
      prefix: --ordination-method
  - id: phyloseq_rdata
    type: File
    doc: "The path of RData file containing a phyloseq object- the result of phyloseq_import.py. [Default: None]"
    inputBinding:
      position: 4
      prefix: --phyloseq-rdata
  - id: beta_distance_matrix
    type: File
    doc: "Path of data file containing beta diversity distance matrix. These file is the result of FROGS Phyloseq Beta Diversity. [Default: None]"
    inputBinding:
      position: 5
      prefix: --beta-distance-matrix
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: phyloseq_structure.nb.html]"
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
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: phyloseq_structure.nb.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''phyloseq_structure.nb.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''phyloseq_structure_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: phyloseq_structure_stdout.txt
