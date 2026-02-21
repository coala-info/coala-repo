cwlVersion: v1.2
class: CommandLineTool
baseCommand: uniprot
label: uniprot
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain help documentation or argument definitions for the 'uniprot'
  tool.\n\nTool homepage: https://github.com/Proteomicslab57357/UniprotR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniprot:1.3--py34_0
stdout: uniprot.out
