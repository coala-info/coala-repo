cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gnali
  - get_data
label: gnali_gnali_get_data
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages. No arguments could be extracted.\n\nTool homepage:
  https://github.com/phac-nml/gnali"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnali:1.1.0--pyhdfd78af_0
stdout: gnali_gnali_get_data.out
