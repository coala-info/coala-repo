cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-core, subworkflows, create]
label: nf-core_subworkflows_create
doc: "Create a new subworkflow from the nf-core template inside a pipeline directory.\n\nTool homepage: https://nf-co.re/"
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
    doc: Subworkflow author's GitHub username prefixed with '@'
    inputBinding:
      position: 1
      prefix: --author
  - id: force
    type: ['null', boolean]
    doc: Overwrite any files if they already exist
    inputBinding:
      position: 1
      prefix: --force
  - id: migrate_pytest
    type: ['null', boolean]
    doc: Migrate a module with pytest tests to nf-test
    inputBinding:
      position: 1
      prefix: --migrate-pytest
  - id: subworkflow_name
    type: string
    doc: Name of the subworkflow (lower-case letters only)
    inputBinding:
      position: 3
arguments:
  - position: 0
    prefix: --dir
    valueFrom: pipeline
outputs:
  - id: pipeline_dir_out
    type: Directory
    doc: The pipeline directory with the new subworkflow added
    outputBinding:
      glob: pipeline
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Log messages printed by nf-core
stdout: nf-core_subworkflows_create.out
stderr: nf-core_subworkflows_create.err
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
