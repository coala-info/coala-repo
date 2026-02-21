cwlVersion: v1.2
class: CommandLineTool
baseCommand: matam_matam_compare_samples.py
label: matam_matam_compare_samples.py
doc: "A tool for comparing samples within the MATAM (Mapping and Assembly Tool for
  Archaeal and Bacterial 16S rRNA Genes) pipeline. Note: The provided help text contains
  system error messages regarding container execution and does not list specific arguments.\n
  \nTool homepage: https://github.com/bonsai-team/matam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
stdout: matam_matam_compare_samples.py.out
