cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccne-fast
label: ccne_ccne-fast
doc: "The provided text does not contain help information for the tool, but appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build or extract the image due to lack of disk space.\n\nTool homepage:
  https://github.com/biojiang/ccne"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
stdout: ccne_ccne-fast.out
