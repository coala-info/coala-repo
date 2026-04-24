cwlVersion: v1.2
class: CommandLineTool
baseCommand: ehhbin
label: hapbin_ehhbin
doc: "Calculate EHH and EHHbin statistics for a given locus.\n\nTool homepage: https://github.com/evotools/hapbin"
inputs:
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
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: hap_file
    type: File
    doc: Hap file
    inputBinding:
      position: 101
      prefix: --hap
  - id: locus_id
    type: string
    doc: Locus ID
    inputBinding:
      position: 101
      prefix: --locus
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
    inputBinding:
      position: 101
      prefix: --max-extend
  - id: minmaf
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
stdout: hapbin_ehhbin.out
