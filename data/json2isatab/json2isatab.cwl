cwlVersion: v1.2
class: CommandLineTool
baseCommand: json2isatab
label: json2isatab
doc: "A tool to convert JSON files to ISA-Tab format. (Note: The provided help text
  contains only system error messages and no usage information; arguments could not
  be extracted from the source text).\n\nTool homepage: https://github.com/bio-agents/json2isatab_docker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/json2isatab:phenomenal-v0.9.4_cv0.5.39
stdout: json2isatab.out
