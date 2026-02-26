cwlVersion: v1.2
class: CommandLineTool
baseCommand: genmap_index
label: genmap_index
doc: "GenMap is a tool for fast and exact computation of genome mappability and can
  also be used for multiple genomes, e.g., to search for marker sequences.\n\nTool
  homepage: https://github.com/cpockrandt/genmap"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Algorithm for suffix array construction (needed for the FM index). One 
      of divsufsort and skew.
    default: divsufsort
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: fasta_directory
    type:
      - 'null'
      - Directory
    doc: Path to the directory of fasta files (indexes all .fsa .fna .fastq 
      .fasta .fas .faa and .fa files in there, not including subdirectories).
    inputBinding:
      position: 101
      prefix: --fasta-directory
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: 'Path to the fasta file. Valid filetypes are: .fsa, .fna, .fastq, .fasta,
      .fas, .faa, and .fa.'
    inputBinding:
      position: 101
      prefix: --fasta-file
  - id: sampling
    type:
      - 'null'
      - int
    doc: Sampling rate of suffix array In range [1..64].
    default: 10
    inputBinding:
      position: 101
      prefix: --sampling
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Outputs some additional information on the constructed index.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    default: true
    inputBinding:
      position: 101
      prefix: --version-check
outputs:
  - id: index
    type:
      - 'null'
      - File
    doc: Path to the index.
    outputBinding:
      glob: $(inputs.index)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmap:1.3.0--h9948957_4
