cwlVersion: v1.2
class: CommandLineTool
baseCommand: strvctvre
label: strvctvre
doc: "Structural variant classification tool (Note: The provided text appears to be
  a container execution error log rather than help text, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/andrewSharo/StrVCTVRE/tree/master"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strvctvre:1.10--pyh7e72e81_0
stdout: strvctvre.out
