cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq trim_contigs
label: fastaq_trim_contigs
doc: "Trims a set number of bases off the end of every contig, so gaps get bigger
  and contig ends are removed. Bases are replaced with Ns. Any sequence that ends
  up as all Ns is lost\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: trim_number
    type:
      - 'null'
      - int
    doc: Number of bases to trim around each gap, and off ends of each sequence
    inputBinding:
      position: 102
      prefix: --trim_number
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
