cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk_build
label: amptk_build
doc: "The provided text appears to be an error log from a container build process
  (Singularity/Apptainer) rather than CLI help text. No arguments or options could
  be extracted.\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_build.out
