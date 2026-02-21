cwlVersion: v1.2
class: CommandLineTool
baseCommand: neffy
label: neffy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'neffy'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/Maryam-Haghani/NEFFy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy:0.1.1--py311he264feb_1
stdout: neffy.out
