cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-map-se
label: tepid_tepid-map-se
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the OCI image for TEPID.\n\nTool homepage: https://github.com/ListerLab/TEPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid_tepid-map-se.out
