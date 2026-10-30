cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - trim_contigs
label: pyfastaq_fastaq_trim_contigs
doc: "Trims a set number of bases off the end of every contig, so gaps get bigger and contig ends are removed. Bases are replaced with Ns. Any sequence that ends up as all Ns is lost\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: trim_number
    type:
      - 'null'
      - int
    doc: "Number of bases to trim around each gap, and off ends of each sequence [100]"
    inputBinding:
      position: 1
      prefix: --trim_number
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
