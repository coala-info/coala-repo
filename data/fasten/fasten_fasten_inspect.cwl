cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasten
  - inspect
label: fasten_fasten_inspect
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to build the image
  due to lack of disk space. No arguments or tool descriptions could be extracted
  from the input.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_inspect.out
