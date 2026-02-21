cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu
label: emu
doc: "The provided text is a container runtime error log (Singularity/Apptainer) and
  does not contain the help documentation or usage instructions for the 'emu' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://gitlab.com/treangenlab/emu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu:3.6.0--hdfd78af_0
stdout: emu.out
