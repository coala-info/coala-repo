cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - unxcounts
label: dnmtools_unxcounts
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Apptainer/Singularity)
  failing to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_unxcounts.out
