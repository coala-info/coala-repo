cwlVersion: v1.2
class: CommandLineTool
baseCommand: memote new
label: memote_new
doc: "Create a suitable model repository structure from a template.\n\nTool homepage:
  https://memote.readthedocs.io/"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Create a new model repository in the given directory.
    inputBinding:
      position: 101
      prefix: --directory
  - id: replay
    type:
      - 'null'
      - boolean
    doc: Create a memote repository using the exact same answers as before. This
      will not overwrite existing directories. If you want to adjust the 
      answers, edit the template 
      '/root/.cookiecutter_replay/cookiecutter-memote.json'.
    inputBinding:
      position: 101
      prefix: --replay
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
stdout: memote_new.out
