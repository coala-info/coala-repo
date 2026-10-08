cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloseq_composition.py
label: frogs_phyloseq_composition
doc: "Present the composition of data with package phyloseq\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: var_exp
    type: string
    doc: "The experiment variable used to split plot."
    inputBinding:
      position: 2
      prefix: --var-exp
  - id: taxa_rank_1
    type: string
    doc: "Select taxonomic rank name to subset your data. [ex: Kingdom]"
    inputBinding:
      position: 3
      prefix: --taxa-rank-1
  - id: taxa_set_1
    type: {type: array, items: string}
    doc: "Select taxon name among taxaRank1 to subset your data. [ex: Bacteria]"
    inputBinding:
      position: 4
      prefix: --taxa-set-1
  - id: taxa_rank_2
    type: string
    doc: "Select sub taxonomic rank name to aggregate your data. [ex: Phylum]\""
    inputBinding:
      position: 5
      prefix: --taxa-rank-2
  - id: number_of_taxa
    type: int
    doc: "The number of the most abundant taxa to keep at taxaRank2. [ex: 9]\""
    inputBinding:
      position: 6
      prefix: --number-of-taxa
  - id: phyloseq_rdata
    type: File
    doc: "The path of RData file containing a phyloseq object- the result of phyloseq_import.py. [Default: None]"
    inputBinding:
      position: 7
      prefix: --phyloseq-rdata
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: phyloseq_composition.nb.html]"
    inputBinding:
      position: 8
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    inputBinding:
      position: 9
      prefix: --log-file
outputs:
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: phyloseq_composition.nb.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''phyloseq_composition.nb.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''phyloseq_composition_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: phyloseq_composition_stdout.txt
