cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressivemauve
label: progressivemauve
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  failing to fetch or build the OCI image.\n\nTool homepage: http://darlinglab.org/mauve/user-guide/progressivemauve.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/progressivemauve:v1.2.04713-2b2-deb_cv1
stdout: progressivemauve.out
