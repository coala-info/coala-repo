cwlVersion: v1.2
class: CommandLineTool
baseCommand: plastimatch
label: plastimatch
doc: "The provided text is an error log indicating a failure to build or extract the
  container image (no space left on device) and does not contain the help text or
  usage information for the tool.\n\nTool homepage: https://github.com/ImagingDataCommons/pyplastimatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plastimatch:v1.7.4dfsg.1-2-deb_cv1
stdout: plastimatch.out
