cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - merge-allc
label: methylpy_merge-allc
doc: "Merge multiple allc files into a single allc file.\n\nTool homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: allc_files
    type:
      type: array
      items: File
    doc: List of allc files to merge.
    inputBinding:
      position: 101
      prefix: --allc-files
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: Boolean indicating whether to compress (by gzip) the final output
    inputBinding:
      position: 101
      prefix: --compress-output
  - id: mini_batch
    type:
      - 'null'
      - int
    doc: The maximum number of allc files to be merged at the same time. Since 
      OS or python may limit the number of files that can be open at once, value
      larger than 200 is not recommended
    inputBinding:
      position: 101
      prefix: --mini-batch
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: skip_snp_info
    type:
      - 'null'
      - boolean
    doc: Boolean indicating whether to skip the merging of SNP information
    inputBinding:
      position: 101
      prefix: --skip-snp-info
outputs:
  - id: output_file
    type: File
    doc: String indicating the name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
