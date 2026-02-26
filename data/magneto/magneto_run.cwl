cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - magneto
  - run
label: magneto_run
doc: "Run the magneto workflow\n\nTool homepage: https://gitlab.univ-nantes.fr/bird_pipeline_registry/magneto"
inputs:
  - id: workflow
    type: string
    doc: Path to the workflow configuration file
    inputBinding:
      position: 1
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge results from multiple runs
    inputBinding:
      position: 102
      prefix: --merge
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Skip quality control steps
    inputBinding:
      position: 102
      prefix: --skip-qc
  - id: wd
    type:
      - 'null'
      - Directory
    doc: Working directory for the workflow
    default: .
    inputBinding:
      position: 102
      prefix: --wd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magneto:1.5.1--pyhdfd78af_0
stdout: magneto_run.out
