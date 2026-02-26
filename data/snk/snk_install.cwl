cwlVersion: v1.2
class: CommandLineTool
baseCommand: snk install
label: snk_install
doc: "Install a workflow.\n\nTool homepage: https://snk.wytamma.com"
inputs:
  - id: workflow
    type: string
    doc: Path, URL or Github name (user/repo) of the workflow to install.
    inputBinding:
      position: 1
  - id: commit
    type:
      - 'null'
      - string
    doc: Commit (SHA) of the workflow to install. If None the latest commit will
      be installed.
    inputBinding:
      position: 102
      prefix: --commit
  - id: config
    type:
      - 'null'
      - File
    doc: Specify a non-standard config location.
    inputBinding:
      position: 102
      prefix: --config
  - id: dependency
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional pip dependencies to install with the workflow.
    inputBinding:
      position: 102
      prefix: --dependency
  - id: editable
    type:
      - 'null'
      - boolean
    doc: Whether to install the workflow in editable mode.
    inputBinding:
      position: 102
      prefix: --editable
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force install (overwrites existing installs).
    inputBinding:
      position: 102
      prefix: --force
  - id: isolate
    type:
      - 'null'
      - boolean
    doc: Install the workflow in a isolated environment.
    inputBinding:
      position: 102
      prefix: --isolate
  - id: name
    type:
      - 'null'
      - string
    doc: Rename the workflow (this name will be used to call the CLI.)
    inputBinding:
      position: 102
      prefix: --name
  - id: no_conda
    type:
      - 'null'
      - boolean
    doc: Do not use conda environments by default.
    inputBinding:
      position: 102
      prefix: --no-conda
  - id: resource
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify resources additional to the resources folder required by the 
      workflow (copied to working dir at runtime).
    inputBinding:
      position: 102
      prefix: --resource
  - id: snakefile
    type:
      - 'null'
      - File
    doc: Specify a non-standard Snakefile location.
    inputBinding:
      position: 102
      prefix: --snakefile
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Snakemake version to install with the isolated workflow. Default is the
      latest version.
    inputBinding:
      position: 102
      prefix: --snakemake
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag (version) of the workflow to install. Can specify a branch name, or
      tag. If None the latest commit will be installed.
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk_install.out
