cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagene
label: plastid_metagene
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract the container image due to lack
  of disk space ('no space left on device'). As a result, no arguments or tool descriptions
  could be extracted from the input.\n\nTool homepage: http://plastid.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
stdout: plastid_metagene.out
