cwlVersion: v1.2
class: CommandLineTool
baseCommand: AccurateMassSearchEngine
label: pyopenms_AccurateMassSearchEngine
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to fetch
  a Docker image.\n\nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopenms:3.4.1--py310h7ad0250_2
stdout: pyopenms_AccurateMassSearchEngine.out
