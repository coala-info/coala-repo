cwlVersion: v1.2
class: CommandLineTool
baseCommand: womtool
label: womtool_womtool.jar
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Singularity/Apptainer)
  failing to fetch or build the tool's image.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_womtool.jar.out
