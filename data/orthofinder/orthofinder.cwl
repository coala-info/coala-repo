cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthofinder
label: orthofinder
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the OrthoFinder
  tool.\n\nTool homepage: https://github.com/OrthoFinder/OrthoFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthofinder:3.1.2--hdfd78af_1
stdout: orthofinder.out
