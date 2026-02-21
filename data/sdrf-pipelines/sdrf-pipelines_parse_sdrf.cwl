cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sdrf-pipelines
  - parse_sdrf
label: sdrf-pipelines_parse_sdrf
doc: "A tool for parsing SDRF (Sample Description Registry Format) files within the
  sdrf-pipelines suite.\n\nTool homepage: https://github.com/bigbio/sdrf-pipelines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdrf-pipelines:0.0.33--pyhdfd78af_0
stdout: sdrf-pipelines_parse_sdrf.out
