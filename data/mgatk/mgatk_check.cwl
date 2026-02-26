cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgatk
  - check
label: mgatk_check
doc: "mgatk: a mitochondrial genome analysis toolkit. check mode.\n\nTool homepage:
  https://github.com/caleblareau/mgatk"
inputs:
  - id: alignment_quality
    type:
      - 'null'
      - int
    doc: Minimum alignment quality to include read in genotype.
    default: 0
    inputBinding:
      position: 101
      prefix: --alignment-quality
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Read tag (generally two letters) to separate single cells; valid and 
      required only in `bcall` mode.
    inputBinding:
      position: 101
      prefix: --barcode-tag
  - id: barcodes
    type:
      - 'null'
      - File
    doc: File path to barcodes that will be extracted; useful only in `bcall` 
      mode.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: base_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality for inclusion in the genotype count.
    default: 0
    inputBinding:
      position: 101
      prefix: --base-qual
  - id: cluster
    type:
      - 'null'
      - string
    doc: Message to send to Snakemake to execute jobs on cluster interface; see 
      documentation.
    inputBinding:
      position: 101
      prefix: --cluster
  - id: emit_base_qualities
    type:
      - 'null'
      - boolean
    doc: Output mean base quality per alt allele as part of the final output.
    inputBinding:
      position: 101
      prefix: --emit-base-qualities
  - id: handle_overlap
    type:
      - 'null'
      - boolean
    doc: Only count each base in the overlap region between a pair of reads once
    inputBinding:
      position: 101
      prefix: --handle-overlap
  - id: ignore_samples
    type:
      - 'null'
      - string
    doc: Comma separated list of sample names to ignore; Sample refers to 
      basename of .bam file
    default: NONE
    inputBinding:
      position: 101
      prefix: --ignore-samples
  - id: input
    type: File
    doc: Input; either directory of singular .bam file; see documentation. 
      REQUIRED.
    inputBinding:
      position: 101
      prefix: --input
  - id: jobs
    type:
      - 'null'
      - int
    doc: Max number of jobs to be running concurrently on the cluster interface.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Retained dupliate (presumably PCR) reads
    inputBinding:
      position: 101
      prefix: --keep-duplicates
  - id: keep_qc_bams
    type:
      - 'null'
      - boolean
    doc: Add this flag to keep the quality-controlled bams after processing.
    inputBinding:
      position: 101
      prefix: --keep-qc-bams
  - id: keep_samples
    type:
      - 'null'
      - string
    doc: Comma separated list of sample names to keep; Sample refers to basename
      of .bam file
    default: ALL
    inputBinding:
      position: 101
      prefix: --keep-samples
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Add this flag to keep all intermediate files.
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: low_coverage_threshold
    type:
      - 'null'
      - int
    doc: Variant count for each cell will be ignored below this when calculating
      VMR
    inputBinding:
      position: 101
      prefix: --low-coverage-threshold
  - id: max_javamem
    type:
      - 'null'
      - string
    doc: Maximum memory for java for running duplicate removal per core.
    default: 8000m
    inputBinding:
      position: 101
      prefix: --max-javamem
  - id: min_barcode_reads
    type:
      - 'null'
      - int
    doc: Minimum number of mitochondrial reads for a barcode to be genotyped; 
      useful only in `bcall` mode.
    default: 1000
    inputBinding:
      position: 101
      prefix: --min-barcode-reads
  - id: mito_genome
    type: string
    doc: mitochondrial genome configuration. Choose hg19, hg38, mm10, (etc.) or 
      a custom .fasta file; see documentation.
    default: rCRS
    inputBinding:
      position: 101
      prefix: --mito-genome
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix for project name.
    default: mgatk
    inputBinding:
      position: 101
      prefix: --name
  - id: ncells_bg
    type:
      - 'null'
      - int
    doc: number of "background" cells to use for CellBender.
    default: 20000
    inputBinding:
      position: 101
      prefix: --ncells_bg
  - id: ncells_fg
    type:
      - 'null'
      - int
    doc: number of "foreground" cells to use for CellBender.
    default: 1000
    inputBinding:
      position: 101
      prefix: --ncells_fg
  - id: ncores
    type:
      - 'null'
      - int
    doc: Number of cores to run the main job in parallel.
    inputBinding:
      position: 101
      prefix: --ncores
  - id: nh_max
    type:
      - 'null'
      - int
    doc: Maximum number of read alignments allowed as governed by the NH flag.
    default: 1
    inputBinding:
      position: 101
      prefix: --NHmax
  - id: nm_max
    type:
      - 'null'
      - int
    doc: Maximum number of paired mismatches allowed represented by the NM/nM 
      tags.
    default: 4
    inputBinding:
      position: 101
      prefix: --NMmax
  - id: nsamples
    type:
      - 'null'
      - int
    doc: The number of samples / cells to be processed per iteration; Supply 0 
      to try all.
    default: 7000
    inputBinding:
      position: 101
      prefix: --nsamples
  - id: proper_pairs
    type:
      - 'null'
      - boolean
    doc: Require reads to be properly paired.
    inputBinding:
      position: 101
      prefix: --proper-pairs
  - id: skip_r
    type:
      - 'null'
      - boolean
    doc: Generate plain-text only output. Otherwise, this generates a .rds 
      obejct that can be immediately read into R for downstream analysis.
    inputBinding:
      position: 101
      prefix: --skip-R
  - id: snake_stdout
    type:
      - 'null'
      - boolean
    doc: Write snakemake log to sdout rather than a file.
    inputBinding:
      position: 101
      prefix: --snake-stdout
  - id: umi_barcode
    type:
      - 'null'
      - string
    doc: Read tag (generally two letters) to specify the UMI tag when removing 
      duplicates for genotyping.
    inputBinding:
      position: 101
      prefix: --umi-barcode
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for analysis required for `call` and `bcall`.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
