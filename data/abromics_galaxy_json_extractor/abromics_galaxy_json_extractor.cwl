cwlVersion: v1.2
class: CommandLineTool
baseCommand: abromics_galaxy_json_extractor
label: abromics_galaxy_json_extractor
doc: "A tool for extracting information from Galaxy JSON files. (Note: The provided
  help text contains only system error logs regarding a container build failure and
  does not list specific command-line arguments.)\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abromics_galaxy_json_extractor:0.8.3.6--pyh7cba7a3_0
stdout: abromics_galaxy_json_extractor.out
