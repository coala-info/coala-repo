cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgp-processcuration
  - gfastats
label: vgp-processcuration_gfastats
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container execution/build process.\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_gfastats.out
