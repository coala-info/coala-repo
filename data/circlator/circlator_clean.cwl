cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circlator
  - clean
label: circlator_clean
doc: "Clean contigs\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: in_fasta
    type: File
    doc: Name of input FASTA file
    inputBinding:
      position: 1
  - id: outprefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 2
  - id: breaklen
    type:
      - 'null'
      - int
    doc: breaklen option used by nucmer
    inputBinding:
      position: 103
      prefix: --breaklen
  - id: diagdiff
    type:
      - 'null'
      - int
    doc: Nucmer diagdiff option
    inputBinding:
      position: 103
      prefix: --diagdiff
  - id: keep
    type:
      - 'null'
      - File
    doc: File of contig names to keep in output file
    inputBinding:
      position: 103
      prefix: --keep
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Contigs shorter than this are discarded (unless specified using --keep)
    inputBinding:
      position: 103
      prefix: --min_contig_length
  - id: min_contig_percent
    type:
      - 'null'
      - float
    doc: If length of nucmer hit is at least this percentage of length of 
      contig, then contig is removed. (unless specified using --keep)
    inputBinding:
      position: 103
      prefix: --min_contig_percent
  - id: min_nucmer_id
    type:
      - 'null'
      - float
    doc: Nucmer minimum percent identity
    inputBinding:
      position: 103
      prefix: --min_nucmer_id
  - id: min_nucmer_length
    type:
      - 'null'
      - int
    doc: Minimum length of hit for nucmer to report
    inputBinding:
      position: 103
      prefix: --min_nucmer_length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_clean.out
