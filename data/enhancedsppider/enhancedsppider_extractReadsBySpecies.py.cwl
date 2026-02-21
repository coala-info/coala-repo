cwlVersion: v1.2
class: CommandLineTool
baseCommand: enhancedsppider_extractReadsBySpecies.py
label: enhancedsppider_extractReadsBySpecies.py
doc: "Extract reads by species (Note: The provided help text contains only container
  execution errors and does not list command-line arguments).\n\nTool homepage: https://github.com/JohnnyChen1113/EnhancedSppIDer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhancedsppider:0.2.2--pyhdfd78af_0
stdout: enhancedsppider_extractReadsBySpecies.py.out
