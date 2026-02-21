cwlVersion: v1.2
class: CommandLineTool
baseCommand: devider_run_devider_pipeline
label: devider_run_devider_pipeline
doc: "A pipeline tool for devider (Note: The provided text contains error logs rather
  than help documentation, so specific arguments could not be extracted).\n\nTool
  homepage: https://github.com/bluenote-1577/devider"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/devider:0.0.1--ha6fb395_3
stdout: devider_run_devider_pipeline.out
