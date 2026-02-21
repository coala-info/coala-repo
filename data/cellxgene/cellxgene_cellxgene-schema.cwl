cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellxgene-schema
label: cellxgene_cellxgene-schema
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or unpack the image due to lack of disk space. It
  does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://chanzuckerberg.github.io/cellxgene/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
stdout: cellxgene_cellxgene-schema.out
