cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./Dimob.pl
label: islandpath
doc: "Extracts genomic island information from a GenBank file.\n\nTool homepage: http://www.pathogenomics.sfu.ca/islandpath/"
inputs:
  - id: genome_gbk
    type: File
    doc: Input genome GenBank file
    inputBinding:
      position: 1
outputs:
  - id: outputfile_txt
    type: File
    doc: Output file for genomic island information
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/islandpath:1.0.6--hdfd78af_0
