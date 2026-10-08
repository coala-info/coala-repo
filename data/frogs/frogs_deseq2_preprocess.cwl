cwlVersion: v1.2
class: CommandLineTool
baseCommand: deseq2_preprocess.py
label: frogs_deseq2_preprocess
doc: "Launch Rscript to generate dataframe of DESEq2 from a phyloseq object in RData file\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program."
    inputBinding:
      position: 1
      prefix: --debug
  - id: var_exp
    type: string
    doc: "Experimental variable suspected to have an impact on abundances. You may precise complexe string such as variables with confounding effect (ex: Treatment+Gender or Treatmet*Gender)"
    inputBinding:
      position: 2
      prefix: --var-exp
  - id: analysis_type
    type: {type: enum, symbols: [ASV, FUNCTION]}
    doc: "Differential analysis on ASV (see phyloseq_import.py) or on Function abundance (see frogsfunc_functions.py)."
    inputBinding:
      position: 3
      prefix: --analysis-type
  - id: phyloseq_rdata
    type: ['null', File]
    doc: "The path of RData file containing a phyloseq object- the result of phyloseq_import.py. Required."
    inputBinding:
      position: 4
      prefix: --phyloseq-rdata
  - id: input_functions_abund
    type: ['null', File]
    doc: "Input file of metagenome function prediction abundances (frogsfunc_functions_unstrat.tsv from frogsfunc_functions.py). Required."
    inputBinding:
      position: 5
      prefix: --input-functions-abund
  - id: sample_metadata_tsv
    type: ['null', File]
    doc: "path to sample file (format: TSV). Required."
    inputBinding:
      position: 6
      prefix: --sample-metadata-tsv
  - id: output_deseq_rdata_path
    type: ['null', string]
    doc: "The path to store resulting dataframe of DESeq2. [Default: None]"
    inputBinding:
      position: 7
      prefix: --output-deseq-rdata
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    inputBinding:
      position: 8
      prefix: --log-file
  - id: output_phyloseq_rdata_path
    type: ['null', string]
    doc: "Rdata file path to store phyloseq-class object based on functions abundances and annotation. [Default: phyloseq_fun.Rdata]"
    inputBinding:
      position: 9
      prefix: --output-phyloseq-rdata
outputs:
  - id: output_deseq_rdata
    type: ['null', File]
    doc: "The path to store resulting dataframe of DESeq2. [Default: None]"
    outputBinding:
      glob: '${ return inputs.output_deseq_rdata_path ? inputs.output_deseq_rdata_path : ''None''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''deseq2_preprocess_stdout.txt''; }'
  - id: output_phyloseq_rdata
    type: ['null', File]
    doc: "Rdata file path to store phyloseq-class object based on functions abundances and annotation. [Default: phyloseq_fun.Rdata]"
    outputBinding:
      glob: '${ return inputs.output_phyloseq_rdata_path ? inputs.output_phyloseq_rdata_path : ''phyloseq_fun.Rdata''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: deseq2_preprocess_stdout.txt
