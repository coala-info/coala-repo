cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnacauldron
label: dnacauldron
doc: "Note: The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain the tool's help documentation or usage instructions. It indicates
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/Edinburgh-Genome-Foundry/DnaCauldron"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnacauldron:2.0.12--pyh7e72e81_0
stdout: dnacauldron.out
