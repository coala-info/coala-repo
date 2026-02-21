cwlVersion: v1.2
class: CommandLineTool
baseCommand: isatab2json
label: isatab2json
doc: "A tool to convert ISA-Tab metadata files into JSON format.\n\nTool homepage:
  https://github.com/bio-agents/isatab2json_docker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab2json:phenomenal-v0.10.0_cv0.6.1.69
stdout: isatab2json.out
