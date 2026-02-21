cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdflib-jsonld
label: rdflib-jsonld
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image 'docker://biocontainers/rdflib-jsonld:v0.4.0-4-deb-py3_cv1'.
  As a result, no command-line arguments could be extracted.\n\nTool homepage: https://github.com/RDFLib/rdflib-jsonld"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdflib-jsonld:v0.4.0-4-deb-py3_cv1
stdout: rdflib-jsonld.out
