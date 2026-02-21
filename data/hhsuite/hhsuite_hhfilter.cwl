cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhfilter
label: hhsuite_hhfilter
doc: "The provided text is an error log indicating a failure to run the tool due to
  storage issues ('no space left on device'). No help text was available to parse.
  Below is a placeholder structure based on the tool name hint.\n\nTool homepage:
  https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_hhfilter.out
