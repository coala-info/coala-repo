cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - inspect
label: apptainer_inspect
doc: "Show metadata for an image. Inspect will show you labels, environment variables,
  apps and scripts associated with the image determined by the flags you pass.\n\n
  Tool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image_path
    type: File
    doc: Path to the Apptainer image
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: show all available data (imply --json option)
    inputBinding:
      position: 102
      prefix: --all
  - id: app
    type:
      - 'null'
      - string
    doc: inspect a specific app
    inputBinding:
      position: 102
      prefix: --app
  - id: deffile
    type:
      - 'null'
      - boolean
    doc: show the Apptainer definition file that was used to generate the image
    inputBinding:
      position: 102
      prefix: --deffile
  - id: environment
    type:
      - 'null'
      - boolean
    doc: show the environment settings for the image
    inputBinding:
      position: 102
      prefix: --environment
  - id: helpfile
    type:
      - 'null'
      - boolean
    doc: inspect the runscript helpfile, if it exists
    inputBinding:
      position: 102
      prefix: --helpfile
  - id: json
    type:
      - 'null'
      - boolean
    doc: print structured json instead of sections
    inputBinding:
      position: 102
      prefix: --json
  - id: labels
    type:
      - 'null'
      - boolean
    doc: show the labels for the image (default)
    inputBinding:
      position: 102
      prefix: --labels
  - id: list_apps
    type:
      - 'null'
      - boolean
    doc: list all apps in a container
    inputBinding:
      position: 102
      prefix: --list-apps
  - id: runscript
    type:
      - 'null'
      - boolean
    doc: show the runscript for the image
    inputBinding:
      position: 102
      prefix: --runscript
  - id: startscript
    type:
      - 'null'
      - boolean
    doc: show the startscript for the image
    inputBinding:
      position: 102
      prefix: --startscript
  - id: test
    type:
      - 'null'
      - boolean
    doc: show the test script for the image
    inputBinding:
      position: 102
      prefix: --test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_inspect.out
