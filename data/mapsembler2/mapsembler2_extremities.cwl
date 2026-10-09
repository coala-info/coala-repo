cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapsembler2_extremities
label: mapsembler2_extremities
doc: "Selects the start and end k-mers of each starter that are present in the reads
  and writes them as substarters for mapsembler2_extend.\n\nTool homepage: https://colibread.inria.fr/software/mapsembler2/"
inputs:
  - id: kmer_size
    type: int
    doc: kmer size that will be used for mapsembler2
    inputBinding:
      position: 1
      prefix: --k
  - id: starters
    type: File
    doc: starters fasta file
    inputBinding:
      position: 2
      prefix: --starters
  - id: reads
    type:
      type: array
      items: File
    doc: reads dataset file names (passed as one quoted, space-separated string)
    inputBinding:
      position: 3
      prefix: --reads
      itemSeparator: ' '
  - id: output
    type: string
    doc: output substarters file name
    inputBinding:
      position: 4
      prefix: --output
  - id: min_solid_subkmer
    type:
      - 'null'
      - int
    doc: minimim abundance to keep a subkmer
    inputBinding:
      position: 5
      prefix: --min-solid-subkmer
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging
    inputBinding:
      position: 6
      prefix: -debug
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 7
      prefix: -nb-cores
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 8
      prefix: -verbose
outputs:
  - id: substarters
    type: File
    doc: substarters (extremities) fasta file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapsembler2:2.2.4--2
