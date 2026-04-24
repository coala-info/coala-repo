cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - binarize
label: yame_binarize
doc: "Convert per-site M/U counts (format 3) into a packed binary-with-universe track
  (format 6).\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx
    type: File
    doc: Input format 3 (.cx) with per-site (M,U) stored as uint64.
    inputBinding:
      position: 1
  - id: beta_threshold
    type:
      - 'null'
      - float
    doc: Beta threshold
    inputBinding:
      position: 102
      prefix: -t
  - id: m_count_threshold
    type:
      - 'null'
      - int
    doc: M-count threshold (if >0 overrides -t)
    inputBinding:
      position: 102
      prefix: -m
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage (M+U) to include a site in universe
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
