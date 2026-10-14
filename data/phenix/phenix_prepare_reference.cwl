cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phenix.py
  - prepare_reference
label: phenix_prepare_reference
doc: "Prepare reference for SNP pipeline by generating required aux files.\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs:
  - id: reference
    type: File
    doc: "Path to reference file to prepare (staged writable; the aux files are written beside it)."
    inputBinding:
      position: 1
      prefix: --reference
      valueFrom: $(self.basename)
  - id: mapper
    type:
      - 'null'
      - string
    doc: "Available mappers: bwa, bowtie2"
    inputBinding:
      position: 2
      prefix: --mapper
  - id: variant
    type:
      - 'null'
      - string
    doc: "Available variants: mpileup, gatk"
    inputBinding:
      position: 3
      prefix: --variant
outputs:
  - id: prepared_reference
    type:
      type: array
      items: File
    doc: "The reference with the generated index and dictionary files"
    outputBinding:
      glob: $(inputs.reference.basename)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
