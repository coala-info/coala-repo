cwlVersion: v1.2
class: CommandLineTool
baseCommand: deseq2_visualisation.py
label: frogs_deseq2_visualisation
doc: "Launch Rmarkdown to visualise differential abundance analysis.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program."
    inputBinding:
      position: 1
      prefix: --debug
  - id: var_exp
    type: string
    doc: "variable that you want to test."
    inputBinding:
      position: 2
      prefix: --var-exp
  - id: mod1
    type: ['null', string]
    doc: "one value of the tested variable you want to compare (if more than 2 value in your experiement variable analyzed.) [Default: None]"
    inputBinding:
      position: 3
      prefix: --mod1
  - id: mod2
    type: ['null', string]
    doc: "second value of the tested variable you want to compare.(if more than 2 value in your experiement variable analyzed.) [Default: None]"
    inputBinding:
      position: 4
      prefix: --mod2
  - id: padj
    type: ['null', float]
    doc: "the adjusted p-value threshold to defined ASV as differentially abundant. [Default: 0.05]"
    inputBinding:
      position: 5
      prefix: --padj
  - id: analysis_type
    type: {type: enum, symbols: [ASV, FUNCTION]}
    doc: "Type of data to perform the differential analysis. ASV: DESeq2 is run on the ASVs abundances table. FUNC: DESeq2 is run on FROGSFUNC function abundances table (frogsfunc_functions_unstrat.tsv from FROGSFUNC function step). [Default: ASV]"
    inputBinding:
      position: 6
      prefix: --analysis-type
  - id: phyloseq_rdata
    type: File
    doc: "Phyloseq RData file containing the either ASV or FUNCTION abundances (see phyloseq_import.py or deseq2_visualisation.py"
    inputBinding:
      position: 7
      prefix: --phyloseq-rdata
  - id: deseq_rdata
    type: File
    doc: "DESeq RData file containing dds object (see deseq_preprocess.py)"
    inputBinding:
      position: 8
      prefix: --deseq-rdata
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: DESeq2_visualisation.html]"
    inputBinding:
      position: 9
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 10
      prefix: --log-file
  - id: output_ipath_over_path
    type: ['null', string]
    doc: "The tsv file of over abundants functions [Default:ipath_over.tsv]"
    inputBinding:
      position: 11
      prefix: --output-ipath-over
  - id: output_ipath_under_path
    type: ['null', string]
    doc: "The tsv file of under abundants functions [Default:ipath_under.tsv]"
    inputBinding:
      position: 12
      prefix: --output-ipath-under
outputs:
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: DESeq2_visualisation.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''DESeq2_visualisation.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''deseq2_visualisation_stdout.txt''; }'
  - id: output_ipath_over
    type: ['null', File]
    doc: "The tsv file of over abundants functions [Default:ipath_over.tsv]"
    outputBinding:
      glob: '${ return inputs.output_ipath_over_path ? inputs.output_ipath_over_path : ''ipath_over.tsv''; }'
  - id: output_ipath_under
    type: ['null', File]
    doc: "The tsv file of under abundants functions [Default:ipath_under.tsv]"
    outputBinding:
      glob: '${ return inputs.output_ipath_under_path ? inputs.output_ipath_under_path : ''ipath_under.tsv''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: deseq2_visualisation_stdout.txt
