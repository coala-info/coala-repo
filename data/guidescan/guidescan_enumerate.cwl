cwlVersion: v1.2
class: CommandLineTool
baseCommand: guidescan_enumerate
label: guidescan_enumerate
doc: "Enumerates off-targets against a reference.\n\nTool homepage: https://github.com/pritykinlab/guidescan-cli"
inputs:
  - id: index
    type: string
    doc: Prefix for index files
    inputBinding:
      position: 1
  - id: alt_pam
    type:
      - 'null'
      - type: array
        items: string
    doc: Alternative PAMs used to find off-targets
    default: []
    inputBinding:
      position: 102
      prefix: --alt-pam
  - id: dna_bulges
    type:
      - 'null'
      - int
    doc: Number of DNA bulges to allow when finding off-targets
    default: 0
    inputBinding:
      position: 102
      prefix: --dna-bulges
  - id: format
    type:
      - 'null'
      - string
    doc: File format for output. Choices are ['csv', 'sam'].
    inputBinding:
      position: 102
      prefix: --format
  - id: kmers_file
    type: File
    doc: File containing kmers to build gRNA database over, if not specified, 
      will generate the database over all kmers with the given PAM
    inputBinding:
      position: 102
      prefix: --kmers-file
  - id: max_off_targets
    type:
      - 'null'
      - int
    doc: Maximum number of off-targets to store for each number of mismatches.
    default: -1
    inputBinding:
      position: 102
      prefix: --max-off-targets
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of mismatches to allow when finding off-targets
    default: 3
    inputBinding:
      position: 102
      prefix: --mismatches
  - id: mode
    type:
      - 'null'
      - string
    doc: Information to output. Choices are ['succinct', 'complete'].
    inputBinding:
      position: 102
      prefix: --mode
  - id: rna_bulges
    type:
      - 'null'
      - int
    doc: Max number of RNA bulges to allow when finding off-targets
    default: 0
    inputBinding:
      position: 102
      prefix: --rna-bulges
  - id: start
    type:
      - 'null'
      - boolean
    doc: Match PAM at start of kmer instead at end (default).
    inputBinding:
      position: 102
      prefix: --start
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to parallelize over
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Filters gRNAs with off-targets at a distance at or below this threshold
    default: -1
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: output
    type: File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
