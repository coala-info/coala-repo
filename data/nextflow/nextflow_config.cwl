cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, config]
label: nextflow_config
doc: "Print a project configuration.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_dir
    type: Directory
    doc: "Project directory with the pipeline script and nextflow.config. It is staged in the working directory."
    inputBinding:
      position: 9
      valueFrom: $(self.basename)
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Print the config using the specified format: canonical, properties, flat, json, yaml."
    inputBinding:
      position: 1
      prefix: -output
  - id: profile
    type:
      - 'null'
      - string
    doc: "Choose a configuration profile."
    inputBinding:
      position: 2
      prefix: -profile
  - id: show_profiles
    type:
      - 'null'
      - boolean
    doc: "Show all configuration profiles."
    inputBinding:
      position: 3
      prefix: -show-profiles
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "Sort config attributes."
    inputBinding:
      position: 4
      prefix: -sort
  - id: value
    type:
      - 'null'
      - string
    doc: "Print the value of a config option, or fail if the option is not defined."
    inputBinding:
      position: 5
      prefix: -value
  - id: flat
    type:
      - 'null'
      - boolean
    doc: "Print config using flat notation (deprecated, use output_format flat)."
    inputBinding:
      position: 6
      prefix: -flat
  - id: properties
    type:
      - 'null'
      - boolean
    doc: "Print config using Java properties notation (deprecated, use output_format properties)."
    inputBinding:
      position: 7
      prefix: -properties
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.project_dir.basename)
        entry: $(inputs.project_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_config.out
