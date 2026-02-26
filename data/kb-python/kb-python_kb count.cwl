cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kb
  - count
label: kb-python_kb count
doc: "Generate count matrices from a set of single-cell FASTQ files. Run `kb --list`\n\
  to view single-cell technology information.\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: fastqs
    type:
      type: array
      items: File
    doc: "FASTQ files. For technology `SMARTSEQ`, all input\nFASTQs are alphabetically
      sorted by path and paired in\norder, and cell IDs are assigned as incrementing\n\
      integers starting from zero. A single batch TSV with\ncell ID, read 1, and read
      2 as columns can be provided\nto override this behavior."
    inputBinding:
      position: 1
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "Map to index generated from FASTA-file containing\namino acid sequences"
    inputBinding:
      position: 102
      prefix: --aa
  - id: batch_barcodes
    type:
      - 'null'
      - boolean
    doc: "When a batch file is supplied, store sample\nidentifiers in barcodes"
    inputBinding:
      position: 102
      prefix: --batch-barcodes
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstraps to perform
    inputBinding:
      position: 102
      prefix: --bootstraps
  - id: bustools
    type:
      - 'null'
      - File
    doc: "Path to bustools binary to use (default:\n/usr/local/lib/python3.12/site-\n\
      packages/kb_python/bins/linux/bustools/bustools)"
    inputBinding:
      position: 102
      prefix: --bustools
  - id: cellranger
    type:
      - 'null'
      - boolean
    doc: "Convert count matrices to cellranger-compatible\nformat. For nac/lamanno
      workflows, automatically\ncreates spliced/ and unspliced/ subdirectories. Gzip\n\
      compression is enabled by default (use --no-gzip to\ndisable)"
    inputBinding:
      position: 102
      prefix: --cellranger
  - id: cram
    type:
      - 'null'
      - boolean
    doc: "Convert BAM output to CRAM format (requires\n--genomebam). CRAM provides
      better compression than\nBAM."
    inputBinding:
      position: 102
      prefix: --cram
  - id: delete_bus
    type:
      - 'null'
      - boolean
    doc: "Delete intermediate BUS files after successful count\nto save disk space"
    inputBinding:
      position: 102
      prefix: --delete-bus
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: exact_barcodes
    type:
      - 'null'
      - boolean
    doc: "Only exact matches are used for matching barcodes to\non-list."
    inputBinding:
      position: 102
      prefix: --exact-barcodes
  - id: filter
    type:
      - 'null'
      - string
    doc: "Produce a filtered gene count matrix (default:\nbustools)"
    default: bustools
    inputBinding:
      position: 102
      prefix: --filter
  - id: filter_threshold
    type:
      - 'null'
      - string
    doc: 'Barcode filter threshold (default: auto)'
    default: auto
    inputBinding:
      position: 102
      prefix: --filter-threshold
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: Mean length of fragments. Only for single-end.
    inputBinding:
      position: 102
      prefix: --fragment-l
  - id: fragment_stddev
    type:
      - 'null'
      - int
    doc: "Standard deviation of fragment lengths. Only for\nsingle-end."
    inputBinding:
      position: 102
      prefix: --fragment-s
  - id: gene_names
    type:
      - 'null'
      - boolean
    doc: "Group counts by gene names instead of gene IDs when\ngenerating the loom
      or h5ad file"
    inputBinding:
      position: 102
      prefix: --gene-names
  - id: genomebam
    type:
      - 'null'
      - boolean
    doc: "Generate genome-aligned BAM file from\npseudoalignments. Requires --gtf
      to be specified.\n--chromosomes is recommended."
    inputBinding:
      position: 102
      prefix: --genomebam
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Gzip compress output matrices (matrix.mtx.gz,\nbarcodes.tsv.gz, genes.tsv.gz).
      Automatically enabled\nwith --cellranger"
    inputBinding:
      position: 102
      prefix: --gzip
  - id: h5ad
    type:
      - 'null'
      - boolean
    doc: Generate h5ad file from count matrix
    inputBinding:
      position: 102
      prefix: --h5ad
  - id: index
    type: File
    doc: Path to kallisto index
    inputBinding:
      position: 102
      prefix: -i
  - id: inleaved
    type:
      - 'null'
      - boolean
    doc: Specifies that input is an interleaved FASTQ file
    inputBinding:
      position: 102
      prefix: --inleaved
  - id: kallisto
    type:
      - 'null'
      - File
    doc: "Path to kallisto binary to use (default:\n/usr/local/lib/python3.12/site-\n\
      packages/kb_python/bins/linux/kallisto/kallisto)"
    inputBinding:
      position: 102
      prefix: --kallisto
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete the tmp directory
    inputBinding:
      position: 102
      prefix: --keep-tmp
  - id: long
    type:
      - 'null'
      - boolean
    doc: Use lr-kallisto for long-read mapping
    inputBinding:
      position: 102
      prefix: --long
  - id: loom
    type:
      - 'null'
      - boolean
    doc: Generate loom file from count matrix
    inputBinding:
      position: 102
      prefix: --loom
  - id: loom_names
    type:
      - 'null'
      - string
    doc: "Names for col_attrs and row_attrs in loom file\n(default: barcode,target_name).
      Use --loom-\nnames=velocyto for velocyto-compatible loom files"
    default: barcode,target_name
    inputBinding:
      position: 102
      prefix: --loom-names
  - id: matrix_to_directories
    type:
      - 'null'
      - boolean
    doc: "Reorganize matrix output into abundance tsv files\nacross multiple directories"
    inputBinding:
      position: 102
      prefix: --matrix-to-directories
  - id: matrix_to_files
    type:
      - 'null'
      - boolean
    doc: Reorganize matrix output into abundance tsv files
    inputBinding:
      position: 102
      prefix: --matrix-to-files
  - id: memory
    type:
      - 'null'
      - string
    doc: "Maximum memory used (default: 2G for standard, 4G for\nothers)"
    default: 2G for standard, 4G for others
    inputBinding:
      position: 102
      prefix: -m
  - id: mm
    type:
      - 'null'
      - boolean
    doc: "Include reads that pseudoalign to multiple genes.\nAutomatically enabled
      when generating a TCC matrix."
    inputBinding:
      position: 102
      prefix: --mm
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: Disable gzip compression for cellranger matrices
    inputBinding:
      position: 102
      prefix: --no-gzip
  - id: num
    type:
      - 'null'
      - boolean
    doc: Store read numbers in BUS file
    inputBinding:
      position: 102
      prefix: --num
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to process from supplied input
    inputBinding:
      position: 102
      prefix: -N
  - id: onlist
    type:
      - 'null'
      - File
    doc: "Path to file of on-listed barcodes to correct to. If\nnot provided and bustools
      supports the technology, a\npre-packaged on-list is used. Otherwise, the bustools\n\
      allowlist command is used. Specify NONE to bypass\nbarcode error correction.
      (`kb --list` to view on-\nlists)"
    inputBinding:
      position: 102
      prefix: -w
  - id: opt_off
    type:
      - 'null'
      - boolean
    doc: Disable performance optimizations
    inputBinding:
      position: 102
      prefix: --opt-off
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output.bus file
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: parity
    type:
      - 'null'
      - string
    doc: "Parity of the input files. Choices are `single` for\nsingle-end and `paired`
      for paired-end reads."
    inputBinding:
      position: 102
      prefix: --parity
  - id: platform
    type:
      - 'null'
      - string
    doc: 'Set platform for lr-kallisto (default: ONT)'
    default: ONT
    inputBinding:
      position: 102
      prefix: --platform
  - id: replacement
    type:
      - 'null'
      - File
    doc: "Path to file of a replacement list to correct to. In\nthe file, the first
      column is the original barcode and\nsecond is the replacement sequence"
    inputBinding:
      position: 102
      prefix: -r
  - id: report
    type:
      - 'null'
      - boolean
    doc: "Generate a HTML report containing run statistics and\nbasic plots. Using
      this option may cause kb to use\nmore memory than specified with the `-m` option.
      It\nmay also cause it to crash due to memory."
    inputBinding:
      position: 102
      prefix: --report
  - id: strand
    type:
      - 'null'
      - string
    doc: 'Strandedness (default: see `kb --list`)'
    default: see `kb --list`
    inputBinding:
      position: 102
      prefix: --strand
  - id: sum
    type:
      - 'null'
      - string
    doc: "Produced summed count matrices (Options: none, cell,\nnucleus, total). Use
      `cell` to add ambiguous and\nprocessed transcript matrices. Use `nucleus` to
      add\nambiguous and unprocessed transcript matrices. Use\n`total` to add all
      three matrices together. (Default:\nnone)"
    default: none
    inputBinding:
      position: 102
      prefix: --sum
  - id: t2c_mature
    type:
      - 'null'
      - File
    doc: Path to mature transcripts-to-capture
    inputBinding:
      position: 102
      prefix: -c1
  - id: t2c_nascent
    type:
      - 'null'
      - File
    doc: Path to nascent transcripts-to-captured
    inputBinding:
      position: 102
      prefix: -c2
  - id: t2g
    type: File
    doc: Path to transcript-to-gene mapping
    inputBinding:
      position: 102
      prefix: -g
  - id: tcc
    type:
      - 'null'
      - boolean
    doc: Generate a TCC matrix instead of a gene count matrix.
    inputBinding:
      position: 102
      prefix: --tcc
  - id: technology
    type: string
    doc: Single-cell technology used (`kb --list` to view)
    inputBinding:
      position: 102
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 8)'
    default: 8
    inputBinding:
      position: 102
      prefix: -t
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Set threshold for lr-kallisto read mapping (default:\n0.8)"
    default: 0.8
    inputBinding:
      position: 102
      prefix: --threshold
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Override default temporary directory
    inputBinding:
      position: 102
      prefix: --tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debugging information
    inputBinding:
      position: 102
      prefix: --verbose
  - id: workflow
    type:
      - 'null'
      - string
    doc: "Type of workflow. Use `nac` to specify a nac index for\nproducing mature/nascent/ambiguous
      matrices. Use\n`kite` for feature barcoding. Use `kite:10xFB` for 10x\nGenomics
      Feature Barcoding technology. (default:\nstandard)"
    default: standard
    inputBinding:
      position: 102
      prefix: --workflow
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Path to output directory (default: current directory)'
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
