cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - arcasHLA
  - customize
label: arcas-hla_customize
doc: "Create a custom HLA reference (kallisto index and allele data) for a subject from its HLA genotype, for arcasHLA quant. Needs the IMGT/HLA reference built with 'arcasHLA reference' inside the arcasHLA install folder.\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
inputs:
  - id: genotype
    type:
      - 'null'
      - string
    doc: "comma-separated list of HLA alleles (e.g. A*01:01,A*11:01,...)"
    inputBinding:
      position: 1
      prefix: --genotype
  - id: genotype_file
    type:
      - 'null'
      - File
    doc: arcasHLA output genotype.json or genotypes.json, or tsv with format specified in README.md (alternative to a list of alleles)
    inputBinding:
      position: 1
      prefix: --genotype
  - id: subject
    type:
      - 'null'
      - string
    doc: "subject name, only required for list of alleles"
    inputBinding:
      position: 1
      prefix: --subject
  - id: genes
    type:
      - 'null'
      - string
    doc: "comma separated list of HLA genes (default: all)"
    inputBinding:
      position: 1
      prefix: --genes
  - id: transcriptome
    type:
      - 'null'
      - string
    doc: "transcripts to include besides input HLAs; options: full, chr6, none (default: full)"
    inputBinding:
      position: 1
      prefix: --transcriptome
  - id: resolution
    type:
      - 'null'
      - int
    doc: "genotype resolution, only use >2 when typing performed with assay or Sanger sequencing (default: 2)"
    inputBinding:
      position: 1
      prefix: --resolution
  - id: grouping
    type:
      - 'null'
      - string
    doc: "type/number of transcripts to include per allele: single, g-group, protein-group (default: protein-group)"
    inputBinding:
      position: 1
      prefix: --grouping
  - id: outdir
    type: string
    doc: out directory
    default: custom_ref
    inputBinding:
      position: 1
      prefix: --outdir
  - id: temp
    type:
      - 'null'
      - string
    doc: "temp directory"
    inputBinding:
      position: 1
      prefix: --temp
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: "keep intermediate files"
    inputBinding:
      position: 1
      prefix: --keep_files
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads"
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: index
    type: File[]
    doc: Custom kallisto index (<subject>.idx) with its allele data (<subject>.p)
    outputBinding:
      glob: $(inputs.outdir)/*.idx
    secondaryFiles:
      - pattern: ^.p
        required: false
  - id: out_dir
    type: Directory
    doc: Out directory with the custom reference files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
