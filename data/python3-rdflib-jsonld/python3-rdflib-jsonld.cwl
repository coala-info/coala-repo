cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-rdflib-jsonld
label: python3-rdflib-jsonld
doc: The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) attempting to fetch
  the tool's image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-rdflib-jsonld:v0.4.0-2-deb_cv1
stdout: python3-rdflib-jsonld.out
