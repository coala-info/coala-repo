cwlVersion: v1.2
class: CommandLineTool
baseCommand: manta_runWorkflow.py
label: manta_runWorkflow.py
doc: "Manta structural variant calling workflow execution script. Note: The provided
  text contains execution logs and error messages rather than help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/Illumina/manta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
stdout: manta_runWorkflow.py.out
