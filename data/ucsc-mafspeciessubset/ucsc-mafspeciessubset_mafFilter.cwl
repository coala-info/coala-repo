cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFilter
label: ucsc-mafspeciessubset_mafFilter
doc: "Filter a MAF (Multiple Alignment Format) file based on species, score, or completeness.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_maf
    type: File
    doc: Input MAF file to be filtered
    inputBinding:
      position: 1
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score for an alignment block to be kept
    inputBinding:
      position: 102
      prefix: -minScore
  - id: need_all
    type:
      - 'null'
      - boolean
    doc: Only include blocks that contain all specified species
    inputBinding:
      position: 102
      prefix: -needAll
  - id: species
    type:
      - 'null'
      - string
    doc: Only include species in the provided comma-separated list
    inputBinding:
      position: 102
      prefix: -species
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name (defaults to stdout if not specified)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspeciessubset:482--h0b57e2e_0
