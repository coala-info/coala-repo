cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgp-processcuration_sak_generation
label: vgp-processcuration_sak_generation
doc: "VGP process curation SAK generation tool. (Note: The provided help text appears
  to be a container execution error log and does not contain usage information or
  argument definitions.)\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_sak_generation.out
