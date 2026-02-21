cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasminesv
label: jasminesv_split_jasmine
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Singularity/Apptainer) log messages and a fatal error regarding
  disk space.\n\nTool homepage: https://github.com/mkirsche/Jasmine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
stdout: jasminesv_split_jasmine.out
