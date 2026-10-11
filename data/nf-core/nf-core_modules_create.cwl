cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-core, modules, create]
label: nf-core_modules_create
doc: "Create a new DSL2 module from the nf-core template inside a pipeline directory.\n\nTool homepage: https://nf-co.re/"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: nfcore
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.pipeline_dir)
        entryname: pipeline
        writable: true
inputs:
  - id: pipeline_dir
    type: Directory
    doc: Pipeline (or modules repository) directory (copied into the work directory as 'pipeline')
  - id: author
    type: ['null', string]
    doc: Module author's GitHub username prefixed with '@'
    inputBinding:
      position: 1
      prefix: --author
  - id: label
    type: ['null', string]
    doc: Standard resource label for process
    inputBinding:
      position: 1
      prefix: --label
  - id: meta
    type: ['null', boolean]
    doc: Use Groovy meta map for sample information
    inputBinding:
      position: 1
      prefix: --meta
  - id: no_meta
    type: ['null', boolean]
    doc: Don't use meta map for sample information
    inputBinding:
      position: 1
      prefix: --no-meta
  - id: force
    type: ['null', boolean]
    doc: Overwrite any files if they already exist
    inputBinding:
      position: 1
      prefix: --force
  - id: conda_name
    type: ['null', string]
    doc: Name of the conda package to use
    inputBinding:
      position: 1
      prefix: --conda-name
  - id: conda_package_version
    type: ['null', string]
    doc: Version of conda package to use
    inputBinding:
      position: 1
      prefix: --conda-package-version
  - id: empty_template
    type: ['null', boolean]
    doc: Create a module from the template without TODOs or examples
    inputBinding:
      position: 1
      prefix: --empty-template
  - id: migrate_pytest
    type: ['null', boolean]
    doc: Migrate a module with pytest tests to nf-test
    inputBinding:
      position: 1
      prefix: --migrate-pytest
  - id: tool
    type: string
    doc: Tool or tool/subtool name (lower-case letters only)
    inputBinding:
      position: 3
arguments:
  - position: 0
    prefix: --dir
    valueFrom: pipeline
outputs:
  - id: pipeline_dir_out
    type: Directory
    doc: The pipeline directory with the new module added
    outputBinding:
      glob: pipeline
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Log messages printed by nf-core
stdout: nf-core_modules_create.out
stderr: nf-core_modules_create.err
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
