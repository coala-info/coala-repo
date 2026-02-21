cwlVersion: v1.2
class: CommandLineTool
baseCommand: dragen-os
label: dragmap_dragen-os
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages regarding a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/Illumina/DRAGMAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dragmap:1.3.0--h5ca1c30_7
stdout: dragmap_dragen-os.out
