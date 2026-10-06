cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - advntr
  - addmodel
label: advntr_addmodel
doc: "Add a new VNTR model to the database\n\nTool homepage: https://github.com/mehrdadbakhtiari/adVNTR"
inputs:
  - id: annotation
    type:
      - 'null'
      - string
    doc: Annotation of VNTR region
    inputBinding:
      position: 101
      prefix: --annotation
  - id: chromosome
    type: string
    doc: Chromosome (e.g. chr1)
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: end
    type: int
    doc: End coordinate of VNTR in forward (5' to 3') direction
    inputBinding:
      position: 101
      prefix: --end
  - id: gene
    type:
      - 'null'
      - string
    doc: Gene name
    inputBinding:
      position: 101
      prefix: --gene
  - id: models
    type: string
    default: advntr_models.db
    doc: VNTR models file (SQLite database) to create, or to extend when 
      existing_models is given. Written in the working directory.
    inputBinding:
      position: 101
      prefix: --models
      valueFrom: "$(self.indexOf('/') < 0 ? './' + self : self)"
  - id: existing_models
    type:
      - 'null'
      - File
    doc: Existing VNTR models database to extend; it is copied to the name in 
      models and the new model is added to the copy.
  - id: pattern
    type: string
    doc: First repeating pattern of VNTR in forward (5' to 3') direction
    inputBinding:
      position: 101
      prefix: --pattern
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: start
    type: int
    doc: Start coordinate of VNTR in forward (5' to 3') direction
    inputBinding:
      position: 101
      prefix: --start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: models_db
    type: File
    doc: VNTR models database with the new model
    outputBinding:
      glob: $(inputs.models)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        if (inputs.existing_models) {
          return [{"entry": inputs.existing_models, "entryname": inputs.models, "writable": true}];
        }
        return [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
stdout: advntr_addmodel.out
