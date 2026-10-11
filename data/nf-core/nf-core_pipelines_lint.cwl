cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-core, pipelines, lint]
label: nf-core_pipelines_lint
doc: "Check pipeline code against nf-core guidelines.\n\nTool homepage: https://nf-co.re/"
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
    doc: Pipeline directory (copied into the work directory as 'pipeline')
  - id: release
    type: ['null', boolean]
    doc: Execute additional checks for release-ready workflows.
    inputBinding:
      position: 1
      prefix: --release
  - id: fix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --fix
    doc: Attempt to automatically fix the specified lint test (repeatable)
    inputBinding:
      position: 1
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
  - id: show_passed
    type: ['null', boolean]
    doc: Show passing tests on the command line
    inputBinding:
      position: 1
      prefix: --show-passed
  - id: fail_ignored
    type: ['null', boolean]
    doc: Convert ignored tests to failures
    inputBinding:
      position: 1
      prefix: --fail-ignored
  - id: fail_warned
    type: ['null', boolean]
    doc: Convert warn tests to failures
    inputBinding:
      position: 1
      prefix: --fail-warned
  - id: markdown
    type: ['null', string]
    doc: File to write linting results to (Markdown)
    inputBinding:
      position: 1
      prefix: --markdown
  - id: json
    type: ['null', string]
    doc: File to write linting results to (JSON)
    inputBinding:
      position: 1
      prefix: --json
  - id: sort_by
    type: ['null', string]
    doc: "Sort lint output by module or test name: module or test (default: test)"
    inputBinding:
      position: 1
      prefix: --sort-by
  - id: plain_text
    type: ['null', boolean]
    doc: Print results in plain text format without Rich formatting
    inputBinding:
      position: 1
      prefix: --plain-text
arguments:
  - position: 0
    prefix: --dir
    valueFrom: pipeline
outputs:
  - id: lint_report
    type: stdout
    doc: Lint results printed by nf-core
  - id: markdown_report
    type: ['null', File]
    outputBinding:
      glob: $(inputs.markdown)
  - id: json_report
    type: ['null', File]
    outputBinding:
      glob: $(inputs.json)
  - id: log
    type: stderr
    doc: Log messages printed by nf-core
stdout: nf-core_pipelines_lint.out
stderr: nf-core_pipelines_lint.err
successCodes: [0, 1]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
