cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapemapper
label: shapemapper
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://github.com/Weeks-UNC/shapemapper2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapemapper:1.2--py27_0
stdout: shapemapper.out
