cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-neuro_volumetric_profile
label: meta-neuro_volumetric_profile
doc: "A tool for neuro volumetric profiling. (Note: The provided help text contains
  container runtime error messages and does not list available command-line arguments.)\n
  \nTool homepage: https://github.com/bagari/meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
stdout: meta-neuro_volumetric_profile.out
