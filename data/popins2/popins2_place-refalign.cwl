cwlVersion: v1.2
class: CommandLineTool
baseCommand: popins2 place-refalign
label: popins2_place-refalign
doc: "Contig placing by alignment of contig ends to reference genome.\n\nTool homepage:
  https://github.com/kehrlab/PopIns2"
inputs:
  - id: contigs
    type:
      - 'null'
      - File
    doc: 'Name of supercontigs file. Valid filetypes are: fa, fna, and fasta.'
    default: supercontigs.fa
    inputBinding:
      position: 101
      prefix: --contigs
  - id: groups
    type:
      - 'null'
      - File
    doc: Name of file containing groups of contigs that can be placed at the 
      same position and whose prefixes/suffixes align.
    default: groups.txt
    inputBinding:
      position: 101
      prefix: --groups
  - id: locations
    type:
      - 'null'
      - File
    doc: Name of merged locations file.
    default: locations.txt
    inputBinding:
      position: 101
      prefix: --locations
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: The maximum expected insert size of the read pairs.
    default: 800
    inputBinding:
      position: 101
      prefix: --maxInsertSize
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimal number of anchoring read pairs for a location.
    default: 2
    inputBinding:
      position: 101
      prefix: --minReads
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimal anchoring score for a location. In range [0..1].
    default: 0.3
    inputBinding:
      position: 101
      prefix: --minScore
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories.
    default: .
    inputBinding:
      position: 101
      prefix: --prefix
  - id: read_length
    type:
      - 'null'
      - int
    doc: The length of the reads.
    default: 100
    inputBinding:
      position: 101
      prefix: --readLength
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Name of reference genome file. Valid filetypes are: fa, fna, and fasta.'
    default: genome.fa
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: insertions
    type:
      - 'null'
      - File
    doc: 'Name of VCF output file. Valid filetype is: vcf.'
    outputBinding:
      glob: $(inputs.insertions)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
