cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyseer
label: pyseer
doc: "The provided text does not contain help information or usage instructions for
  pyseer. It appears to be a fatal error log from a container execution environment
  (Singularity/Apptainer) failing to pull or build the pyseer image.\n\nTool homepage:
  https://github.com/mgalardini/pyseer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer.out
