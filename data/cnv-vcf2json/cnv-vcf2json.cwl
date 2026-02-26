cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv-vcf2json
label: cnv-vcf2json
doc: "Convert CNVkit VCF to Beacon JSON format following the Progenetix pgxVariant
  schema\n\nTool homepage: https://github.com/conda-forge/cnv-vcf2json-feedstock"
inputs:
  - id: input
    type: File
    doc: Input VCF file name
    inputBinding:
      position: 1
  - id: analysis
    type:
      - 'null'
      - string
    doc: Analysis identifier (analysisId)
    inputBinding:
      position: 102
      prefix: --analysis
  - id: assembly
    type:
      - 'null'
      - string
    doc: Assembly identifier (e.g. GRCh38); if omitted, assemblyId will be 
      excluded
    inputBinding:
      position: 102
      prefix: --assembly
  - id: fusion
    type:
      - 'null'
      - string
    doc: Fusion identifier (fusionId)
    inputBinding:
      position: 102
      prefix: --fusion
  - id: individual
    type:
      - 'null'
      - string
    doc: Individual identifier (individualId)
    inputBinding:
      position: 102
      prefix: --individual
  - id: reference
    type:
      - 'null'
      - string
    doc: Reference sequence
    inputBinding:
      position: 102
      prefix: --reference
  - id: sequence
    type:
      - 'null'
      - string
    doc: Variant sequence
    inputBinding:
      position: 102
      prefix: --sequence
outputs:
  - id: output
    type: File
    doc: Output JSON file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-vcf2json:2.0.0
