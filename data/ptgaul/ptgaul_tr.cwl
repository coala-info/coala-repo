cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ptgaul
  - tr
label: ptgaul_tr
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_tr.out
