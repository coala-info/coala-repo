cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2cov.pl
label: seq2c_seq2cov.pl
doc: "Calculate candidate variance for a given region(s) in an indexed BAM file. The
  default input is IGV's one or more entries in refGene.txt, but can be regions.\n\
  \nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs:
  - id: region_info
    type: File
    doc: Input region information file (e.g., refGene.txt or BED file)
    inputBinding:
      position: 1
  - id: amplicon_params
    type:
      - 'null'
      - string
    doc: 'Indicate PCR amplicon based calling. Format: int:float (e.g., 10:0.95).
      Defines base pair distance and overlap fraction to assign reads to amplicons.'
    inputBinding:
      position: 102
      prefix: -a
  - id: bam_file
    type:
      - 'null'
      - File
    doc: The indexed BAM file
    inputBinding:
      position: 102
      prefix: -b
  - id: chr_column
    type:
      - 'null'
      - int
    doc: The column index for chromosome
    inputBinding:
      position: 102
      prefix: -c
  - id: end_column
    type:
      - 'null'
      - int
    doc: The column index for region end, e.g. gene end
    inputBinding:
      position: 102
      prefix: -E
  - id: extend_nucleotides
    type:
      - 'null'
      - int
    doc: The number of nucleotides to extend for each segment
    inputBinding:
      position: 102
      prefix: -x
  - id: gene_column
    type:
      - 'null'
      - int
    doc: The column index for gene name
    inputBinding:
      position: 102
      prefix: -g
  - id: name_regex
    type:
      - 'null'
      - string
    doc: The regular expression to extract sample name from bam filename
    inputBinding:
      position: 102
      prefix: -n
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Set the sample name directly (mutually exclusive to -n)
    inputBinding:
      position: 102
      prefix: -N
  - id: seg_ends_column
    type:
      - 'null'
      - int
    doc: The column index for segment ends in the region, e.g. exon ends
    inputBinding:
      position: 102
      prefix: -e
  - id: seg_starts_column
    type:
      - 'null'
      - int
    doc: The column index for segment starts in the region, e.g. exon starts
    inputBinding:
      position: 102
      prefix: -s
  - id: start_column
    type:
      - 'null'
      - int
    doc: The column index for region start, e.g. gene start
    inputBinding:
      position: 102
      prefix: -S
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Indicate whether it's zero based numbering (default is 1-based)
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c_seq2cov.pl.out
