cwlVersion: v1.2
class: CommandLineTool
baseCommand: ihsbin
label: hapbin_ihsbin
doc: "Calculate iHS values for SNPs based on haplotype data.\n\nTool homepage: https://github.com/evotools/hapbin"
inputs:
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Output in ASCII format
    inputBinding:
      position: 101
      prefix: --ascii
  - id: ehh_cutoff
    type:
      - 'null'
      - float
    doc: EHH cutoff value
    default: 0.05
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: freq_bins
    type:
      - 'null'
      - int
    doc: Number of frequency bins for iHS normalization
    default: 50
    inputBinding:
      position: 101
      prefix: --bin
  - id: gap_scale
    type:
      - 'null'
      - float
    doc: Gap scale parameter in bp, used to scale gaps > scale parameter as in 
      Voight, et al.
    inputBinding:
      position: 101
      prefix: --scale
  - id: hap_file
    type: File
    doc: Hap file
    inputBinding:
      position: 101
      prefix: --hap
  - id: map_file
    type: File
    doc: Map file
    inputBinding:
      position: 101
      prefix: --map
  - id: max_extend
    type:
      - 'null'
      - int
    doc: Maximum distance in bp to traverse when calculating EHH
    default: 0
    inputBinding:
      position: 101
      prefix: --max-extend
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    default: 0.05
    inputBinding:
      position: 101
      prefix: --minmaf
  - id: use_binomial_coeffs
    type:
      - 'null'
      - boolean
    doc: Use binomial coefficients rather than frequency squared for EHH
    inputBinding:
      position: 101
      prefix: --binom
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
