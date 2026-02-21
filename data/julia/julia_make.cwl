cwlVersion: v1.2
class: CommandLineTool
baseCommand: julia_make
label: julia_make
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions.\n\nTool homepage:
  https://github.com/JuliaLang/julia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/julia:1.10
stdout: julia_make.out
