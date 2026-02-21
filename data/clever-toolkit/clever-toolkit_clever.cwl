cwlVersion: v1.2
class: CommandLineTool
baseCommand: clever
label: clever-toolkit_clever
doc: "The provided text is a container runtime error log (Singularity/Apptainer) indicating
  a failure to build or extract the OCI image due to insufficient disk space. It does
  not contain CLI help information or argument definitions.\n\nTool homepage: https://bitbucket.org/tobiasmarschall/clever-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
stdout: clever-toolkit_clever.out
