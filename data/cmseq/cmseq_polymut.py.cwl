cwlVersion: v1.2
class: CommandLineTool
baseCommand: polymut.py
label: cmseq_polymut.py
doc: "Reports the polymorphic rate of each reference (polymorphic bases / total bases).
  Focuses only on covered regions (i.e. depth >= 1)\n\nTool homepage: https://github.com/SegataLab/cmseq"
inputs:
  - id: bam_file
    type: File
    doc: The file on which to operate
    inputBinding:
      position: 1
  - id: contig
    type:
      - 'null'
      - string
    doc: Focus on a subset of references in the BAM file. Can be a list of 
      references separated by commas or a FASTA file (the IDs are used to 
      subset)
    inputBinding:
      position: 102
      prefix: --contig
  - id: dominant_frq_thrsh
    type:
      - 'null'
      - float
    doc: Cutoff for degree of `allele dominance` for a position to be considered
      polymorphic.
    default: 0.8
    inputBinding:
      position: 102
      prefix: --dominant_frq_thrsh
  - id: exclude_reads
    type:
      - 'null'
      - boolean
    doc: 'If set unmapped (FUNMAP), secondary (FSECONDARY), qc-fail (FQCFAIL) and
      duplicate (FDUP) are excluded. If unset ALL reads are considered (bedtools genomecov
      style). Default: unset'
    inputBinding:
      position: 102
      prefix: -f
  - id: gff_file
    type:
      - 'null'
      - File
    doc: GFF file used to extract protein-coding genes
    inputBinding:
      position: 102
      prefix: --gff_file
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum position coverage to perform the polymorphism calculation. 
      Position with a lower depth of coverage will be discarded (i.e. considered
      as zero-coverage positions). This is calculated AFTER --minqual.
    default: 1
    inputBinding:
      position: 102
      prefix: --mincov
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum Reference Length for a reference to be considered.
    default: 0
    inputBinding:
      position: 102
      prefix: --minlen
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality. Bases with quality score lower than this will be 
      discarded. This is performed BEFORE --mincov.
    default: 30
    inputBinding:
      position: 102
      prefix: --minqual
  - id: sort_index
    type:
      - 'null'
      - boolean
    doc: Sort and index the file
    inputBinding:
      position: 102
      prefix: --sortindex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
stdout: cmseq_polymut.py.out
