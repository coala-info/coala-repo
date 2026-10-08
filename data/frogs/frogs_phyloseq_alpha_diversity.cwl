cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloseq_alpha_diversity.py
label: frogs_phyloseq_alpha_diversity
doc: "To compute and present the data alpha diversity with plot_richness of Phyloseq.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: var_exp
    type: string
    doc: "The experiment variable used to aggregate sample diversities. [Default: None]"
    inputBinding:
      position: 2
      prefix: --var-exp
  - id: alpha_measures
    type: ['null', {type: array, items: string}]
    doc: "The indices of alpha diversity. Available indices : Observed, Chao1, Shannon, InvSimpson, Simpson, ACE, Fisher. [Default: ['Observed', 'Chao1', 'Shannon', 'InvSimpson']]"
    inputBinding:
      position: 3
      prefix: --alpha-measures
  - id: phyloseq_rdata
    type: File
    doc: "The path of RData file containing a phyloseq object- the result of phyloseq_import.py. [Default: None]"
    inputBinding:
      position: 4
      prefix: --phyloseq-rdata
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: phyloseq_alpha_diversity.nb.html]"
    inputBinding:
      position: 5
      prefix: --html
  - id: output_alpha_tsv_path
    type: ['null', string]
    doc: "The path to store resulting data file containing alpha diversity table. [Default: phyloseq_alpha_diversity.tsv]"
    inputBinding:
      position: 6
      prefix: --output-alpha-tsv
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 7
      prefix: --log-file
outputs:
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: phyloseq_alpha_diversity.nb.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''phyloseq_alpha_diversity.nb.html''; }'
  - id: output_alpha_tsv
    type: ['null', File]
    doc: "The path to store resulting data file containing alpha diversity table. [Default: phyloseq_alpha_diversity.tsv]"
    outputBinding:
      glob: '${ return inputs.output_alpha_tsv_path ? inputs.output_alpha_tsv_path : ''phyloseq_alpha_diversity.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''phyloseq_alpha_diversity_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: phyloseq_alpha_diversity_stdout.txt
