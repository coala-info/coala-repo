cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunc_summarise
label: gunc_summarise
doc: "Summarize GUNC results.\n\nTool homepage: https://github.com/grp-bork/gunc"
inputs:
  - id: contamination_cutoff
    type:
      - 'null'
      - float
    doc: Alternatite cutoff to use.
    inputBinding:
      position: 101
      prefix: --contamination_cutoff
  - id: gunc_detailed_output_dir
    type: Directory
    doc: GUNC detailed output dir (e.g. gunc_output).
    inputBinding:
      position: 101
      prefix: --gunc_detailed_output_dir
  - id: max_csslevel_file
    type: File
    doc: MaxCSS output file from GUNC (e.g. 
      GUNC.progenomes_2.1.maxCSS_level.tsv).
    inputBinding:
      position: 101
      prefix: --max_csslevel_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: File in which to write outputfile with added score.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
