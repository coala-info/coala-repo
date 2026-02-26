cwlVersion: v1.2
class: CommandLineTool
baseCommand: view
label: seqfu_view
doc: "View a FASTA/FASTQ file for manual inspection, allowing to search for an oligonucleotide.\n\
  \nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: inputfile
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: input_reverse
    type:
      - 'null'
      - File
    doc: Optional input reverse file
    inputBinding:
      position: 2
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Encode the quality as ASCII chars (when UNICODE is not available)
    inputBinding:
      position: 103
      prefix: --ascii
  - id: match_ths
    type:
      - 'null'
      - float
    doc: Oligo matching threshold
    default: 0.75
    inputBinding:
      position: 103
      prefix: --match-ths
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Oligo maxmimum mismataches
    default: 2
    inputBinding:
      position: 103
      prefix: --max-mismatches
  - id: min_matches
    type:
      - 'null'
      - int
    doc: Oligo minimum matches
    default: 5
    inputBinding:
      position: 103
      prefix: --min-matches
  - id: nocolor
    type:
      - 'null'
      - boolean
    doc: Disable colored output
    inputBinding:
      position: 103
      prefix: --nocolor
  - id: oligo1
    type:
      - 'null'
      - string
    doc: Match oligo, with ambiguous IUPAC chars allowed (rev. compl. search is 
      performed), color blue
    inputBinding:
      position: 103
      prefix: --oligo1
  - id: oligo2
    type:
      - 'null'
      - string
    doc: Second oligo to be scanned for, color red
    inputBinding:
      position: 103
      prefix: --oligo2
  - id: qual_chars
    type:
      - 'null'
      - boolean
    doc: Show quality characters instead of bars
    inputBinding:
      position: 103
      prefix: --qual-chars
  - id: qual_scale
    type:
      - 'null'
      - string
    doc: Quality thresholds, seven values separated by columns
    default: 3:15:25:28:30:35:40
    inputBinding:
      position: 103
      prefix: --qual-scale
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show extra information
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_view.out
