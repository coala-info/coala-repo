cwlVersion: v1.2
class: CommandLineTool
baseCommand: auspice develop
label: auspice_develop
doc: "Launch auspice in development mode. This runs a local server and uses \nhot-reloading
  to allow automatic updating as you edit the code. NOTE: there \nis a speed penalty
  for this ability and this should never be used for \nproduction.\n\nTool homepage:
  https://docs.nextstrain.org/projects/auspice/"
inputs:
  - id: dataset_dir
    type:
      - 'null'
      - Directory
    doc: "Directory where datasets (JSONs) are sourced. This is \nignored if you define
      custom handlers."
    inputBinding:
      position: 101
      prefix: --datasetDir
  - id: extend
    type:
      - 'null'
      - string
    doc: "Client customisations to be applied. See documentation \nfor more details.
      Note that hot reloading does not \ncurrently work for these customisations."
    inputBinding:
      position: 101
      prefix: --extend
  - id: handlers
    type:
      - 'null'
      - string
    doc: "Overwrite the provided server handlers for client \nrequests. See documentation
      for more details."
    inputBinding:
      position: 101
      prefix: --handlers
  - id: include_timing
    type:
      - 'null'
      - boolean
    doc: "Do not strip timing functions. With these included the \nbrowser console
      will print timing measurements for a \nnumber of functions."
    inputBinding:
      position: 101
      prefix: --includeTiming
  - id: narrative_dir
    type:
      - 'null'
      - Directory
    doc: "Directory where narratives (Markdown files) are \nsourced. This is ignored
      if you define custom handlers."
    inputBinding:
      position: 101
      prefix: --narrativeDir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more verbose progress messages in the terminal.
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
stdout: auspice_develop.out
