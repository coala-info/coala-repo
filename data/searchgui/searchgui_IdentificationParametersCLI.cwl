cwlVersion: v1.2
class: CommandLineTool
baseCommand: searchgui_IdentificationParametersCLI
label: searchgui_IdentificationParametersCLI
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build a Singularity/Apptainer container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/CompOmics/searchgui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_IdentificationParametersCLI.out
