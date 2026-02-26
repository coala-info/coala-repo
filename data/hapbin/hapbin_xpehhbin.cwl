cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpehhbin
label: hapbin_xpehhbin
doc: "Calculate XP-EHH values for bins of SNPs.\n\nTool homepage: https://github.com/evotools/hapbin"
inputs:
  - id: bin
    type:
      - 'null'
      - int
    doc: Number of frequency bins for iHS normalization
    default: 50
    inputBinding:
      position: 101
      prefix: --bin
  - id: binom
    type:
      - 'null'
      - boolean
    doc: Use binomial coefficients rather than frequency squared for EHH
    inputBinding:
      position: 101
      prefix: --binom
  - id: cutoff
    type:
      - 'null'
      - float
    doc: EHH cutoff value
    default: 0.05
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: hapA
    type: File
    doc: Hap file for population A
    inputBinding:
      position: 101
      prefix: --hapA
  - id: hapB
    type: File
    doc: Hap file for population B
    inputBinding:
      position: 101
      prefix: --hapB
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
  - id: minmaf
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    default: 0.05
    inputBinding:
      position: 101
      prefix: --minmaf
  - id: scale
    type:
      - 'null'
      - float
    doc: Gap scale parameter in bp, used to scale gaps > scale parameter as in 
      Voight, et al.
    inputBinding:
      position: 101
      prefix: --scale
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
