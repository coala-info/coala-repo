cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - test-allc
label: methylpy_test-allc
doc: "Test allc file for significant methylation sites, estimating non-conversion
  rates from controls.\n\nTool homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: allc_file
    type: File
    doc: allc file to be tested.
    inputBinding:
      position: 101
      prefix: --allc-file
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: Boolean indicating whether to compress (by gzip) the final output
    default: true
    inputBinding:
      position: 101
      prefix: --compress-output
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum number of reads that must cover a site for it to be tested.
    default: 2
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors you wish to use to parallelize this function
    default: 1
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: remove_chr_prefix
    type:
      - 'null'
      - boolean
    doc: Boolean indicates whether to remove in the final output the "chr" 
      prefix in the chromosome name
    default: true
    inputBinding:
      position: 101
      prefix: --remove-chr-prefix
  - id: sample
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: sig_cutoff
    type:
      - 'null'
      - float
    doc: Float indicating at what FDR you want to consider a result significant.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --sig-cutoff
  - id: sort_mem
    type:
      - 'null'
      - string
    doc: Parameter to pass to unix sort with -S/--buffer-size command
    default: 500M
    inputBinding:
      position: 101
      prefix: --sort-mem
  - id: unmethylated_control
    type:
      - 'null'
      - string
    doc: 'name of the chromosome/region that you want to use to estimate the non-conversion
      rate of your sample, or the non-conversion rate you would like to use. Consequently,
      control is either a string, or a decimal. If control is a string then it should
      be in the following format: "chrom:start-end". If you would like to specify
      an entire chromosome simply use "chrom:"'
    inputBinding:
      position: 101
      prefix: --unmethylated-control
outputs:
  - id: path_to_output
    type:
      - 'null'
      - Directory
    doc: Path to a directory where you would like the output to be stored. The 
      default is the same directory as the input fastqs.
    outputBinding:
      glob: $(inputs.path_to_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
