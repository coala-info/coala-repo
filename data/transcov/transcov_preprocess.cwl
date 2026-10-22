cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - preprocess
label: transcov_preprocess
doc: "Find the transcription start site of every transcript in a GENCODE GFF3 annotation and write a BED file and a TSS table\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: annotation_file
    type: File
    doc: "GENCODE annotation file (GFF3)"
    inputBinding:
      position: 1
  - id: region_size
    type:
      - 'null'
      - int
    default: 10000
    doc: "Size of the region around each transcription start site"
    inputBinding:
      prefix: --region-size
  - id: bed_file
    type:
      - 'null'
      - string
    default: transcription_start_sites.bed
    doc: "Output BED file name"
    inputBinding:
      prefix: --bed-file
  - id: tss_file
    type:
      - 'null'
      - string
    default: transcription_start_sites.tsv
    doc: "Output TSS table file name"
    inputBinding:
      prefix: --tss-file
outputs:
  - id: bed_output
    type: File
    doc: "BED file with the regions around the transcription start sites"
    outputBinding:
      glob: $(inputs.bed_file)
  - id: tss_output
    type: File
    doc: "Table with transcription start sites"
    outputBinding:
      glob: $(inputs.tss_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
