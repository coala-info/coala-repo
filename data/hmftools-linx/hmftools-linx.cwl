cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmftools-linx
label: hmftools-linx
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/sv-linx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-linx:2.2--hdfd78af_0
stdout: hmftools-linx.out
