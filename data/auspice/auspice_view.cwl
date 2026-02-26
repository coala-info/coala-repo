cwlVersion: v1.2
class: CommandLineTool
baseCommand: auspice view
label: auspice_view
doc: "Launch a local server to view locally available datasets & narratives. The handlers
  for (auspice) client requests can be overridden here (see documentation for more
  details). If you want to serve a customised auspice client then you must have run
  \"auspice build\" in the same directory as you run \"auspice view\" from.\n\nTool
  homepage: https://docs.nextstrain.org/projects/auspice/"
inputs:
  - id: custom_build_only
    type:
      - 'null'
      - boolean
    doc: Error if a custom build is not found.
    inputBinding:
      position: 101
      prefix: --customBuildOnly
  - id: dataset_dir
    type:
      - 'null'
      - Directory
    doc: Directory where datasets (JSONs) are sourced. This is ignored if you 
      define custom handlers.
    inputBinding:
      position: 101
      prefix: --datasetDir
  - id: handlers
    type:
      - 'null'
      - string
    doc: Overwrite the provided server handlers for client requests. See 
      documentation for more details.
    inputBinding:
      position: 101
      prefix: --handlers
  - id: narrative_dir
    type:
      - 'null'
      - Directory
    doc: Directory where narratives (Markdown files) are sourced. This is 
      ignored if you define custom handlers.
    inputBinding:
      position: 101
      prefix: --narrativeDir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more verbose logging messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/auspice:2.66.0--h503566f_2
stdout: auspice_view.out
