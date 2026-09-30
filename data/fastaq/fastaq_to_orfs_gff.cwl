cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_orfs_gff
label: fastaq_to_orfs_gff
doc: "Writes a GFF file of open reading frames from a sequence file\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: Name of output GFF file
    inputBinding:
      position: 2
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of ORF, in nucleotides
    inputBinding:
      position: 102
      prefix: --min_length
outputs:
  - id: out_outfile
    type: File
    doc: Name of output GFF file
    outputBinding:
      glob: '$(inputs.outfile)'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
