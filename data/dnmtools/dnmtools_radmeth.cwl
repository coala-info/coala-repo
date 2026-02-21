cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - radmeth
label: dnmtools_radmeth
doc: "The provided text does not contain help information for dnmtools radmeth; it
  contains a container runtime error (Singularity/Apptainer) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_radmeth.out
