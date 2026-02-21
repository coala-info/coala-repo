cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse
label: lefse
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or run the LEfSe container due to insufficient disk
  space. No help text or usage information was found in the input.\n\nTool homepage:
  https://github.com/SegataLab/lefse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
stdout: lefse.out
