cwlVersion: v1.2
class: CommandLineTool
baseCommand: pykofamsearch_serialize_kofam_models
label: pykofamsearch_serialize_kofam_models
doc: "Serialize KOfam models for use with pykofamsearch. (Note: The provided text
  contains container runtime logs and a fatal error rather than the tool's help documentation.)\n
  \nTool homepage: https://github.com/jolespin/pykofamsearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
stdout: pykofamsearch_serialize_kofam_models.out
