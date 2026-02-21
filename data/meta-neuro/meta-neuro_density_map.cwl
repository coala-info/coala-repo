cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-neuro_density_map
label: meta-neuro_density_map
doc: "A tool from the meta-neuro package (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/bagari/meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
stdout: meta-neuro_density_map.out
