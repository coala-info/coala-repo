cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - arcasHLA
  - merge
label: arcas-hla_merge
doc: "Merge arcasHLA genotype, partial genotype and gene count JSON files of many samples into tab-separated tables.\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
inputs:
  - id: indir
    type: Directory
    doc: directory containing arcasHLA files (*.genotype.json, *.partial_genotype.json, *.genes.json)
    inputBinding:
      position: 1
      prefix: --indir
  - id: outdir
    type: string
    doc: out directory
    default: merged
    inputBinding:
      position: 1
      prefix: --outdir
  - id: run
    type:
      - 'null'
      - string
    doc: "run name (prefix of the output tables)"
    inputBinding:
      position: 1
      prefix: --run
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: tables
    type: File[]
    doc: Merged tables (genotypes.tsv, partial_genotypes.tsv, genes.tsv; prefixed by the run name)
    outputBinding:
      glob: $(inputs.outdir)/*.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
