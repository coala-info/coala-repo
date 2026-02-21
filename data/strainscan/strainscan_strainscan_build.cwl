cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainscan
  - build
label: strainscan_strainscan_build
doc: "Build a database for StrainScan (Note: The provided text appears to be a container
  build log rather than tool help text, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/liaoherui/StrainScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
stdout: strainscan_strainscan_build.out
