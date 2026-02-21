cwlVersion: v1.2
class: CommandLineTool
baseCommand: fml-asm
label: fermi-lite
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for fermi-lite. Fermi-lite (fml-asm)
  is typically used for assembling Illumina short reads into unitigs.\n\nTool homepage:
  https://github.com/lh3/fermi-lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi-lite:0.1--h577a1d6_8
stdout: fermi-lite.out
