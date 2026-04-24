cwlVersion: v1.2
class: CommandLineTool
baseCommand: breadth_depth.py
label: cmseq_breadth_depth.py
doc: "calculate the Breadth and Depth of coverage of BAMFILE.\n\nTool homepage: https://github.com/SegataLab/cmseq"
inputs:
  - id: bamfile
    type: File
    doc: The file on which to operate
    inputBinding:
      position: 1
  - id: combine
    type:
      - 'null'
      - boolean
    doc: Combine all contigs into one giant contig and report it at the end
    inputBinding:
      position: 102
      prefix: --combine
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
  - id: mincov
    type:
      - 'null'
      - int
    doc: Minimum position coverage to perform the polymorphism calculation. 
      Position with a lower depth of coverage will be discarded (i.e. considered
      as zero-coverage positions). This is calculated AFTER --minqual.
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum Reference Length for a reference to be considered
    inputBinding:
      position: 102
      prefix: --minlen
  - id: minqual
    type:
      - 'null'
      - int
    doc: Minimum base quality. Bases with quality score lower than this will be 
      discarded. This is performed BEFORE --mincov.
    inputBinding:
      position: 102
      prefix: --minqual
  - id: sortindex
    type:
      - 'null'
      - boolean
    doc: Sort and index the file
    inputBinding:
      position: 102
      prefix: --sortindex
  - id: truncate
    type:
      - 'null'
      - int
    doc: Number of nucleotides that are truncated at either contigs end before 
      calculating coverage values.
    inputBinding:
      position: 102
      prefix: --truncate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
stdout: cmseq_breadth_depth.py.out
