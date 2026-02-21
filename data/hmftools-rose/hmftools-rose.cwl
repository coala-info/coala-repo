cwlVersion: v1.2
class: CommandLineTool
baseCommand: rose
label: hmftools-rose
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/rose/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-rose:1.3--hdfd78af_0
stdout: hmftools-rose.out
