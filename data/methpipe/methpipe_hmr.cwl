cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmr
label: methpipe_hmr
doc: "Identify HMRs in methylomes. Methylation must be provided in the methcounts
  format (chrom, position, strand, context, methylation, reads). This program assumes
  only data at CpG sites and that strands are collapsed so only the positive site
  appears in the file.\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs:
  - id: methylation_file
    type: File
    doc: Input methylation file in methcounts format
    inputBinding:
      position: 1
  - id: max_dist
    type:
      - 'null'
      - int
    doc: max dist btwn covered cpgs in HMR
    inputBinding:
      position: 102
      prefix: -desert
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: max iterations
    inputBinding:
      position: 102
      prefix: -itr
  - id: params_in
    type:
      - 'null'
      - File
    doc: HMM parameter file (override training)
    inputBinding:
      position: 102
      prefix: -params-in
  - id: partial
    type:
      - 'null'
      - boolean
    doc: identify PMRs instead of HMRs
    inputBinding:
      position: 102
      prefix: -partial
  - id: seed
    type:
      - 'null'
      - int
    doc: specify random seed
    inputBinding:
      position: 102
      prefix: -seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
  - id: params_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `params_out_path`
    inputBinding:
      position: 104
      prefix: --params-out
  - id: post_hypo_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `post_hypo_path`
    inputBinding:
      position: 105
      prefix: --post-hypo
  - id: post_meth_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `post_meth_path`
    inputBinding:
      position: 106
      prefix: --post-meth
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: post_hypo
    type:
      - 'null'
      - File
    doc: 'output file for single-CpG posterior hypomethylation probability (default:
      none)'
    outputBinding:
      glob: $(inputs.post_hypo_path)
  - id: post_meth
    type:
      - 'null'
      - File
    doc: 'output file for single-CpG posteiror methylation probability (default: none)'
    outputBinding:
      glob: $(inputs.post_meth_path)
  - id: params_out
    type:
      - 'null'
      - File
    doc: 'write HMM parameters to this file (default: none)'
    outputBinding:
      glob: $(inputs.params_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
