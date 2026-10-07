cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - ML
  - score-vcf
label: consplice_ML_score-vcf
doc: "Score variants using ConSpliceML. The vcf file must already have SpliceAI, SQUIRLS and ConSplice annotations for each variant.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: vcf_file
    type: File
    doc: 'The input vcf file to score.'
    inputBinding:
      position: 1
      prefix: --vcf-file
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
  - id: output_file
    type: string
    doc: 'The output variant file to create (an extension is added when missing).'
    inputBinding:
      position: 1
      prefix: --output-file
  - id: alt_gene_symbol
    type: File
    doc: 'A file with a header that maps canonical gene symbols to alternative gene symbols (HGNC protein-coding gene mapping file).'
    inputBinding:
      position: 1
      prefix: --alt-gene-symbol
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'The output file type: ''vcf'', ''vcfgz'', ''bcf'' or ''bcfgz''. Default = ''vcf''.'
    inputBinding:
      position: 1
      prefix: --out-type
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: 'The number of CPUs to use for multi-threading during vcf parsing. Default = 3.'
    inputBinding:
      position: 1
      prefix: --n-cpu
  - id: ml_model
    type:
      - 'null'
      - Directory
    doc: 'The directory that contains the ConSpliceML model. Default = the model in the ConSplice config path.'
    inputBinding:
      position: 1
      prefix: --ml-model
outputs:
  - id: output
    type: File
    doc: 'The ConSpliceML scored vcf/bcf file.'
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
