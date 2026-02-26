cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genmod
  - models
label: genmod_models
doc: "Annotate genetic models for vcf variants.\n\n  Checks what patterns of inheritance
  that are followed in a VCF file. The\n  analysis is family based so each family
  that are specified in the family\n  file and exists in the variant file will get
  it's own annotation.\n\n  Note that the \"whole_gene\" flag has been disabled and
  will be removed in a\n  later version.\n\nTool homepage: http://github.com/moonso/genmod"
inputs:
  - id: vcf_file
    type: File
    doc: VCF file to annotate
    inputBinding:
      position: 1
  - id: family_file
    type: File
    doc: File with family information
    inputBinding:
      position: 102
      prefix: --family_file
  - id: family_type
    type:
      - 'null'
      - string
    doc: If the analysis use one of the known setups, please specify which one.
    inputBinding:
      position: 102
      prefix: --family_type
  - id: keyword
    type:
      - 'null'
      - string
    doc: What annotation keyword that should be used when searching for 
      features.
    inputBinding:
      position: 102
      prefix: --keyword
  - id: phased
    type:
      - 'null'
      - boolean
    doc: If data is phased use this flag.
    inputBinding:
      position: 102
      prefix: --phased
  - id: processes
    type:
      - 'null'
      - int
    doc: Define how many processes that should be use for annotation.
    inputBinding:
      position: 102
      prefix: --processes
  - id: reduced_penetrance_file
    type:
      - 'null'
      - File
    doc: File with gene ids that have reduced penetrance.
    inputBinding:
      position: 102
      prefix: --reduced-penetrance
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print the variants.
    inputBinding:
      position: 102
      prefix: --silent
  - id: strict
    type:
      - 'null'
      - boolean
    doc: If strict model annotations should be used(see documentation).
    inputBinding:
      position: 102
      prefix: --strict
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to tempdir
    inputBinding:
      position: 102
      prefix: --temp_dir
  - id: vep
    type:
      - 'null'
      - boolean
    doc: If variants are annotated with the Variant Effect Predictor.
    inputBinding:
      position: 102
      prefix: --vep
  - id: whole_gene
    type:
      - 'null'
      - boolean
    doc: DEPRECATED FLAG - on by default
    inputBinding:
      position: 102
      prefix: --whole-gene
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
