cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plannotate
  - yaml
label: plannotate_yaml
doc: "Prints YAML file to stdout for custom database modification.\n\nTool homepage:
  https://github.com/mmcguffi/pLannotate"
inputs: []
outputs:
  - id: yaml_template
    type: stdout
    doc: YAML template describing the built-in databases, for use with plannotate batch --yaml_file
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
stdout: plannotate_yaml.yaml
