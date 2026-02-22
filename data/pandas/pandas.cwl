cwlVersion: v1.2
class: CommandLineTool
baseCommand: pandas
label: pandas
doc: "The provided text does not contain help information or usage instructions for
  the pandas tool. It consists of error messages from a container runtime (Singularity/Apptainer)
  indicating a failure to pull and build a SIF image for pandas due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/pandas-dev/pandas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandas:2.2.1
stdout: pandas.out
