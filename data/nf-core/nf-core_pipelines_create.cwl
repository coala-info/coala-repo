cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-core, pipelines, create]
label: nf-core_pipelines_create
doc: "Create a new pipeline using the nf-core template (non-interactive: pass name, description and author).\n\nTool homepage: https://nf-co.re/"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: nfcore
inputs:
  - id: name
    type: string
    doc: The name of your new pipeline
    inputBinding:
      position: 1
      prefix: --name
  - id: description
    type: string
    doc: A short description of your pipeline
    inputBinding:
      position: 1
      prefix: --description
  - id: author
    type: string
    doc: Name of the main author(s)
    inputBinding:
      position: 1
      prefix: --author
  - id: version
    type: ['null', string]
    doc: The initial version number to use
    inputBinding:
      position: 1
      prefix: --version
  - id: force
    type: ['null', boolean]
    doc: Overwrite output directory if it already exists
    inputBinding:
      position: 1
      prefix: --force
  - id: outdir
    type: string
    doc: Output directory for the new pipeline
    inputBinding:
      position: 1
      prefix: --outdir
  - id: template_yaml
    type: ['null', File]
    doc: Pass a YAML file to customize the template
    inputBinding:
      position: 1
      prefix: --template-yaml
  - id: organisation
    type: ['null', string]
    doc: "The name of the GitHub organisation where the pipeline will be hosted (default: nf-core)"
    inputBinding:
      position: 1
      prefix: --organisation
outputs:
  - id: pipeline_dir
    type: Directory
    doc: The new pipeline directory
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Log messages printed by nf-core
stdout: nf-core_pipelines_create.out
stderr: nf-core_pipelines_create.err
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
