cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasirecomb
label: quasirecomb_QuasiRecomb.jar
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log (Apptainer/Singularity) indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: https://github.com/cbg-ethz/QuasiRecomb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasirecomb:1.2--0
stdout: quasirecomb_QuasiRecomb.jar.out
