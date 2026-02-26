cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - filter-allc
label: methylpy_filter-allc
doc: "Filter allc files based on coverage, mismatch, and sequence context.\n\nTool
  homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: allc_files
    type:
      type: array
      items: File
    doc: allc files to filter.
    inputBinding:
      position: 101
      prefix: --allc-files
  - id: chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated listing of chromosomes to be included in the output. By
      default, data of all chromosomes in input allc file will be included.
    inputBinding:
      position: 101
      prefix: --chroms
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: Boolean indicating whether to compress (by gzip) the final output
    default: true
    inputBinding:
      position: 101
      prefix: --compress-output
  - id: max_cov
    type:
      - 'null'
      - int
    doc: Maximum number of reads that must cover a site for it to be included in
      the output file. By default this cutoff is not applied.
    inputBinding:
      position: 101
      prefix: --max-cov
  - id: max_mismatch
    type:
      - 'null'
      - type: array
        items: int
    doc: Maximum numbers of mismatch basecalls allowed in each nucleotide in the
      sequence context of a site for it to be included in output file. If the 
      sequence context has three nucleotides, an example of this option is "0 1 
      2".
    inputBinding:
      position: 101
      prefix: --max-mismatch
  - id: max_mismatch_frac
    type:
      - 'null'
      - type: array
        items: float
    doc: Maximum fraction of mismatch basecalls out of unambiguous basecalls 
      allowed in each nucleotide in the sequence context of a site for it to be 
      included in output file. If the sequence context has three nucleotides, an
      example of this option is "0 0 0.1".
    inputBinding:
      position: 101
      prefix: --max-mismatch-frac
  - id: mc_type
    type:
      - 'null'
      - type: array
        items: string
    doc: List of space separated cytosine nucleotide contexts for sites to be 
      included in output file. These classifications may use the wildcards H 
      (indicating anything but a G) and N (indicating any nucleotide).
    inputBinding:
      position: 101
      prefix: --mc-type
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum number of reads that must cover a site for it to be included in
      the output file.
    default: 0
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
outputs:
  - id: output_files
    type: File
    doc: Name of output files. Each output file matches each allc file.
    outputBinding:
      glob: $(inputs.output_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
