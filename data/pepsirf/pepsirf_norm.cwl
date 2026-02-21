cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - norm
label: pepsirf_norm
doc: "Peptide-based Serological Immune Response Framework score normalization module.
  The norm module is used to normalize raw count data to allow for meaningful comparison
  among samples.\n\nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: negative_control
    type:
      - 'null'
      - File
    doc: Optional data matrix for sb samples.
    inputBinding:
      position: 101
      prefix: --negative_control
  - id: negative_id
    type:
      - 'null'
      - string
    doc: Optional approach for identifying negative controls. Provide a unique string
      at the start of all negative control samples.
    inputBinding:
      position: 101
      prefix: --negative_id
  - id: negative_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional approach for identifying negative controls. Comma-separated list
      of negative control sample names.
    inputBinding:
      position: 101
      prefix: --negative_names
  - id: normalize_approach
    type:
      - 'null'
      - string
    doc: "Options: 'col_sum', 'size_factors', 'diff', 'ratio', 'diff_ratio'. 'col_sum':
      column-sum method; 'size_factors': Anders and Huber 2010 method; 'diff': difference
      from negative controls; 'ratio': ratio to negative controls; 'diff_ratio': difference
      divided by mean of negative controls."
    default: col_sum
    inputBinding:
      position: 101
      prefix: --normalize_approach
  - id: peptide_scores
    type: File
    doc: Name of tab-delimited matrix file containing peptide scores. This file should
      be in the same format as the output from the demux module.
    inputBinding:
      position: 101
      prefix: --peptide_scores
  - id: precision
    type:
      - 'null'
      - int
    doc: Output score precision. The scores written to the output will be output to
      this many decimal places.
    default: 2
    inputBinding:
      position: 101
      prefix: --precision
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output file. The output is formatted in the same way the input
      file provided with 'peptide_scores'.
    outputBinding:
      glob: $(inputs.output)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
