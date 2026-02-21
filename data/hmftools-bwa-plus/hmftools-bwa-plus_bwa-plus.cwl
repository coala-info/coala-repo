cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa-plus
label: hmftools-bwa-plus_bwa-plus
doc: "The provided text is a container runtime error log (Apptainer/Singularity) and
  does not contain help documentation or argument definitions for the tool.\n\nTool
  homepage: https://github.com/hartwigmedical/bwa-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
stdout: hmftools-bwa-plus_bwa-plus.out
