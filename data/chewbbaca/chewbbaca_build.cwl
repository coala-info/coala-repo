cwlVersion: v1.2
class: CommandLineTool
baseCommand: chewbbaca_build
label: chewbbaca_build
doc: "The provided text is a log of a failed container build process (Singularity/Apptainer)
  and does not contain CLI help information or arguments for the tool.\n\nTool homepage:
  https://github.com/B-UMMI/chewBBACA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
stdout: chewbbaca_build.out
