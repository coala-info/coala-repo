cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - mash
label: meta-sparse_sparse_mash
doc: "Rapid mash query of an assembly or a read set against a SPARSE database.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbname)
        writable: true
      - entry: $(inputs.query)
        writable: true
inputs:
  - id: dbname
    type: Directory
    doc: "SPARSE database folder (created by sparse init); staged writable in the working directory"
    inputBinding:
      position: 1
      prefix: --dbname
      valueFrom: $(self.basename)
  - id: query
    type: File
    doc: "A genome in fasta format, or a set of reads in fastq format; staged writable because the sketch is written beside it"
    inputBinding:
      position: 2
      prefix: --query
      valueFrom: $(self.basename)
  - id: read
    type: 
      - 'null'
      - boolean
    doc: "Specify if query is a read set rather than an assembly"
    inputBinding:
      position: 3
      prefix: --read
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse_mash.out
