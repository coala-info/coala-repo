cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk_mztab_class_fdr
label: pypgatk_mztab_class_fdr
doc: "Filter peptides by global-fdr and class-fdr\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: class_fdr_cutoff
    type:
      - 'null'
      - string
    doc: PSM peptide class-fdr cutoff or threshold. Default is 0.01
    default: '0.01'
    inputBinding:
      position: 101
      prefix: --class_fdr_cutoff
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration file for the fdr peptides pipeline
    inputBinding:
      position: 101
      prefix: --config_file
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Default is "decoy"
    default: decoy
    inputBinding:
      position: 101
      prefix: --decoy_prefix
  - id: global_fdr_cutoff
    type:
      - 'null'
      - string
    doc: PSM peptide global-fdr cutoff or threshold. Default is 0.01
    default: '0.01'
    inputBinding:
      position: 101
      prefix: --global_fdr_cutoff
  - id: input_mztab
    type:
      - 'null'
      - string
    doc: The file name of the input mzTab
    inputBinding:
      position: 101
      prefix: --input_mztab
  - id: peptide_groups_prefix
    type:
      - 'null'
      - string
    doc: "Peptide class groups e.g. \"{non_canonical:[a\n                        \
      \          ltorf,pseudo,ncRNA];mutations:[COSMIC,cbiomu\n                  \
      \                t];variants:[var_mut,var_rs]}\""
    inputBinding:
      position: 101
      prefix: --peptide_groups_prefix
outputs:
  - id: outfile_name
    type:
      - 'null'
      - File
    doc: The file name of the psm table filtered by global-fdr and class-fdr
    outputBinding:
      glob: $(inputs.outfile_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
