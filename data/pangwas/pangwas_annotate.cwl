cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas_annotate
label: pangwas_annotate
doc: "Annotate genomic assemblies with bakta.\n\nTakes as input a FASTA file of genomic
  assemblies. Outputs a GFF file\nof annotations, among many other formats from bakta.\n\
  \nAll additional arguments with be passed to the `bakta` CLI.\n\nTool homepage:
  https://github.com/phac-nml/pangwas"
inputs:
  - id: db
    type: Directory
    doc: bakta database directory.
    inputBinding:
      position: 101
      prefix: --db
  - id: fasta
    type: File
    doc: Input FASTA sequences.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. If not provided, will be parsed from the fasta file
      name.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample identifier. If not provided, will be parsed from the fasta file 
      name.
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: CPU threads for bakta.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Temporary directory.
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
