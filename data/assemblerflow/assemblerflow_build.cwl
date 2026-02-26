cwlVersion: v1.2
class: CommandLineTool
baseCommand: assemblerflow_build
label: assemblerflow_build
doc: "Build a pipeline for assemblerflow.\n\nTool homepage: https://github.com/ODiogoSilva/assemblerflow"
inputs:
  - id: check_pipeline
    type:
      - 'null'
      - boolean
    doc: Check only the validity of the pipeline string and exit.
    inputBinding:
      position: 101
      prefix: --check-pipeline
  - id: detailed_list
    type:
      - 'null'
      - boolean
    doc: Print a detailed description for all the currently available processes
    inputBinding:
      position: 101
      prefix: --detailed-list
  - id: no_dependecy
    type:
      - 'null'
      - boolean
    doc: Do not automatically add dependencies to the pipeline.
    inputBinding:
      position: 101
      prefix: --no-dependecy
  - id: output_nf
    type:
      - 'null'
      - string
    doc: Name of the pipeline file
    inputBinding:
      position: 101
      prefix: -o
  - id: pipeline_name
    type:
      - 'null'
      - string
    doc: Provide a name for your pipeline.
    inputBinding:
      position: 101
      prefix: --pipeline-name
  - id: pipeline_only
    type:
      - 'null'
      - boolean
    doc: Write only the pipeline files and not the templates, bin, and lib 
      folders.
    inputBinding:
      position: 101
      prefix: --pipeline-only
  - id: recipe
    type:
      - 'null'
      - string
    doc: Use one of the available recipes
    inputBinding:
      position: 101
      prefix: --recipe
  - id: short_list
    type:
      - 'null'
      - boolean
    doc: Print a short list of the currently available processes
    inputBinding:
      position: 101
      prefix: --short-list
  - id: tasks
    type:
      - 'null'
      - string
    doc: Space separated tasks of the pipeline
    inputBinding:
      position: 101
      prefix: --tasks
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblerflow:1.1.0.post3--py35_1
stdout: assemblerflow_build.out
