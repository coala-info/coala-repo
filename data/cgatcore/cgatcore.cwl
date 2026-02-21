cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgatcore
label: cgatcore
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain CLI help information or argument definitions for the tool 'cgatcore'.\n
  \nTool homepage: https://github.com/cgat-developers/cgat-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgatcore:0.6.16--pyhdfd78af_0
stdout: cgatcore.out
