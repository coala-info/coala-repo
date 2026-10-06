cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - validate
label: blobtoolkit_validate
doc: "Validate a BlobDir.\n\nTool homepage: https://github.com/blobtoolkit/blobtoolkit"
inputs:
  - id: blobdir
    type: Directory
    doc: BlobDir directory.
    inputBinding:
      position: 2
  - id: basic
    type: ['null', boolean]
    doc: Only require basic metadata.
    inputBinding:
      position: 1
      prefix: --basic
  - id: example
    type: ['null', boolean]
    doc: Validate example dataset.
    inputBinding:
      position: 1
      prefix: --example
outputs:
  - id: validation_report
    type: stdout
    doc: Validation messages
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
stdout: blobtoolkit_validate.out
