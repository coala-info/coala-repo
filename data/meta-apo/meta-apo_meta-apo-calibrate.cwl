cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meta-apo-calibrate
label: meta-apo_meta-apo-calibrate
doc: "A tool within the meta-apo suite (metagenomic assembly-based phylogenomic analysis).
  Note: The provided help text contains only container runtime error messages and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/qibebt-bioinfo/meta-apo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9948957_7
stdout: meta-apo_meta-apo-calibrate.out
