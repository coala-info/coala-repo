cwlVersion: v1.2
class: CommandLineTool
baseCommand: catch
label: catch
doc: "Compact Aggregation of Targets for Comprehensive Hybridization (CATCH)\n\nTool
  homepage: https://github.com/broadinstitute/catch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
stdout: catch.out
