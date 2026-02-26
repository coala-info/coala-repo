cwlVersion: v1.2
class: CommandLineTool
baseCommand: nglview
label: nglview
doc: "NGLView: An IPython/Jupyter widget to interactively view molecular structures
  and trajectories.\n\nTool homepage: https://github.com/arose/nglview"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: command could be a topology filename (.pdb, .mol2, .parm7, ...) or 
      could be a python script (.py), a notebook (.ipynb). If not given, a 
      notebook will be created with only nglview imported
    inputBinding:
      position: 1
  - id: traj
    type:
      - 'null'
      - string
    doc: coordinate filename, optional
    inputBinding:
      position: 2
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Run 1st cell right after openning notebook
    inputBinding:
      position: 103
      prefix: --auto
  - id: browser
    type:
      - 'null'
      - string
    doc: web browser
    inputBinding:
      position: 103
      prefix: --browser
  - id: clean
    type:
      - 'null'
      - boolean
    doc: delete temp file after closing notebook
    inputBinding:
      position: 103
      prefix: --clean
  - id: crd
    type:
      - 'null'
      - string
    doc: coordinate filename
    inputBinding:
      position: 103
      prefix: --crd
  - id: jexe
    type:
      - 'null'
      - string
    doc: jupyter path
    inputBinding:
      position: 103
      prefix: --jexe
  - id: notebook_name
    type:
      - 'null'
      - string
    doc: notebook name
    inputBinding:
      position: 103
      prefix: --notebook-name
  - id: port
    type:
      - 'null'
      - int
    doc: port number
    inputBinding:
      position: 103
      prefix: --port
  - id: remote
    type:
      - 'null'
      - boolean
    doc: create remote notebook
    inputBinding:
      position: 103
      prefix: --remote
  - id: symlink
    type:
      - 'null'
      - boolean
    doc: Create symlink for nglview-js-widgets (developer mode)
    inputBinding:
      position: 103
      prefix: --symlink
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nglview:1.1.7--py_0
stdout: nglview.out
