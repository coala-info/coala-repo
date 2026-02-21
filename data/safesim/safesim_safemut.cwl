cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - safesim
  - safemut
label: safesim_safemut
doc: "The provided text does not contain help information for the tool; it is a container
  build error log. No arguments could be extracted.\n\nTool homepage: https://github.com/genetronhealth/safesim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
stdout: safesim_safemut.out
