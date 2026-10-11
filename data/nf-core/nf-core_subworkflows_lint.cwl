cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-core, subworkflows, lint]
label: nf-core_subworkflows_lint
doc: "Lint one or more subworkflows in a directory.\n\nTool homepage: https://nf-co.re/"
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
    doc: Pipeline or modules directory (copied into the work directory as 'pipeline')
  - id: registry
    type: ['null', string]
    doc: Registry to use for containers
    inputBinding:
      position: 1
      prefix: --registry
  - id: key
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --key
    doc: Run only these lint tests (repeatable)
    inputBinding:
      position: 1
  - id: all
    type: ['null', boolean]
    doc: Run on all subworkflows
    inputBinding:
      position: 1
      prefix: --all
  - id: fail_warned
    type: ['null', boolean]
    doc: Convert warn tests to failures
    inputBinding:
      position: 1
      prefix: --fail-warned
  - id: local
    type: ['null', boolean]
    doc: Run additional lint tests for local subworkflows
    inputBinding:
      position: 1
      prefix: --local
  - id: passed
    type: ['null', boolean]
    doc: Show passed tests
    inputBinding:
      position: 1
      prefix: --passed
  - id: sort_by
    type: ['null', string]
    doc: "Sort lint output by subworkflow or test name: subworkflow or test (default: test)"
    inputBinding:
      position: 1
      prefix: --sort-by
  - id: fix
    type: ['null', boolean]
    doc: Fix all linting tests if possible
    inputBinding:
      position: 1
      prefix: --fix
  - id: plain_text
    type: ['null', boolean]
    doc: Print results in plain text format without Rich formatting
    inputBinding:
      position: 1
      prefix: --plain-text
  - id: subworkflow_name
    type: ['null', string]
    doc: Subworkflow name to lint (omit with --all)
    inputBinding:
      position: 3
arguments:
  - position: 0
    prefix: --dir
    valueFrom: pipeline
outputs:
  - id: lint_report
    type: stdout
    doc: Lint results printed by nf-core
  - id: log
    type: stderr
    doc: Log messages printed by nf-core
stdout: nf-core_subworkflows_lint.out
stderr: nf-core_subworkflows_lint.err
successCodes: [0, 1]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
