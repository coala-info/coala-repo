cwlVersion: v1.2
class: CommandLineTool
baseCommand: flowcraft build
label: flowcraft_build
doc: "Build a pipeline using flowcraft.\n\nTool homepage: https://github.com/assemblerflow/flowcraft"
inputs:
  - id: check_pipeline
    type:
      - 'null'
      - boolean
    doc: Check only the validity of the pipeline string and exit.
    inputBinding:
      position: 101
      prefix: --check-pipeline
  - id: check_recipe
    type:
      - 'null'
      - boolean
    doc: Check tasks that the recipe contain and their flow. This option might 
      be useful if a user wants to change some components of a given recipe, by 
      using the -t option.
    inputBinding:
      position: 101
      prefix: --check-recipe
  - id: component_list
    type:
      - 'null'
      - boolean
    doc: Print a detailed description for all the currently available processes.
    inputBinding:
      position: 101
      prefix: --component-list
  - id: component_list_short
    type:
      - 'null'
      - boolean
    doc: Print a short list of the currently available processes.
    inputBinding:
      position: 101
      prefix: --component-list-short
  - id: export_directives
    type:
      - 'null'
      - boolean
    doc: Only export the directives for the provided components (via -t option) 
      in JSON format to stdout. No pipeline will be generated with this option.
    inputBinding:
      position: 101
      prefix: --export-directives
  - id: export_params
    type:
      - 'null'
      - boolean
    doc: Only export the parameters for the provided components (via -t option) 
      in JSON format to stdout. No pipeline will be generated with this option.
    inputBinding:
      position: 101
      prefix: --export-params
  - id: fetch_tags
    type:
      - 'null'
      - boolean
    doc: Allows to fetch all docker tags for the components listed with the -t 
      flag.
    inputBinding:
      position: 101
      prefix: --fetch-tags
  - id: merge_params
    type:
      - 'null'
      - boolean
    doc: Merges identical parameters from multiple components into the same one.
      Otherwise, the parameters will be separated and unique to each component.
    inputBinding:
      position: 101
      prefix: --merge-params
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
      - File
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
  - id: recipe_list
    type:
      - 'null'
      - boolean
    doc: Print a short list of the currently available recipes.
    inputBinding:
      position: 101
      prefix: --recipe-list
  - id: recipe_list_short
    type:
      - 'null'
      - boolean
    doc: Print a condensed list of the currently available recipes
    inputBinding:
      position: 101
      prefix: --recipe-list-short
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
    dockerPull: quay.io/biocontainers/flowcraft:1.4.1--py_1
stdout: flowcraft_build.out
