cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - annotate
label: pangwas_annotate
doc: "Annotate genomic assemblies with bakta.\n\nTakes as input a FASTA file of genomic assemblies. Outputs a GFF file\nof annotations, among many other formats from bakta.\n\nAll additional arguments with be passed to the `bakta` CLI.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: fasta
    type: File
    doc: "Input FASTA sequences."
    inputBinding:
      position: 101
      prefix: --fasta
  - id: db
    type: Directory
    doc: "bakta database directory."
    inputBinding:
      position: 101
      prefix: --db
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: .)"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output file prefix. If not provided, will be parsed from the fasta file name."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: tmp
    type:
      - 'null'
      - string
    doc: "Temporary directory."
    inputBinding:
      position: 101
      prefix: --tmp
  - id: sample
    type:
      - 'null'
      - string
    doc: "Sample identifier. If not provided, will be parsed from the fasta file name."
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: "CPU threads for bakta. (default: 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: extra_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Additional arguments passed on to `bakta`."
    inputBinding:
      position: 200
outputs:
  - id: gff
    type:
      - 'null'
      - File
    doc: "GFF3 annotations written by bakta"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix || inputs.fasta.nameroot) + '.gff3')"
  - id: annotation_files
    type: File[]
    doc: "All annotation files written with the output prefix"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix || inputs.fasta.nameroot) + '.*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
