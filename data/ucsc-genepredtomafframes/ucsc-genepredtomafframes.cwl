cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToMafFrames
label: ucsc-genepredtomafframes
doc: "Create frame annotations for one or more components of a MAF (mafFrames tables from genePreds).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: gene_set_rec
        type: record
        fields:
          - name: gene_db
            type: string
            doc: Database in the MAF that corresponds to the genePred's organism
            inputBinding:
              position: 1
          - name: gene_pred
            type: File
            doc: genePred file (overlapping annotations should be removed; may include frame annotations)
            inputBinding:
              position: 2
inputs:
  - id: bed
    type: ['null', string]
    doc: Output a bed for each mafFrame region, useful for debugging
    inputBinding:
      prefix: -bed=
      separate: false
      position: 1
  - id: verbose
    type: ['null', int]
    doc: "Enable verbose tracing (levels 3-6)"
    inputBinding:
      prefix: -verbose=
      separate: false
      position: 2
  - id: target_db
    type: string
    doc: Database of the target genome
    inputBinding:
      position: 3
  - id: maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 4
  - id: maf_frames_out
    type: string
    doc: Output mafFrames file name
    inputBinding:
      position: 5
  - id: gene_sets
    type: gene_set_rec[]
    doc: One or more pairs of geneDb and genePred file
    inputBinding:
      position: 6
outputs:
  - id: maf_frames
    type: File
    doc: Output mafFrames file
    outputBinding:
      glob: $(inputs.maf_frames_out)
  - id: bed_out
    type: ['null', File]
    doc: Debug bed file written with -bed
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtomafframes:482--h0b57e2e_0
