cwlVersion: v1.2
class: CommandLineTool
baseCommand: write_results.py
label: phylowgs_write_results.py
doc: "Write JSON files describing trees\n\nTool homepage: https://github.com/morrislab/phylowgs"
inputs:
  - id: dataset_name
    type: string
    doc: Name identifying dataset
    inputBinding:
      position: 1
  - id: tree_file
    type: File
    doc: File containing sampled trees
    inputBinding:
      position: 2
  - id: include_ssm_names
    type:
      - 'null'
      - boolean
    doc: "Include SSM names in output (which may be sensitive\n                  \
      \     data)"
    default: false
    inputBinding:
      position: 103
      prefix: --include-ssm-names
  - id: min_ssms
    type:
      - 'null'
      - float
    doc: Minimum number or percent of SSMs to retain a subclone
    default: 0.01
    inputBinding:
      position: 103
      prefix: --min-ssms
outputs:
  - id: tree_summary_output
    type: File
    doc: Output file for JSON-formatted tree summaries
    outputBinding:
      glob: '*.out'
  - id: mutlist_output
    type: File
    doc: Output file for JSON-formatted list of mutations
    outputBinding:
      glob: '*.out'
  - id: mutass_output
    type: File
    doc: "Output file for JSON-formatted list of SSMs and CNVs\n                 \
      \      assigned to each subclone"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylowgs:20181105--py27ha7db03b_3
