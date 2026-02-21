cwlVersion: v1.2
class: CommandLineTool
baseCommand: psm_fragments
label: psm_fragments
doc: "The provided text does not contain help information or usage instructions for
  psm_fragments; it contains system logs and error messages related to a container
  build process.\n\nTool homepage: https://github.com/galaxyproteomics/psm_fragments"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psm_fragments:1.0.3--py_0
stdout: psm_fragments.out
