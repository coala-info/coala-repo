cwlVersion: v1.2
class: CommandLineTool
baseCommand: maegatk
label: maegatk_support
doc: "a Maester genome toolkit.\n\nTool homepage: https://github.com/caleblareau/maegatk"
inputs:
  - id: mode
    type: string
    doc: MODE = ['bcall', 'support']
    inputBinding:
      position: 1
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Read tag (generally two letters) to separate single cells; valid and 
      required only in `bcall` mode.
    inputBinding:
      position: 102
      prefix: --barcode-tag
  - id: barcodes_file
    type:
      - 'null'
      - File
    doc: File path to barcodes that will be extracted; useful only in `bcall` 
      mode.
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: cluster
    type:
      - 'null'
      - string
    doc: Message to send to Snakemake to execute jobs on cluster interface; see 
      documentation.
    inputBinding:
      position: 102
      prefix: --cluster
  - id: ignore_samples
    type:
      - 'null'
      - string
    doc: Comma separated list of sample names to ignore; NONE (special string) 
      by default. Sample refers to basename of .bam file
    inputBinding:
      position: 102
      prefix: --ignore-samples
  - id: input_file
    type: File
    doc: Input; a singular, indexed bam file.
    inputBinding:
      position: 102
      prefix: --input
  - id: jobs
    type:
      - 'null'
      - string
    doc: Max number of jobs to be running concurrently on the cluster interface.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: keep_qc_bams
    type:
      - 'null'
      - boolean
    doc: Add this flag to keep the quality-controlled bams after processing.
    inputBinding:
      position: 102
      prefix: --keep-qc-bams
  - id: keep_samples
    type:
      - 'null'
      - string
    doc: Comma separated list of sample names to keep; ALL (special string) by 
      default. Sample refers to basename of .bam file
    inputBinding:
      position: 102
      prefix: --keep-samples
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files.
    inputBinding:
      position: 102
      prefix: --keep-temp-files
  - id: max_javamem
    type:
      - 'null'
      - string
    doc: Maximum memory for java for running duplicate removal.
    default: 4000m
    inputBinding:
      position: 102
      prefix: --max-javamem
  - id: max_nh_flag_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of read alignments allowed as governed by the NH flag.
    default: 2
    inputBinding:
      position: 102
      prefix: --NHmax
  - id: max_nm_tag_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of paired mismatches allowed represented by the NM/nM 
      tags.
    default: 15
    inputBinding:
      position: 102
      prefix: --NMmax
  - id: min_alignment_quality
    type:
      - 'null'
      - int
    doc: Minimum alignment quality to include read in genotype.
    default: 0
    inputBinding:
      position: 102
      prefix: --alignment-quality
  - id: min_barcode_reads
    type:
      - 'null'
      - int
    doc: Minimum number of mitochondrial reads for a barcode to be genotyped; 
      useful only in `bcall` mode; will not overwrite the `--barcodes` logic.
    inputBinding:
      position: 102
      prefix: --min-barcode-reads
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for inclusion in the genotype count.
    default: 0
    inputBinding:
      position: 102
      prefix: --base-qual
  - id: min_supporting_reads
    type:
      - 'null'
      - int
    doc: Minimum number of supporting reads to call a consensus UMI/rread.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: mito_genome_config
    type: string
    doc: mitochondrial genome configuration. Requires bwa indexed fasta file or 
      `rCRS` (built-in)
    inputBinding:
      position: 102
      prefix: --mito-genome
  - id: ncores
    type:
      - 'null'
      - string
    doc: Number of cores to run the main job in parallel.
    inputBinding:
      position: 102
      prefix: --ncores
  - id: num_samples_per_iteration
    type:
      - 'null'
      - int
    doc: The number of samples / cells to be processed per iteration; default is
      all.
    inputBinding:
      position: 102
      prefix: --nsamples
  - id: project_name
    type:
      - 'null'
      - string
    doc: Prefix for project name
    inputBinding:
      position: 102
      prefix: --name
  - id: skip_barcodesplit
    type:
      - 'null'
      - boolean
    doc: Skip the time consuming barcode-splitting step if it finished 
      successfully before
    inputBinding:
      position: 102
      prefix: --skip-barcodesplit
  - id: skip_r_output
    type:
      - 'null'
      - boolean
    doc: Generate plain-text only output. Otherwise, this generates a .rds 
      obejct that can be immediately read into R for downstream analysis.
    inputBinding:
      position: 102
      prefix: --skip-R
  - id: snake_stdout
    type:
      - 'null'
      - boolean
    doc: Write snakemake log to sdout rather than a file.
    inputBinding:
      position: 102
      prefix: --snake-stdout
  - id: umi_barcode_tag
    type:
      - 'null'
      - string
    doc: Read tag (generally two letters) to specify the UMI tag when removing 
      duplicates for genotyping.
    inputBinding:
      position: 102
      prefix: --umi-barcode
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for genotypes.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maegatk:0.2.0--pyhdfd78af_2
