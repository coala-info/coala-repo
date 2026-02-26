cwlVersion: v1.2
class: CommandLineTool
baseCommand: mamotif integrate
label: mamotif_integrate
doc: "Run the integration module with MAnorm and MotifScan results.\n\nThis command
  is used when users have already got the MAnorm and MotifScan \nresults, and only
  run the final integration procedure.\n\nTool homepage: https://github.com/shao-lab/MAmotif"
inputs:
  - id: correction
    type:
      - 'null'
      - string
    doc: Method for multiple testing correction.
    default: benjamin
    inputBinding:
      position: 101
      prefix: --correction
  - id: downstream_distance
    type:
      - 'null'
      - int
    doc: TSS downstream distance for promoters.
    default: 2000
    inputBinding:
      position: 101
      prefix: --downstream
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome name. Required if `--split` is enabled.
    inputBinding:
      position: 101
      prefix: -g
  - id: manorm_result_a_or_b
    type: File
    doc: MAnorm result for sample A or B (A/B_MAvalues.xls).
    inputBinding:
      position: 101
      prefix: -i
  - id: motifscan_result_a_or_b
    type: File
    doc: "MotifScan result for sample A or B\n                        (motif_sites_number.xls)."
    inputBinding:
      position: 101
      prefix: -m
  - id: negative
    type:
      - 'null'
      - boolean
    doc: "Convert M=log2(A/B) to -M=log2(B/A). Required when\n                   \
      \     finding co-factors for sample B."
    inputBinding:
      position: 101
      prefix: --negative
  - id: split
    type:
      - 'null'
      - boolean
    doc: "Split genomic regions into promoter/distal regions and\n               \
      \         run separately."
    inputBinding:
      position: 101
      prefix: --split
  - id: upstream_distance
    type:
      - 'null'
      - int
    doc: TSS upstream distance for promoters.
    default: 4000
    inputBinding:
      position: 101
      prefix: --upstream
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose log messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mamotif:1.1.0--py_0
