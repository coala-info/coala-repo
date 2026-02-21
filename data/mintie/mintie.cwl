cwlVersion: v1.2
class: CommandLineTool
baseCommand: mintie
label: mintie
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'mintie'. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/Oshlack/MINTIE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie.out
