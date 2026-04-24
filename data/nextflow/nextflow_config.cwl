cwlVersion: v1.2
class: CommandLineTool
baseCommand: config
label: nextflow_config
doc: "Print a project configuration\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name
    type: string
    doc: project name
    inputBinding:
      position: 1
  - id: flat
    type:
      - 'null'
      - boolean
    doc: 'Print config using flat notation (deprecated: use `-o flat` instead)'
    inputBinding:
      position: 102
      prefix: -flat
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Print the config using the specified format: canonical,properties,flat,json,yaml'
    inputBinding:
      position: 102
      prefix: -output
  - id: profile
    type:
      - 'null'
      - string
    doc: Choose a configuration profile
    inputBinding:
      position: 102
      prefix: -profile
  - id: properties
    type:
      - 'null'
      - boolean
    doc: 'Prints config using Java properties notation (deprecated: use `-o properties`
      instead)'
    inputBinding:
      position: 102
      prefix: -properties
  - id: show_profiles
    type:
      - 'null'
      - boolean
    doc: Show all configuration profiles
    inputBinding:
      position: 102
      prefix: -show-profiles
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort config attributes
    inputBinding:
      position: 102
      prefix: -sort
  - id: value
    type:
      - 'null'
      - boolean
    doc: Print the value of a config option, or fail if the option is not 
      defined
    inputBinding:
      position: 102
      prefix: -value
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_config.out
