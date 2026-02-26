cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask
label: flask-bootstrap_flask
doc: "The Flask command line interface.\n\nTool homepage: https://github.com/cookiecutter-flask/cookiecutter-flask"
inputs:
  - id: app
    type:
      - 'null'
      - string
    doc: Specify the Flask application bundle. Can be a "module:variable" or a 
      "package:module:variable".
    inputBinding:
      position: 101
      prefix: --app
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable or disable debug mode.
    inputBinding:
      position: 101
      prefix: --debug
  - id: env
    type:
      - 'null'
      - string
    doc: Set environment variables for the application.
    inputBinding:
      position: 101
      prefix: --env
  - id: extra_files
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra files to watch for changes.
    inputBinding:
      position: 101
      prefix: --extra-files
  - id: import
    type:
      - 'null'
      - string
    doc: Import a Python module or package.
    inputBinding:
      position: 101
      prefix: --import
  - id: instance_path
    type:
      - 'null'
      - string
    doc: Specify the path to the instance folder.
    inputBinding:
      position: 101
      prefix: --instance-path
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable colored output.
    inputBinding:
      position: 101
      prefix: --no-color
  - id: reload
    type:
      - 'null'
      - boolean
    doc: Enable or disable auto-reloading.
    inputBinding:
      position: 101
      prefix: --reload
  - id: reload_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directory to watch for changes.
    inputBinding:
      position: 101
      prefix: --reload-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-bootstrap:3.3.5.7--py36_0
stdout: flask-bootstrap_flask.out
