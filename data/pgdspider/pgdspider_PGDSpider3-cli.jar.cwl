cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar PGDSpider3-cli.jar
label: pgdspider_PGDSpider3-cli.jar
doc: "PGDSpider is a data conversion tool for population genetic and genomics programs.\n
  \nTool homepage: http://www.cmpg.unibe.ch/software/PGDSpider/"
inputs:
  - id: input_file
    type: File
    doc: The input file to be converted.
    inputBinding:
      position: 101
      prefix: -inputfile
  - id: input_format
    type: string
    doc: The format of the input file (e.g., VCF, FASTA, GENEPOP).
    inputBinding:
      position: 101
      prefix: -inputformat
  - id: output_format
    type: string
    doc: The format of the output file.
    inputBinding:
      position: 101
      prefix: -outputformat
  - id: spid_file
    type:
      - 'null'
      - File
    doc: The SPID file containing the conversion settings.
    inputBinding:
      position: 101
      prefix: -spid
outputs:
  - id: output_file
    type: File
    doc: The name of the output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgdspider:2.1.1.5--hdfd78af_1
