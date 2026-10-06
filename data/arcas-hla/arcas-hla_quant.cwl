cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - arcasHLA
  - quant
label: arcas-hla_quant
doc: "Allele-specific HLA quantification against a custom HLA reference made with arcasHLA customize.\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: file
    type: File[]
    doc: list of fastq files
    inputBinding:
      position: 10
  - id: sample
    type:
      - 'null'
      - string
    doc: "sample name"
    inputBinding:
      position: 1
      prefix: --sample
  - id: ref
    type:
      - 'null'
      - File
    doc: arcasHLA quant_ref index (<subject>.idx from arcasHLA customize, with <subject>.p beside it); passed as the path prefix
    secondaryFiles:
      - pattern: ^.p
    inputBinding:
      position: 1
      prefix: --ref
      valueFrom: '$(self.path.replace(/\.idx$/, ""))'
  - id: outdir
    type: string
    doc: out directory
    default: quant
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
  - id: avg
    type:
      - 'null'
      - int
    doc: "Estimated average fragment length for single-end reads (default: 200)"
    inputBinding:
      position: 1
      prefix: --avg
  - id: std
    type:
      - 'null'
      - int
    doc: "Estimated standard deviation of fragment length for single-end reads (default: 20)"
    inputBinding:
      position: 1
      prefix: --std
  - id: single
    type:
      - 'null'
      - boolean
    doc: "Include flag if single-end reads. Default is paired-end."
    inputBinding:
      position: 1
      prefix: --single
  - id: loh
    type:
      - 'null'
      - boolean
    doc: "Include flag for estimated loss of heterozygosity. Must provide purity and ploidy estimates."
    inputBinding:
      position: 1
      prefix: --LOH
  - id: purity
    type:
      - 'null'
      - float
    doc: "Estimated purity of sample (default: 1.0)"
    inputBinding:
      position: 1
      prefix: --purity
  - id: ploidy
    type:
      - 'null'
      - float
    doc: "Estimated ploidy of sample (default: 2.0)"
    inputBinding:
      position: 1
      prefix: --ploidy
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
  - id: quant_tables
    type: File[]
    doc: Quantification tables (sample.quant.tsv, .quant.alleles.tsv, .quant.genes.tsv, .quant.loh.tsv)
    outputBinding:
      glob: $(inputs.outdir)/*.tsv
  - id: quant_json
    type: File[]
    doc: Quantification results as JSON (sample.quant.alleles.json, sample.quant.genes.json)
    outputBinding:
      glob: $(inputs.outdir)/*.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
