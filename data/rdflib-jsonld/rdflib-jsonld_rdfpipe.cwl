cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfpipe
label: rdflib-jsonld_rdfpipe
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) failing
  to fetch or build the image.\n\nTool homepage: https://github.com/RDFLib/rdflib-jsonld"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdflib-jsonld:v0.4.0-4-deb-py3_cv1
stdout: rdflib-jsonld_rdfpipe.out
