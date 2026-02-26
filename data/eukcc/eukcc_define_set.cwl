cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukcc define_set
label: eukcc_define_set
doc: "Define sets of genomes based on marker prevalence.\n\nTool homepage: https://github.com/Finn-Lab/EukCC/"
inputs:
  - id: genomes
    type:
      type: array
      items: File
    doc: List of genome files to process.
    inputBinding:
      position: 1
  - id: aa
    type:
      - 'null'
      - boolean
    doc: Use amino acid markers.
    inputBinding:
      position: 102
      prefix: --AA
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to the marker database.
    inputBinding:
      position: 102
      prefix: --db
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Use DNA markers.
    inputBinding:
      position: 102
      prefix: --DNA
  - id: marker_prevalence
    type:
      - 'null'
      - float
    doc: Minimum prevalence threshold for markers.
    inputBinding:
      position: 102
      prefix: --marker_prevalence
  - id: max_set_size
    type:
      - 'null'
      - int
    doc: Maximum size of the defined set.
    inputBinding:
      position: 102
      prefix: --max_set_size
  - id: name
    type:
      - 'null'
      - string
    doc: Name for the defined set.
    inputBinding:
      position: 102
      prefix: --name
  - id: set_size
    type:
      - 'null'
      - int
    doc: Desired size of the defined set.
    inputBinding:
      position: 102
      prefix: --set_size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory for the defined set.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukcc:2.1.3--pyhdfd78af_0
