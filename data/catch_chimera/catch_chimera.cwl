cwlVersion: v1.2
class: CommandLineTool
baseCommand: catch_chimera
label: catch_chimera
doc: "The provided text does not contain help information or documentation for the
  tool. It is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://science.sckcen.be/en/Institutes/EHS/MCB/MIC/Bioinformatics/CATCh"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
stdout: catch_chimera.out
