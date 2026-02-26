cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan-find
label: tinscan_tinscan-find
doc: "Parse whole genome alignments for signatures of transposon insertion.\n\nTool
  homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs:
  - id: gffout
    type:
      - 'null'
      - File
    doc: Write features to this file as gff3.
    inputBinding:
      position: 101
      prefix: --gffOut
  - id: infile
    type: File
    doc: Input file containing tab delimited LASTZ alignment data.
    inputBinding:
      position: 101
      prefix: --infile
  - id: max_ident_diff
    type:
      - 'null'
      - float
    doc: Maximum divergence in identity (to query) allowed between insert 
      flanking sequences.
    inputBinding:
      position: 101
      prefix: --maxIdentDiff
  - id: max_insert
    type:
      - 'null'
      - int
    doc: Maximum length of sequence to consider as an insertion event.
    inputBinding:
      position: 101
      prefix: --maxInsert
  - id: max_tsd
    type:
      - 'null'
      - int
    doc: 'Maximum overlap of insertion flanking sequences in QUERY genome to be considered
      as target site duplication. Flank pairs with greater overlaps will be discarded
      Note: Setting this value too high may result in tandem duplications in the target
      genome being falsely classified as insertion events.'
    inputBinding:
      position: 101
      prefix: --maxTSD
  - id: min_ident
    type:
      - 'null'
      - float
    doc: Minimum identity for a hit to be considered.
    inputBinding:
      position: 101
      prefix: --minIdent
  - id: min_insert
    type:
      - 'null'
      - int
    doc: 'Minimum length of sequence to consider as an insertion event. Note: If too
      short may detect small non-TE indels.'
    inputBinding:
      position: 101
      prefix: --minInsert
  - id: noflanks
    type:
      - 'null'
      - boolean
    doc: If set, do not report flanking hit regions in GFF.
    inputBinding:
      position: 101
      prefix: --noflanks
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Optional: Directory to write output to.'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: q_gap
    type:
      - 'null'
      - int
    doc: Maximum gap allowed between aligned flanks in QUERY sequence. 
      Equivalent to target sequence deleted upon insertion event.
    inputBinding:
      position: 101
      prefix: --qGap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan_tinscan-find.out
