cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq
label: fastaq
doc: "The provided text does not contain help information for the tool 'fastaq'. It
  appears to be an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to fetch an OCI image due to insufficient disk space.\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
stdout: fastaq.out
