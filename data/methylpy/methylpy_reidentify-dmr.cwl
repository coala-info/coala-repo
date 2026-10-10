cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - reidentify-DMR
label: methylpy_reidentify-dmr
doc: "Re-call DMRs from existing DMRfind result.\n\nTool homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: input_rms_file
    type: File
    doc: File storing the results of RMS tests (from DMRfind function).
    inputBinding:
      position: 101
      prefix: --input-rms-file
  - id: collapse_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of samples for collapsing blocks
    inputBinding:
      position: 101
      prefix: --collapse-samples
  - id: sample_category
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of categories that each respective sample belongs to; the categories
      must begin at 0 and increase by 1 for each category added. For example samples
      [A,B,C] with categories [0,1,2] or categories [0,1,0]"
    inputBinding:
      position: 101
      prefix: --sample-category
  - id: min_cluster
    type:
      - 'null'
      - int
    doc: The minimum number of each sample category that must be present in 
      every block that is output.
    inputBinding:
      position: 101
      prefix: --min-cluster
  - id: sig_cutoff
    type:
      - 'null'
      - float
    doc: Float indicating at what FDR you want to consider a result significant.
    inputBinding:
      position: 101
      prefix: --sig-cutoff
  - id: dmr_max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance two significant sites can be to be included in the 
      same block.
    inputBinding:
      position: 101
      prefix: --dmr-max-dist
  - id: min_num_dms
    type:
      - 'null'
      - int
    doc: The minimum number of differentially methylated sites that a 
      differentially methylated region needs to contain to be reported
    inputBinding:
      position: 101
      prefix: --min-num-dms
  - id: resid_cutoff
    type:
      - 'null'
      - float
    doc: Results will have to show deviations in the contingency table in the 
      same direction as the rest of the window
    inputBinding:
      position: 101
      prefix: --resid-cutoff
  - id: num_sims
    type:
      - 'null'
      - int
    doc: Number of permutation tests you would like to run to estimate the 
      p-values of the differential methylation tests
    inputBinding:
      position: 101
      prefix: --num-sims
  - id: min_tests
    type:
      - 'null'
      - int
    doc: Minimum number of permuation tests you would like to run for each mC
    inputBinding:
      position: 101
      prefix: --min-tests
  - id: output_file_path
    type: string
    doc: String indicating the name of output file
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Re-called DMR table and the DMR/DMS bed files
    outputBinding:
      glob: $(inputs.output_file_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
