cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgp-processcuration_split_agp
label: vgp-processcuration_split_agp
doc: "A tool from the vgp-processcuration suite. Note: The provided text contains
  container execution logs and error messages rather than the tool's help documentation,
  so specific arguments could not be extracted.\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_split_agp.out
