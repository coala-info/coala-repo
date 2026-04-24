cwlVersion: v1.2
class: CommandLineTool
baseCommand: sinto fragments
label: sinto_fragments
doc: "Create ATAC-seq fragment file from BAM file\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    doc: Input bam file (must be indexed)
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcode_regex
    type:
      - 'null'
      - string
    doc: Regular expression used to extract cell barcode from read name. If None
      (default), extract cell barcode from read tag. Use "[^:]*" to match all 
      characters up to the first colon.
    inputBinding:
      position: 101
      prefix: --barcode_regex
  - id: barcodetag
    type:
      - 'null'
      - string
    doc: Read tag storing cell barcode information (default = "CB")
    inputBinding:
      position: 101
      prefix: --barcodetag
  - id: cells
    type:
      - 'null'
      - string
    doc: Path to file containing cell barcodes to retain, or a comma-separated 
      list of cell barcodes. If None (default), use all cell barocodes present 
      in the BAM file.
    inputBinding:
      position: 101
      prefix: --cells
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of BAM file entries to iterate over before collapsing the 
      fragments and writing to disk. Higher chunksize will use more memory but 
      will be faster.
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: collapse_within
    type:
      - 'null'
      - boolean
    doc: Take cell barcode into account when collapsing duplicate fragments. 
      Setting this flag means that fragments with the same coordinates can be 
      identified provided they originate from a different cell barcode.
    inputBinding:
      position: 101
      prefix: --collapse_within
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between integration sites for the fragment to be 
      retained. Allows filtering of implausible fragments that likely result 
      from incorrect mapping positions. Default is 5000 bp.
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: min_distance
    type:
      - 'null'
      - int
    doc: Minimum distance between integration sites for the fragment to be 
      retained. Allows filtering of implausible fragments that likely result 
      from incorrect mapping positions. Default is 10 bp.
    inputBinding:
      position: 101
      prefix: --min_distance
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ required to retain fragment (default = 30)
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors (default = 1)
    inputBinding:
      position: 101
      prefix: --nproc
  - id: shift_minus
    type:
      - 'null'
      - int
    doc: Number of bases to shift Tn5 insertion position by on the reverse 
      strand.
    inputBinding:
      position: 101
      prefix: --shift_minus
  - id: shift_plus
    type:
      - 'null'
      - int
    doc: Number of bases to shift Tn5 insertion position by on the forward 
      strand.
    inputBinding:
      position: 101
      prefix: --shift_plus
  - id: use_chrom
    type:
      - 'null'
      - string
    doc: Regular expression used to match chromosomes to be included in output. 
      Default is "(?i)^chr" to match all chromosomes starting with "chr", case 
      insensitive
    inputBinding:
      position: 101
      prefix: --use_chrom
outputs:
  - id: fragments_output
    type: File
    doc: Name and path for output fragments file. Note that the output is not 
      sorted or compressed. To sort the output file use sort -k 1,1 -k2,2n
    outputBinding:
      glob: $(inputs.fragments_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
