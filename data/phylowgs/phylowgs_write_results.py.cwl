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
  - id: tree_summary_output
    type: string
    doc: Output file for JSON-formatted tree summaries
    inputBinding:
      position: 3
  - id: mutlist_output
    type: string
    doc: Output file for JSON-formatted list of mutations
    inputBinding:
      position: 4
  - id: mutass_output
    type: string
    doc: "Output file for JSON-formatted list of SSMs and CNVs\n                 \
      \      assigned to each subclone"
    inputBinding:
      position: 5
  - id: include_ssm_names
    type:
      - 'null'
      - boolean
    doc: "Include SSM names in output (which may be sensitive\n                  \
      \     data)"
    inputBinding:
      position: 103
      prefix: --include-ssm-names
  - id: min_ssms
    type:
      - 'null'
      - float
    doc: Minimum number or percent of SSMs to retain a subclone
    inputBinding:
      position: 103
      prefix: --min-ssms
outputs:
  - id: tree_summary_output_file
    type: File
    doc: Output file for JSON-formatted tree summaries
    outputBinding:
      glob: $(inputs.tree_summary_output)
  - id: mutlist_output_file
    type: File
    doc: Output file for JSON-formatted list of mutations
    outputBinding:
      glob: $(inputs.mutlist_output)
  - id: mutass_output_file
    type: File
    doc: "Output file for JSON-formatted list of SSMs and CNVs\n                 \
      \      assigned to each subclone"
    outputBinding:
      glob: $(inputs.mutass_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylowgs:20181105--py27ha7db03b_3
