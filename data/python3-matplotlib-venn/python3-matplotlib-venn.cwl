cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-matplotlib-venn
label: python3-matplotlib-venn
doc: 'A Python library for plotting area-proportional Venn diagrams. Note: The provided
  text contains container build logs and error messages rather than CLI help documentation.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-matplotlib-venn:v0.11.5-1-deb_cv1
stdout: python3-matplotlib-venn.out
