cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meta-apo-train
label: meta-apo_meta-apo-train
doc: "Training tool for Meta-APO (Metagenomic Assembly Polishing and Optimization).
  Note: The provided help text contains only system error logs and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/qibebt-bioinfo/meta-apo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9948957_7
stdout: meta-apo_meta-apo-train.out
