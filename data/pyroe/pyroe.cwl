cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyroe
label: pyroe
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a failed container build process for the
  pyroe image.\n\nTool homepage: https://github.com/COMBINE-lab/pyroe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
stdout: pyroe.out
