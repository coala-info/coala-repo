cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-count-barcodes
label: htseq_htseq-count-barcodes
doc: "This script takes one alignment file in SAM/BAM format and a feature file in
  GFF format and calculates for each feature the number of reads mapping to it, accounting
  for barcodes.\n\nTool homepage: https://github.com/htseq/htseq"
inputs:
  - id: samfilename
    type: File
    doc: Path to the SAM/BAM file containing the barcoded, mapped reads. If '-' 
      is selected, read from standard input
    inputBinding:
      position: 1
  - id: featuresfilename
    type: File
    doc: Path to the GTF file containing the features
    inputBinding:
      position: 2
  - id: add_chromosome_info
    type:
      - 'null'
      - boolean
    doc: Store information about the chromosome of each feature as an additional
      attribute (e.g. colunm in the TSV output file).
    inputBinding:
      position: 103
      prefix: --add-chromosome-info
  - id: additional_attr
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Additional feature attributes (default: none, suitable for Ensembl GTF files:
      gene_name). Use multiple times for each different attribute'
    inputBinding:
      position: 103
      prefix: --additional-attr
  - id: cell_barcode
    type:
      - 'null'
      - string
    doc: BAM tag used for the cell barcode (default compatible with 10X Genomics
      Chromium is CB).
    default: CB
    inputBinding:
      position: 103
      prefix: --cell-barcode
  - id: correct_umi_distance
    type:
      - 'null'
      - int
    doc: Correct for sequencing errors in the UMI tag, based on Hamming 
      distance. For each UMI, if another UMI with more reads within 1 or 2 
      mutations is found, merge this UMI's reads into the more popular one. The 
      default is to not correct UMIs.
    inputBinding:
      position: 103
      prefix: --correct-UMI-distance
  - id: counts_output_sparse
    type:
      - 'null'
      - boolean
    doc: Store the counts as a sparse matrix (mtx, h5ad, loom).
    inputBinding:
      position: 103
      prefix: --counts_output_sparse
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'Column delimiter in output (default: TAB).'
    default: TAB
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: format
    type:
      - 'null'
      - string
    doc: 'Type of <alignment_file> data. DEPRECATED: file format is detected automatically.
      This option is ignored.'
    inputBinding:
      position: 103
      prefix: --format
  - id: idattr
    type:
      - 'null'
      - string
    doc: 'GTF attribute to be used as feature ID (default, suitable for Ensembl GTF
      files: gene_id)'
    default: gene_id
    inputBinding:
      position: 103
      prefix: --idattr
  - id: max_reads_in_buffer
    type:
      - 'null'
      - int
    doc: When <alignment_file> is paired end sorted by position, allow only so 
      many reads to stay in memory until the mates are found (raising this 
      number will use more memory). Has no effect for single end or paired end 
      sorted by name
    inputBinding:
      position: 103
      prefix: --max-reads-in-buffer
  - id: minaqual
    type:
      - 'null'
      - int
    doc: 'Skip all reads with MAPQ alignment quality lower than the given minimum
      value (default: 10). MAPQ is the 5th column of a SAM/BAM file and its usage
      depends on the software used to map the reads.'
    default: 10
    inputBinding:
      position: 103
      prefix: --minaqual
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode to handle reads overlapping more than one feature (choices: union,
      intersection-strict, intersection-nonempty; default: union)'
    default: union
    inputBinding:
      position: 103
      prefix: --mode
  - id: nonunique
    type:
      - 'null'
      - string
    doc: Whether to score reads that are not uniquely aligned or ambiguously 
      assigned to features
    inputBinding:
      position: 103
      prefix: --nonunique
  - id: order
    type:
      - 'null'
      - string
    doc: "'pos' or 'name'. Sorting order of <alignment_file> (default: name). Paired-end
      sequencing data must be sorted either by position or by read name, and the sorting
      order must be specified. Ignored for single-end data."
    default: name
    inputBinding:
      position: 103
      prefix: --order
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress report
    inputBinding:
      position: 103
      prefix: --quiet
  - id: samout_format
    type:
      - 'null'
      - string
    doc: Format to use with the --samout option.
    inputBinding:
      position: 103
      prefix: --samout-format
  - id: secondary_alignments
    type:
      - 'null'
      - string
    doc: Whether to score secondary alignments (0x100 flag)
    inputBinding:
      position: 103
      prefix: --secondary-alignments
  - id: stranded
    type:
      - 'null'
      - string
    doc: "Whether the data is from a strand-specific assay. Specify 'yes', 'no', or
      'reverse' (default: yes). 'reverse' means 'yes' with reversed strand interpretation"
    default: yes
    inputBinding:
      position: 103
      prefix: --stranded
  - id: supplementary_alignments
    type:
      - 'null'
      - string
    doc: Whether to score supplementary alignments (0x800 flag)
    inputBinding:
      position: 103
      prefix: --supplementary-alignments
  - id: type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Feature type (3rd column in GTF file) to be used, all features of other
      type are ignored (default, suitable forEnsembl GTF files: exon). You can call
      this option multiple times. Features of all specified types will be included.'
    default: exon
    inputBinding:
      position: 103
      prefix: --type
  - id: umi
    type:
      - 'null'
      - string
    doc: BAM tag used for the unique molecular identifier, also known as 
      molecular barcode (default compatible with 10X Genomics Chromium is UB).
    default: UB
    inputBinding:
      position: 103
      prefix: --UMI
outputs:
  - id: samout
    type:
      - 'null'
      - File
    doc: Write out all SAM alignment records into aSAM/BAM file, annotating each
      line with its feature assignment (as an optional field with tag 'XF'). See
      the -p option to use BAM instead of SAM.
    outputBinding:
      glob: $(inputs.samout)
  - id: counts_output
    type:
      - 'null'
      - File
    doc: TSV/CSV filename to output the counts to instead of stdout.
    outputBinding:
      glob: $(inputs.counts_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0
