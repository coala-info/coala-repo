cwlVersion: v1.2
class: CommandLineTool
baseCommand: chembl_structure_pipeline
label: chembl_structure_pipeline
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or run a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/chembl/ChEMBL_Structure_Pipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chembl_structure_pipeline:1.0.0--2
stdout: chembl_structure_pipeline.out
