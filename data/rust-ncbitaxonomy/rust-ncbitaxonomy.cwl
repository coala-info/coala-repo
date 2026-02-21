cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-ncbitaxonomy
label: rust-ncbitaxonomy
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the tool image.\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy.out
