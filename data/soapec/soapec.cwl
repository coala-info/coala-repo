cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapec
label: soapec
doc: "The provided text does not contain help information for the tool 'soapec'. It
  appears to be a log from a container build process (Apptainer/Singularity) that
  failed while fetching the OCI image.\n\nTool homepage: https://github.com/michaldobroszek/SoapeClient"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapec:2.03--h077b44d_9
stdout: soapec.out
