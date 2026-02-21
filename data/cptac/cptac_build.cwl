cwlVersion: v1.2
class: CommandLineTool
baseCommand: cptac_build
label: cptac_build
doc: "The provided text appears to be a log of a failed container build process (Apptainer/Singularity)
  rather than CLI help text. No arguments or usage instructions were found in the
  input.\n\nTool homepage: http://github.com/PayneLab/cptac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cptac:1.5.13--pyhdfd78af_0
stdout: cptac_build.out
