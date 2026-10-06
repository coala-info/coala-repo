cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_manage_UTRs.pl
label: agat_agat_sp_manage_utrs.pl
doc: "This script reports UTRs and removes those whose number of exons is over or
  equal to a threshold (--number), on the 3' side, the 5' side or both.\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: five_prime
    type:
      - 'null'
      - boolean
    doc: Apply the --number threshold to the 5' UTR.
    inputBinding:
      position: 101
      prefix: --five
  - id: gff
    type: File
    doc: Input GFF3 file.
    inputBinding:
      position: 101
      prefix: --gff
  - id: number
    type:
      - 'null'
      - int
    doc: Threshold of UTR exon number. Over or equal to this threshold, the 
      UTR is discarded. Default 5.
    inputBinding:
      position: 101
      prefix: --number
  - id: three_prime
    type:
      - 'null'
      - boolean
    doc: Apply the --number threshold to the 3' UTR.
    inputBinding:
      position: 101
      prefix: --three
  - id: both
    type:
      - 'null'
      - boolean
    doc: Apply the --number threshold to genes whose 3' plus 5' UTR exon 
      number is over it.
    inputBinding:
      position: 101
      prefix: --both
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Create a PDF histogram of the UTR size distribution.
    inputBinding:
      position: 101
      prefix: --plot
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity, 0 to 4. Default 1.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: Output folder name.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output folder with the GFF3 files split by the UTR threshold.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
