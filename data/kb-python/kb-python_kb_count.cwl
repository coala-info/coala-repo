cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kb
  - count
label: kb-python_kb_count
doc: "Generate count matrices from a set of single-cell FASTQ files\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: fastqs
    type:
      type: array
      items: File
    doc: "FASTQ files. For technology `SMARTSEQ`, all input FASTQs are alphabetically sorted by path and paired in order, and cell IDs are assigned as incrementing integers starting from zero. A single batch TSV with cell ID, read 1, and read 2 as columns can be provided to override this behavior."
    inputBinding:
      position: 1
  - id: tmp
    type:
      - 'null'
      - string
    doc: "Override default temporary directory"
    inputBinding:
      position: 102
      prefix: --tmp
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: "Do not delete the tmp directory"
    inputBinding:
      position: 102
      prefix: --keep-tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print debugging information"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: index
    type: File
    doc: "Path to kallisto index"
    inputBinding:
      position: 102
      prefix: -i
  - id: t2g
    type: File
    doc: "Path to transcript-to-gene mapping"
    inputBinding:
      position: 102
      prefix: -g
  - id: technology
    type: string
    doc: "Single-cell technology used (`kb --list` to view)"
    inputBinding:
      position: 102
      prefix: -x
  - id: out
    type: string
    default: kb_count_out
    doc: "Path to output directory (default: current directory)"
    inputBinding:
      position: 102
      prefix: -o
  - id: num
    type:
      - 'null'
      - boolean
    doc: "Store read numbers in BUS file"
    inputBinding:
      position: 102
      prefix: --num
  - id: onlist
    type:
      - 'null'
      - File
    doc: "Path to file of on-listed barcodes to correct to. Specify NONE to bypass barcode error correction."
    inputBinding:
      position: 102
      prefix: -w
  - id: exact_barcodes
    type:
      - 'null'
      - boolean
    doc: "Only exact matches are used for matching barcodes to on-list."
    inputBinding:
      position: 102
      prefix: --exact-barcodes
  - id: replacement
    type:
      - 'null'
      - File
    doc: "Path to file of a replacement list to correct to."
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 8)"
    inputBinding:
      position: 102
      prefix: -t
  - id: memory
    type:
      - 'null'
      - string
    doc: "Maximum memory used (default: 2G for standard, 4G for others)"
    inputBinding:
      position: 102
      prefix: -m
  - id: strand
    type:
      - 'null'
      - string
    doc: "Strandedness: unstranded, forward or reverse"
    inputBinding:
      position: 102
      prefix: --strand
  - id: inleaved
    type:
      - 'null'
      - boolean
    doc: "Specifies that input is an interleaved FASTQ file"
    inputBinding:
      position: 102
      prefix: --inleaved
  - id: genomebam
    type:
      - 'null'
      - boolean
    doc: "Generate genome-aligned BAM file from pseudoalignments. Requires --gtf to be specified. --chromosomes is recommended."
    inputBinding:
      position: 102
      prefix: --genomebam
  - id: cram
    type:
      - 'null'
      - boolean
    doc: "Convert BAM output to CRAM format (requires --genomebam)."
    inputBinding:
      position: 102
      prefix: --cram
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "Map to index generated from FASTA-file containing amino acid sequences"
    inputBinding:
      position: 102
      prefix: --aa
  - id: gtf
    type:
      - 'null'
      - File
    doc: "GTF file (needed with --genomebam)"
    inputBinding:
      position: 102
      prefix: --gtf
  - id: chromosomes
    type:
      - 'null'
      - File
    doc: "Chromosome sizes file (chrom.sizes), recommended with --genomebam"
    inputBinding:
      position: 102
      prefix: --chromosomes
  - id: workflow
    type:
      - 'null'
      - string
    doc: "Type of workflow: standard, nac, kite or kite:10xFB (default: standard)"
    inputBinding:
      position: 102
      prefix: --workflow
  - id: mm
    type:
      - 'null'
      - boolean
    doc: "Include reads that pseudoalign to multiple genes."
    inputBinding:
      position: 102
      prefix: --mm
  - id: tcc
    type:
      - 'null'
      - boolean
    doc: "Generate a TCC matrix instead of a gene count matrix."
    inputBinding:
      position: 102
      prefix: --tcc
  - id: filter
    type:
      - 'null'
      - string
    doc: "Produce a filtered gene count matrix (default: bustools)"
    inputBinding:
      position: 102
      prefix: --filter
  - id: filter_threshold
    type:
      - 'null'
      - string
    doc: "Barcode filter threshold (default: auto)"
    inputBinding:
      position: 102
      prefix: --filter-threshold
  - id: t2c_mature
    type:
      - 'null'
      - File
    doc: "Path to mature transcripts-to-capture (nac workflow)"
    inputBinding:
      position: 102
      prefix: -c1
  - id: t2c_nascent
    type:
      - 'null'
      - File
    doc: "Path to nascent transcripts-to-captured (nac workflow)"
    inputBinding:
      position: 102
      prefix: -c2
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing output.bus file"
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Dry run"
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: batch_barcodes
    type:
      - 'null'
      - boolean
    doc: "When a batch file is supplied, store sample identifiers in barcodes"
    inputBinding:
      position: 102
      prefix: --batch-barcodes
  - id: loom
    type:
      - 'null'
      - boolean
    doc: "Generate loom file from count matrix"
    inputBinding:
      position: 102
      prefix: --loom
  - id: h5ad
    type:
      - 'null'
      - boolean
    doc: "Generate h5ad file from count matrix"
    inputBinding:
      position: 102
      prefix: --h5ad
  - id: loom_names
    type:
      - 'null'
      - string
    doc: "Names for col_attrs and row_attrs in loom file (default: barcode,target_name)."
    inputBinding:
      position: 102
      prefix: --loom-names
  - id: sum
    type:
      - 'null'
      - string
    doc: "Produced summed count matrices (Options: none, cell, nucleus, total)."
    inputBinding:
      position: 102
      prefix: --sum
  - id: cellranger
    type:
      - 'null'
      - boolean
    doc: "Convert count matrices to cellranger-compatible format."
    inputBinding:
      position: 102
      prefix: --cellranger
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Gzip compress output matrices (matrix.mtx.gz, barcodes.tsv.gz, genes.tsv.gz)."
    inputBinding:
      position: 102
      prefix: --gzip
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: "Disable gzip compression for cellranger matrices"
    inputBinding:
      position: 102
      prefix: --no-gzip
  - id: delete_bus
    type:
      - 'null'
      - boolean
    doc: "Delete intermediate BUS files after successful count to save disk space"
    inputBinding:
      position: 102
      prefix: --delete-bus
  - id: gene_names
    type:
      - 'null'
      - boolean
    doc: "Group counts by gene names instead of gene IDs when generating the loom or h5ad file"
    inputBinding:
      position: 102
      prefix: --gene-names
  - id: num_reads
    type:
      - 'null'
      - int
    doc: "Maximum number of reads to process from supplied input"
    inputBinding:
      position: 102
      prefix: -N
  - id: report
    type:
      - 'null'
      - boolean
    doc: "Generate a HTML report containing run statistics and basic plots."
    inputBinding:
      position: 102
      prefix: --report
  - id: long
    type:
      - 'null'
      - boolean
    doc: "Use lr-kallisto for long-read mapping"
    inputBinding:
      position: 102
      prefix: --long
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Set threshold for lr-kallisto read mapping (default: 0.8)"
    inputBinding:
      position: 102
      prefix: --threshold
  - id: platform
    type:
      - 'null'
      - string
    doc: "Set platform for lr-kallisto: PacBio or ONT (default: ONT)"
    inputBinding:
      position: 102
      prefix: --platform
  - id: kallisto
    type:
      - 'null'
      - string
    doc: "Path to kallisto binary to use (inside the container)"
    inputBinding:
      position: 102
      prefix: --kallisto
  - id: bustools
    type:
      - 'null'
      - string
    doc: "Path to bustools binary to use (inside the container)"
    inputBinding:
      position: 102
      prefix: --bustools
  - id: opt_off
    type:
      - 'null'
      - boolean
    doc: "Disable performance optimizations"
    inputBinding:
      position: 102
      prefix: --opt-off
  - id: parity
    type:
      - 'null'
      - string
    doc: "Parity of the input files (BULK and SMARTSEQ2): single or paired"
    inputBinding:
      position: 102
      prefix: --parity
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: "Mean length of fragments. Only for single-end (BULK and SMARTSEQ2)."
    inputBinding:
      position: 102
      prefix: --fragment-l
  - id: fragment_stddev
    type:
      - 'null'
      - int
    doc: "Standard deviation of fragment lengths. Only for single-end (BULK and SMARTSEQ2)."
    inputBinding:
      position: 102
      prefix: --fragment-s
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: "Number of bootstraps to perform"
    inputBinding:
      position: 102
      prefix: --bootstraps
  - id: matrix_to_files
    type:
      - 'null'
      - boolean
    doc: "Reorganize matrix output into abundance tsv files"
    inputBinding:
      position: 102
      prefix: --matrix-to-files
  - id: matrix_to_directories
    type:
      - 'null'
      - boolean
    doc: "Reorganize matrix output into abundance tsv files across multiple directories"
    inputBinding:
      position: 102
      prefix: --matrix-to-directories
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the count matrices"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python_kb_count.out
