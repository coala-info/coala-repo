cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_circularity.pl
label: sprai_check_circularity.pl
doc: "Check for circularity in a FASTA assembly. A contig whose ends overlap is reported
  as circular and written, cut at the overlap, to the temporary directory.\n\nTool
  homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Remove the temporary directory first if it already exists
    inputBinding:
      position: 1
      prefix: --force
  - id: max_read_len
    type:
      - 'null'
      - int
    doc: Maximum read length; no reads are assumed to be longer (default 30000)
    inputBinding:
      position: 1
      prefix: --max_read_len
  - id: min_overlap_len
    type:
      - 'null'
      - int
    doc: Minimum overlap length of contig ends for a circular chromosome (default
      1500)
    inputBinding:
      position: 1
      prefix: --min_overlap_len
  - id: min_overlap_ratio
    type:
      - 'null'
      - float
    doc: Minimum match ratio of the overlap (default 0.97)
    inputBinding:
      position: 1
      prefix: --min_overlap_ratio
  - id: alt_overlap_ratio
    type:
      - 'null'
      - float
    doc: Match ratio below which an overlap is not reported (default 0.90)
    inputBinding:
      position: 1
      prefix: --alt_overlap_ratio
  - id: max_hang_len
    type:
      - 'null'
      - int
    doc: Maximum length of bad sequence at both ends of a circular contig 
      (default 100)
    inputBinding:
      position: 1
      prefix: --max_hang_len
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages
    inputBinding:
      position: 1
      prefix: --debug
  - id: input_fasta
    type: File
    doc: Input FASTA file containing the assembly
    inputBinding:
      position: 2
  - id: temporary_dir
    type: string
    doc: Directory for temporary files; it must not exist and is created by the tool
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: One line per sequence with its circular or linear status
  - id: temporary_directory
    type: Directory
    doc: Directory with the split contigs and the cut circular contigs
    outputBinding:
      glob: $(inputs.temporary_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_check_circularity.pl.out
