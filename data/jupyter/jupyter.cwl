cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter
label: jupyter
doc: "Jupyter interactive computing environment. Note: The provided text appears to
  be a container runtime error log rather than a help menu, so no specific arguments
  could be extracted.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter.out
