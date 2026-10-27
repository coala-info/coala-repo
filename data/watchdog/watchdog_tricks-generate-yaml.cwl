cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - watchmedo
  - tricks-generate-yaml
label: watchdog_tricks-generate-yaml
doc: "Generate Yaml configuration for tricks named on the command line.\n\nTool homepage:
  https://github.com/gorakhargosh/watchdog"
inputs:
  - id: trick_paths
    type:
      - 'null'
      - type: array
        items: string
    doc: Dotted paths for all the tricks you want to generate (for example 
      watchdog.tricks.LoggerTrick)
    inputBinding:
      position: 2
  - id: python_path
    type:
      - 'null'
      - string
    doc: paths separated by / to add to the python path (default '.')
    inputBinding:
      position: 1
      prefix: --python-path
  - id: append_only
    type:
      - 'null'
      - boolean
    doc: if --append-to-file is not specified, produces output for appending 
      instead of a complete tricks yaml file.
    inputBinding:
      position: 1
      prefix: --append-only
  - id: append_to_file
    type:
      - 'null'
      - string
    doc: appends the generated tricks YAML to a file; if not specified, prints 
      to standard output
    inputBinding:
      position: 1
      prefix: --append-to-file
outputs:
  - id: stdout
    type: stdout
    doc: Generated tricks YAML (when append_to_file is not set)
  - id: appended_file
    type:
      - 'null'
      - File
    doc: File the tricks YAML was appended to
    outputBinding:
      glob: $(inputs.append_to_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/watchdog:0.8.3--py36_0
stdout: watchdog_tricks-generate-yaml.out
