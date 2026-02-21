cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsc27093
label: fastsimcoal2_fsc27093
doc: "Fastsimcoal2 is a coalescent-based genetic simulator. (Note: The provided text
  contains system error messages regarding container image extraction and does not
  include the tool's help documentation or argument list).\n\nTool homepage: http://cmpg.unibe.ch/software/fastsimcoal27/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastsimcoal2:27093--hdfd78af_0
stdout: fastsimcoal2_fsc27093.out
