cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - metagene
label: dnmtools_metagene
doc: "The provided text does not contain help information for dnmtools_metagene; it
  contains container runtime error messages indicating a failure to pull or build
  the image due to lack of disk space.\n\nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_metagene.out
