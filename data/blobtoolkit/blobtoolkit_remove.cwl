cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - remove
label: blobtoolkit_remove
doc: "Remove fields from a BlobDir.\n\nTool homepage: https://github.com/blobtoolkit/blobtoolkit"
inputs:
  - id: blobdir
    type: Directory
    doc: Existing Blob directory (fields are removed in place; the updated copy is returned).
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: all
    type: ['null', boolean]
    doc: Remove all fields except identifiers.
    inputBinding:
      position: 1
      prefix: --all
  - id: remove_busco
    type: ['null', boolean]
    doc: Remove all BUSCO fields.
    inputBinding:
      position: 1
      prefix: --busco
  - id: remove_cov
    type: ['null', boolean]
    doc: Remove all cov and read_cov fields.
    inputBinding:
      position: 1
      prefix: --cov
  - id: remove_fasta
    type: ['null', boolean]
    doc: Remove gc, length and ncount fields.
    inputBinding:
      position: 1
      prefix: --fasta
  - id: field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --field
    doc: Remove fields by ID.
    inputBinding:
      position: 1
  - id: remove_hits
    type: ['null', boolean]
    doc: Remove all taxonomy fields.
    inputBinding:
      position: 1
      prefix: --hits
outputs:
  - id: output_blobdir
    type: Directory
    doc: The updated BlobDir
    outputBinding:
      glob: $(inputs.blobdir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.blobdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
