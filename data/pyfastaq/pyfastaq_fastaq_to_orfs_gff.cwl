cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_orfs_gff
label: pyfastaq_fastaq_to_orfs_gff
doc: "Writes a GFF file of open reading frames from a sequence file\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of ORF, in nucleotides [300]"
    inputBinding:
      position: 1
      prefix: --min_length
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output GFF file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output GFF file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
