cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - dashboard
label: nomadic_dashboard
doc: "Launch the dashboard without performing real-time analysis, used to view results
  of a previous experiment.\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
inputs:
  - id: experiment
    type: string
    doc: Can be the name of a previous experiment, located in 
      <workspace>/results/<experiment_name>, or a path to a directory containing
      the results of a previous experiment.
    inputBinding:
      position: 1
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: Path of the workspace where all input/output files (beds, metadata, 
      results) are stored. The workspace directory simplifies the use of nomadic
      in that many arguments don't need to be listed as they are predefined in 
      the workspace config or can be loaded from the workspace
    default: (current directory)
    inputBinding:
      position: 102
      prefix: --workspace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_dashboard.out
