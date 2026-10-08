cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogsfunc_pathways.py
label: frogs_frogsfunc_pathways
doc: "Infer the presence and abundances of pathways based on gene family abundances in a sample.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: strat_contrib
    type: ['null', boolean]
    doc: "If stratified option is activated, a new table is built. It will contain the abundances of each function of each ASV in each sample. (in contrast to the default stratified output, which is the contribution to the community-wide pathway abundances.) Options --input-asv-copy-norm and --input-fun-copy need to be set when this option is used. [Default: False]"
    inputBinding:
      position: 3
      prefix: --strat-contrib
  - id: hierarchy_ranks
    type: ['null', {type: array, items: string}]
    doc: "The ordered annotation pathways ranks. [Default: ['Level1', 'Level2', 'Level3', 'Pathway']]"
    inputBinding:
      position: 4
      prefix: --hierarchy-ranks
  - id: normalisation
    type: ['null', boolean]
    doc: "To normalise pathway abundances. Values are divided by sum of columns, then multiplied by 10^6 (CPM values). [Default: False]"
    inputBinding:
      position: 5
      prefix: --normalisation
  - id: input_tsv
    type: File
    doc: "Input TSV function abundances table from FROGSFUNC_function (unstratified table : unstrat_abundance_EC.tsv or unstrat_abundance_KO.tsv)."
    inputBinding:
      position: 6
      prefix: --input-tsv
  - id: map
    type: ['null', File]
    doc: "File required if you are not analyzing 16S sequences with the Metacyc (\"EC\" function in the previous step) database. IF MARKER STUDYED STILL 16S: it must indicate the path to the PICRUSt2 KEGG pathways mapfile, if you chose \"KO\" in the previous step (the mapfile is available here : $PICRUSt2_PATH/default_fil es/pathway_mapfiles/KEGG_pathways_to_KO.tsv) IF MARKER STUDYED IS ITS OR 18S: Path to mapping file of pathways to fungi reactions (the mapfile is available here : $PICRUSt2_PATH/default_files/pathway_mapfiles/m etacyc_path2rxn_struc_filt_fungi.txt )."
    inputBinding:
      position: 7
      prefix: --map
  - id: input_asv_copy_norm
    type: ['null', File]
    doc: "ASV abunndances normalized by marker copy number (frogsfunc_functions --output-asv-copy-norm option: frogsfunc_functions_asv_copy_norm_abundance.tsv by default). This input is required when the --strat- contrib option is set. [Default: None]"
    inputBinding:
      position: 8
      prefix: --input-asv-copy-norm
  - id: input_fun_copy
    type: ['null', File]
    doc: "Function copy number per ASV ([FUN]_copynumbers_predicted.tsv output from frogsfunc_functions.py)). This input is required when the --strat-contrib option is set. [Default: None]"
    inputBinding:
      position: 9
      prefix: --input-fun-copy
  - id: output_pathways_contrib_path
    type: ['null', string]
    doc: "Stratified output corresponding to contribution of predicted gene family abundances within each predicted genome. [Default: None]"
    inputBinding:
      position: 10
      prefix: --output-pathways-contrib
  - id: output_pathways_predictions_path
    type: ['null', string]
    doc: "Stratified output corresponding to contribution of predicted gene family abundances within each predicted genome. [Default: None]"
    inputBinding:
      position: 11
      prefix: --output-pathways-predictions
  - id: output_pathways_abund_per_seq_path
    type: ['null', string]
    doc: "Pathway abundance file output per sequences (if --strat-contrib set). [Default: None]"
    inputBinding:
      position: 12
      prefix: --output-pathways-abund-per-seq
  - id: output_pathways_abund_path
    type: ['null', string]
    doc: "Pathway abundance file output. [Default: frogsfunc_pathways_unstrat.tsv]"
    inputBinding:
      position: 13
      prefix: --output-pathways-abund
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    inputBinding:
      position: 14
      prefix: --log-file
  - id: html_path
    type: ['null', string]
    doc: "Path to store resulting html file. [Default: frogsfunc_pathways_summary.html]"
    inputBinding:
      position: 15
      prefix: --html
outputs:
  - id: output_pathways_contrib
    type: ['null', File]
    doc: "Stratified output corresponding to contribution of predicted gene family abundances within each predicted genome. [Default: None]"
    outputBinding:
      glob: '${ return inputs.output_pathways_contrib_path ? inputs.output_pathways_contrib_path : ''None''; }'
  - id: output_pathways_predictions
    type: ['null', File]
    doc: "Stratified output corresponding to contribution of predicted gene family abundances within each predicted genome. [Default: None]"
    outputBinding:
      glob: '${ return inputs.output_pathways_predictions_path ? inputs.output_pathways_predictions_path : ''None''; }'
  - id: output_pathways_abund_per_seq
    type: ['null', File]
    doc: "Pathway abundance file output per sequences (if --strat-contrib set). [Default: None]"
    outputBinding:
      glob: '${ return inputs.output_pathways_abund_per_seq_path ? inputs.output_pathways_abund_per_seq_path : ''None''; }'
  - id: output_pathways_abund
    type: ['null', File]
    doc: "Pathway abundance file output. [Default: frogsfunc_pathways_unstrat.tsv]"
    outputBinding:
      glob: '${ return inputs.output_pathways_abund_path ? inputs.output_pathways_abund_path : ''frogsfunc_pathways_unstrat.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''frogsfunc_pathways_stdout.txt''; }'
  - id: html
    type: ['null', File]
    doc: "Path to store resulting html file. [Default: frogsfunc_pathways_summary.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''frogsfunc_pathways_summary.html''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogsfunc_pathways_stdout.txt
