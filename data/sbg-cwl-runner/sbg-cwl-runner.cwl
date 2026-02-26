cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbg-cwl-runner
label: sbg-cwl-runner
doc: "CWL E Coyote: A CWL Runner for the Seven Bridges Genomics cloud platform\n\n\
  Tool homepage: https://github.com/kaushik-work/sbg-cwl-runner"
inputs:
  - id: workflow
    type: string
    doc: CWL Workflow file
    inputBinding:
      position: 1
  - id: job
    type:
      - 'null'
      - string
    doc: CWL Job file
    inputBinding:
      position: 2
  - id: api_profile
    type:
      - 'null'
      - string
    doc: API profile name
    default: default
    inputBinding:
      position: 103
      prefix: --api-profile
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to put results in
    default: ./
    inputBinding:
      position: 103
      prefix: --outdir
  - id: poll_interval
    type:
      - 'null'
      - int
    doc: Polling interval to check for job status (in min)
    default: 1
    inputBinding:
      position: 103
      prefix: --poll-interval
  - id: project
    type:
      - 'null'
      - string
    doc: Project to run tasks in
    default: default-sbg-cwl-runner-project
    inputBinding:
      position: 103
      prefix: --project
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbg-cwl-runner:2018.11--py_0
stdout: sbg-cwl-runner.out
