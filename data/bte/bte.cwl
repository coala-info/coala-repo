cwlVersion: v1.2
class: CommandLineTool
baseCommand: bte
label: bte
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help documentation or argument definitions for the 'bte' tool.\n\
  \nTool homepage: https://github.com/jmcbroome/BTE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bte:0.9.3--py310h184ae93_1
stdout: bte.out
