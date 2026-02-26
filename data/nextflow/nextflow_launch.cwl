cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow launch
label: nextflow_launch
doc: "Launch a workflow in Seqera Platform\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: pipeline
    type: string
    doc: Pipeline name
    inputBinding:
      position: 1
  - id: compute_env
    type:
      - 'null'
      - string
    doc: Compute environment name
    default: primary
    inputBinding:
      position: 102
      prefix: -compute-env
  - id: config
    type:
      - 'null'
      - File
    doc: Add the specified file to configuration set
    inputBinding:
      position: 102
      prefix: -config
  - id: custom_param
    type:
      - 'null'
      - type: array
        items: string
    doc: Set a parameter used by the pipeline
    inputBinding:
      position: 102
      prefix: --<param>=<value>
  - id: entry
    type:
      - 'null'
      - string
    doc: Entry workflow name to be executed
    inputBinding:
      position: 102
      prefix: -entry
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Pull latest changes before run
    inputBinding:
      position: 102
      prefix: -latest
  - id: main_script
    type:
      - 'null'
      - File
    doc: The script file to be executed when launching a project
    inputBinding:
      position: 102
      prefix: -main-script
  - id: name
    type:
      - 'null'
      - string
    doc: Assign a mnemonic name to the pipeline run
    inputBinding:
      position: 102
      prefix: -name
  - id: params_file
    type:
      - 'null'
      - File
    doc: Load script parameters from a JSON/YAML file
    inputBinding:
      position: 102
      prefix: -params-file
  - id: profile
    type:
      - 'null'
      - string
    doc: Choose a configuration profile
    inputBinding:
      position: 102
      prefix: -profile
  - id: resume
    type:
      - 'null'
      - string
    doc: Execute the script using the cached results
    inputBinding:
      position: 102
      prefix: -resume
  - id: revision
    type:
      - 'null'
      - string
    doc: Revision of the project to run (git branch, tag or commit SHA)
    inputBinding:
      position: 102
      prefix: -revision
  - id: stub_run
    type:
      - 'null'
      - boolean
    doc: Execute the workflow replacing process scripts with command stubs
    inputBinding:
      position: 102
      prefix: -stub
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory where intermediate result files are stored
    inputBinding:
      position: 102
      prefix: -work-dir
  - id: workspace
    type:
      - 'null'
      - string
    doc: Workspace name
    inputBinding:
      position: 102
      prefix: -workspace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_launch.out
