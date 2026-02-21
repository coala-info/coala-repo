cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyomo_build
label: pyomo_build
doc: "A tool for converting OCI/Docker images to SIF (Singularity Image Format). Note:
  The provided text appears to be log output from a failed execution rather than standard
  help text, so no specific command-line arguments could be identified.\n\nTool homepage:
  https://github.com/Pyomo/pyomo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyomo:4.1.10527--py34_0
stdout: pyomo_build.out
