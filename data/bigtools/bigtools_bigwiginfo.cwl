cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigtools
  - bigwiginfo
label: bigtools_bigwiginfo
doc: "The provided text does not contain help information for bigtools_bigwiginfo.
  It contains a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bigwiginfo.out
