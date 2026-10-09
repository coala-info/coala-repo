cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - memote
  - new
label: memote_new
doc: "Create a suitable model repository structure from a template.\n\nTool homepage:
  https://memote.readthedocs.io/"
inputs:
  - id: directory
    type:
      - 'null'
      - string
    doc: Create a new model repository in the given directory (the directory 
      must exist; it is created empty before the run).
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
  - id: repository
    type:
      - 'null'
      - Directory
    doc: The new model repository directory.
    outputBinding:
      glob: $(inputs.directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.directory)
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
stdout: memote_new.out
