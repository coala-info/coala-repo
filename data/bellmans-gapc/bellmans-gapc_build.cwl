cwlVersion: v1.2
class: CommandLineTool
baseCommand: bellmans-gapc_build
label: bellmans-gapc_build
doc: "The provided text appears to be an error log from a container build process
  (Apptainer/Singularity) rather than CLI help text. No command-line arguments or
  usage instructions could be extracted.\n\nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/gapc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellmans-gapc:2024.01.12--h0432e7c_1
stdout: bellmans-gapc_build.out
