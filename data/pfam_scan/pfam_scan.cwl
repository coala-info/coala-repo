cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfam_scan.pl
label: pfam_scan
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain the help text for pfam_scan.
  Below is the structured representation of the tool based on its standard usage.\n
  \nTool homepage: http://ftp.ebi.ac.uk/pub/databases/Pfam/Tools/"
inputs:
  - id: as_flag
    type:
      - 'null'
      - boolean
    doc: Predict active site residues for Pfam-A matches
    inputBinding:
      position: 101
      prefix: -as
  - id: bit_score
    type:
      - 'null'
      - float
    doc: Bit score cutoff for Pfam-A matches
    inputBinding:
      position: 101
      prefix: -b_value
  - id: clan_overlap
    type:
      - 'null'
      - boolean
    doc: Show overlapping hits within clans
    inputBinding:
      position: 101
      prefix: -clan_overlap
  - id: database_dir
    type: Directory
    doc: Directory containing Pfam data files
    inputBinding:
      position: 101
      prefix: -dir
  - id: e_seq
    type:
      - 'null'
      - float
    doc: E-value cutoff for Pfam-A sequence matches
    inputBinding:
      position: 101
      prefix: -e_seq
  - id: e_value
    type:
      - 'null'
      - float
    doc: E-value cutoff for Pfam-A matches
    inputBinding:
      position: 101
      prefix: -e_value
  - id: fasta_file
    type: File
    doc: Input fasta file to scan
    inputBinding:
      position: 101
      prefix: -fasta
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write output in JSON format
    inputBinding:
      position: 101
      prefix: -json
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 101
      prefix: -cpu
  - id: translate
    type:
      - 'null'
      - string
    doc: Treat input as DNA and translate in 6 frames (all|sense)
    inputBinding:
      position: 101
      prefix: -translate
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file; if not specified, output goes to STDOUT
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pfam_scan:1.6--hdfd78af_5
