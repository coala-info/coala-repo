cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_kernelspec
label: jupyter_kernelspec
doc: "Manage Jupyter kernel specifications.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: subcommand
    type: string
    doc: "The subcommand to run. Must be one of: ['list', 'remove', 'install-self',
      'install', 'uninstall']"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_kernelspec.out
