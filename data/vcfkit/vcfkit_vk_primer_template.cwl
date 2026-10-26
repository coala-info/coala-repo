cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - primer
  - template
label: vcfkit_vk_primer_template
doc: "Generate primers for variant validation (template mode).\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: ref
    type:
      - 'null'
      - string
    doc: "Reference genome"
    inputBinding:
      position: 1
      prefix: --ref=
      separate: false
  - id: region
    type:
      - 'null'
      - string
    doc: "Restrict to region"
    inputBinding:
      position: 1
      prefix: --region=
      separate: false
  - id: samples
    type:
      - 'null'
      - string
    doc: "Output genotypes for a sample or set of samples (default ALL)"
    inputBinding:
      position: 1
      prefix: --samples=
      separate: false
  - id: template
    type:
      - 'null'
      - string
    doc: "The sample template to output (default ALT)"
    inputBinding:
      position: 1
      prefix: --template=
      separate: false
  - id: size
    type:
      - 'null'
      - string
    doc: "Amplicon size (default 600-800)"
    inputBinding:
      position: 1
      prefix: --size=
      separate: false
  - id: box_variants
    type:
      - 'null'
      - boolean
    doc: "Add second column for the sequence with the variant boxed"
    inputBinding:
      position: 1
      prefix: --box-variants
  - id: polymorphic
    type:
      - 'null'
      - boolean
    doc: "Only output variants that are polymorphic across specified samples"
    inputBinding:
      position: 1
      prefix: --polymorphic
  - id: enzymes
    type:
      - 'null'
      - string
    doc: "snip only: groups of restriction enzymes or individual enzymes (default Common)"
    inputBinding:
      position: 1
      prefix: --enzymes=
      separate: false
  - id: nprimers
    type:
      - 'null'
      - int
    doc: "Maximum number of primers to generate (default 5)"
    inputBinding:
      position: 1
      prefix: --nprimers=
      separate: false
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_primer_template.out
