cwlVersion: v1.2
class: CommandLineTool
baseCommand: feature_merge
label: feature_merge
doc: "A tool for merging features (Note: The provided text is an error log and does
  not contain usage instructions or argument definitions).\n\nTool homepage: https://github.com/brinkmanlab/feature_merge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feature_merge:1.3.0--pyh3252c3a_0
stdout: feature_merge.out
