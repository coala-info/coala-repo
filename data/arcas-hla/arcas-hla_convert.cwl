cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - arcasHLA
  - convert
label: arcas-hla_convert
doc: "Convert HLA genotypes in a TSV to another nomenclature resolution (1, 2 or 3 fields) or grouping (g-group, p-group). Needs the IMGT/HLA reference built with 'arcasHLA reference' (dat/ref/hla.convert.json) inside the arcasHLA install folder.\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
inputs:
  - id: file
    type: File
    doc: tsv containing HLA genotypes, see github for example file structure.
    inputBinding:
      position: 10
  - id: resolution
    type: string
    doc: output resolution (1,2,3) or grouping (g-group, p-group)
    inputBinding:
      position: 1
      prefix: --resolution
  - id: outfile
    type: string
    doc: output file
    default: converted.tsv
    inputBinding:
      position: 1
      prefix: --outfile
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force conversion for grouped alleles even if it results in loss of resolution"
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: converted
    type: File
    doc: Converted genotype table
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
