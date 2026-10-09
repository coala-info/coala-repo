cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc_dump
label: kmc_dump
doc: "kmc_dump writes the k-mers of a KMC database and their counts to a text file.\n\nTool homepage: https://github.com/refresh-bio/KMC"
inputs:
  - id: exclude_less_than_count
    type: ['null', int]
    doc: "Exclude k-mers occurring less than this many times"
    inputBinding:
      position: 1
      prefix: "-ci"
      separate: false
  - id: exclude_more_than_count
    type: ['null', int]
    doc: "Exclude k-mers occurring more than this many times"
    inputBinding:
      position: 2
      prefix: "-cx"
      separate: false
  - id: kmc_database
    type: File
    doc: "KMC database: the .kmc_pre file (the .kmc_suf file must sit beside it)"
    secondaryFiles:
      - pattern: "^.kmc_suf"
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.kmc_pre$/, ''))
  - id: output_file
    type: string
    doc: "Output text file (one k-mer and its count per line)"
    inputBinding:
      position: 11
outputs:
  - id: dump
    type: File
    doc: "Text dump of the k-mers"
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc_dump.out
