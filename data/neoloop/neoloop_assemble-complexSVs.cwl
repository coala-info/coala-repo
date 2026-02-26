cwlVersion: v1.2
class: CommandLineTool
baseCommand: assemble-complexSVs
label: neoloop_assemble-complexSVs
doc: "Assemble complex SVs given an individual SV list.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: balance_type
    type:
      - 'null'
      - string
    doc: Normalization method.
    default: CNV
    inputBinding:
      position: 101
      prefix: --balance-type
  - id: break_points
    type:
      - 'null'
      - File
    doc: Path to a TXT file containing pairs of break points.
    default: None
    inputBinding:
      position: 101
      prefix: --break-points
  - id: hic
    type:
      - 'null'
      - type: array
        items: string
    doc: List of cooler URIs. If URIs at multiple resolutions are provided, the 
      program will first detect complex SVs from each individual resolution, and
      then combine results from all resolutions in a non-redundant way.
    default: None
    inputBinding:
      position: 101
      prefix: --hic
  - id: log_file
    type:
      - 'null'
      - string
    doc: Logging file name.
    default: assembleSVs.log
    inputBinding:
      position: 101
      prefix: --logFile
  - id: minimum_size
    type:
      - 'null'
      - int
    doc: For intra-chromosomal SVs, only SVs that are larger than this size will
      be considered by the pipeline.
    default: 500000
    inputBinding:
      position: 101
      prefix: --minimum-size
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix.
    default: None
    inputBinding:
      position: 101
      prefix: --output
  - id: protocol
    type:
      - 'null'
      - string
    doc: Experimental protocol of your Hi-C.
    default: insitu
    inputBinding:
      position: 101
      prefix: --protocol
  - id: region_size
    type:
      - 'null'
      - int
    doc: The extended genomic span of SV break points.(bp)
    default: 5000000
    inputBinding:
      position: 101
      prefix: --region-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
stdout: neoloop_assemble-complexSVs.out
