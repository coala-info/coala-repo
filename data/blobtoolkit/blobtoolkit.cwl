cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtoolkit
label: blobtoolkit
doc: "BlobToolKit is a software suite for genome assembly quality control and contamination
  detection. (Note: The provided text is an error log and does not contain usage information
  or argument definitions.)\n\nTool homepage: https://github.com/blobtoolkit/blobtoolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtoolkit:4.5.0--pyhdfd78af_0
stdout: blobtoolkit.out
