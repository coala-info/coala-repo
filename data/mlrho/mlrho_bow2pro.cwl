cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlrho_bow2pro
label: mlrho_bow2pro
doc: "The provided text is a system error log (Singularity/Apptainer failure) and
  does not contain help information or command-line arguments for the tool mlrho_bow2pro.\n
  \nTool homepage: http://guanine.evolbio.mpg.de/mlRho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlrho:2.9--h2d4b398_9
stdout: mlrho_bow2pro.out
