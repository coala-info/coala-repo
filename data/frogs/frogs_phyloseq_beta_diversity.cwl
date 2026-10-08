cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloseq_beta_diversity.py
label: frogs_phyloseq_beta_diversity
doc: "To present the data beta diversity with phyloseq.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
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
  - id: beta_distance_methods
    type: {type: array, items: string}
    doc: "Beta diversity methods to use (list available in Phyloseq manual, see https://www.bioconductor.org/pack ages/devel/bioc/manuals/phyloseq/man/phyloseq.pdf). [Default: ['bray', 'cc', 'unifrac', 'wunifrac']]."
    inputBinding:
      position: 3
      prefix: --beta-distance-methods
  - id: phyloseq_rdata
    type: File
    doc: "The path of RData file containing a phyloseq object- the result of phyloseq_import.py. [Default: None]"
    inputBinding:
      position: 4
      prefix: --phyloseq-rdata
  - id: matrix_outdir_path
    type: string
    doc: "Path to output matrix file"
    inputBinding:
      position: 5
      prefix: --matrix-outdir
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: phyloseq_beta_diversity.nb.html]"
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
  - id: matrix_outdir
    type: Directory
    doc: "Path to output matrix file"
    outputBinding:
      glob: $(inputs.matrix_outdir_path)
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: phyloseq_beta_diversity.nb.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''phyloseq_beta_diversity.nb.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''phyloseq_beta_diversity_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: phyloseq_beta_diversity_stdout.txt
