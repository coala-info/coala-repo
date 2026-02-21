cwlVersion: v1.2
class: CommandLineTool
baseCommand: glnexus
label: glnexus
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain CLI help information or usage instructions for glnexus. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/dnanexus-rnd/GLnexus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glnexus:1.4.1--h17e8430_5
stdout: glnexus.out
