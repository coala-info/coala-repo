cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterfunk
label: clusterfunk_csv
doc: "A tool for tree manipulation and annotation\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (e.g., phylotype, annotate_tips, prune, 
      graft, etc.)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
stdout: clusterfunk_csv.out
