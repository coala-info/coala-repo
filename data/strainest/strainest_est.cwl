cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - est
label: strainest_est
doc: "Estimate relative abundance of strains. The BAM file must be sorted and indexed.\n\
  \nTool homepage: https://github.com/compmetagen/strainest"
inputs:
  - id: snp_file
    type: File
    doc: SNP file
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: BAM file
    inputBinding:
      position: 2
  - id: max_depth_percentile
    type:
      - 'null'
      - float
    doc: discard positions where the depth of coverage is higher than the 
      MAX_DEPTH_PERCENTILE percentile
    inputBinding:
      position: 103
      prefix: --max-depth-percentile
  - id: max_ident_thr
    type:
      - 'null'
      - float
    doc: discard genomes with less than MAX_IDENT_THR maximum identity
    inputBinding:
      position: 103
      prefix: --max-ident-thr
  - id: min_depth_absolute
    type:
      - 'null'
      - int
    doc: discard positions where the depth of coverage is lower than the 
      MIN_DEPTH_ABSOLUTE
    inputBinding:
      position: 103
      prefix: --min-depth-absolute
  - id: min_depth_base
    type:
      - 'null'
      - float
    doc: filter base counts (set to 0) where they are lower then MIN_DEPTH_BASE 
      x DoC (applied independently for each allelic position)
    inputBinding:
      position: 103
      prefix: --min-depth-base
  - id: min_depth_percentile
    type:
      - 'null'
      - float
    doc: discard positions where the depth of coverage is lower than the 
      MIN_DEPTH_PERCENTILE percentile
    inputBinding:
      position: 103
      prefix: --min-depth-percentile
  - id: quality_thr
    type:
      - 'null'
      - int
    doc: base quality threshold
    inputBinding:
      position: 103
      prefix: --quality-thr
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use in model selection
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py35_0
