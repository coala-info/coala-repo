cwlVersion: v1.2
class: CommandLineTool
baseCommand: sierrapy
label: sierrapy
doc: "SierraPy is a Python client for the Stanford HIV Drug Resistance Database (HIVDB)
  Sierra GraphQL API.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
stdout: sierrapy.out
