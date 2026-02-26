cwlVersion: v1.2
class: CommandLineTool
baseCommand: Snakealtpromoter
label: snakealtpromoter_Snakealtpromoter
doc: "Run a comprehensive pipeline for alternative promoter analysis.\n\nTool homepage:
  https://github.com/YidanSunResearchLab/SnakeAltPromoter"
inputs:
  - id: downsample_size
    type:
      - 'null'
      - int
    doc: "Number of valid pairs to downsample to for analysis.\nSet to 0 to disable
      downsampling (default: 0)."
    default: 0
    inputBinding:
      position: 101
      prefix: --downsample_size
  - id: fastqc
    type:
      - 'null'
      - boolean
    doc: Enable this flag if needs fastqc.
    inputBinding:
      position: 101
      prefix: --fastqc
  - id: genome_dir
    type: Directory
    doc: "Absolute path to the directory containing pre-\ngenerated genome files,
      created by the Genomesetup\nstep (e.g., /absolute/path/to/genomes/)."
    inputBinding:
      position: 101
      prefix: --genome_dir
  - id: input_dir
    type: Directory
    doc: "Path to the input directory containing paired-end\nFASTQ gz files (e.g.,
      /path/to/fastqs/)."
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: lfcshrink
    type:
      - 'null'
      - boolean
    doc: "Enable log2 fold change shrinkage during differential\nanalysis."
    inputBinding:
      position: 101
      prefix: --lfcshrink
  - id: max_gfc
    type:
      - 'null'
      - float
    doc: "Additional threshold of maximum fold change of gene\nexpression for a promoter
      to be considered alternative\npromoter (default 1.5)"
    default: 1.5
    inputBinding:
      position: 101
      prefix: --max_gFC
  - id: method
    type:
      - 'null'
      - string
    doc: "Which method to run: salmon / proactiv / dexseq / cage\n/ rnaseq"
    inputBinding:
      position: 101
      prefix: --method
  - id: min_pfc
    type:
      - 'null'
      - float
    doc: "Additional threshold of minimum fold change of\npromoter activity for a
      promoter to be considered\nalternative promoter (default 2.0)"
    default: 2.0
    inputBinding:
      position: 101
      prefix: --min_pFC
  - id: organism
    type: string
    doc: "Reference genome assembly to use, created by the\nGenomesetup step. For
      example: 'hg38', 'dm6', 'ce3',\nor 'mm10'."
    inputBinding:
      position: 101
      prefix: --organism
  - id: reads
    type:
      - 'null'
      - string
    doc: 'Reads are single-ended or paired: single / paired'
    inputBinding:
      position: 101
      prefix: --reads
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: "Path to sampleSheet.tsv file. Contains 'sampleName',\n'condition', 'batch',
      and 'differential' columns.If\nnot provided, a default will be created automatically\n\
      in the output directory named samplesheet.tsv."
    inputBinding:
      position: 101
      prefix: --sample_sheet
  - id: set_resources
    type:
      - 'null'
      - type: array
        items: string
    doc: "Per-rule resource override like\n'<rule>:slurm_partition=<PART>'. Repeatable.
      Mirrors\nSnakemake docs."
    inputBinding:
      position: 101
      prefix: --set-resources
  - id: slurm
    type:
      - 'null'
      - boolean
    doc: Use Snakemake native SLURM executor (--slurm).
    inputBinding:
      position: 101
      prefix: --slurm
  - id: slurm_account
    type:
      - 'null'
      - string
    doc: "SLURM account; passed via --default-resources\nslurm_account=<...>"
    inputBinding:
      position: 101
      prefix: --slurm-account
  - id: slurm_partition
    type:
      - 'null'
      - string
    doc: "SLURM partition; passed via --default-resources\nslurm_partition=<...>"
    inputBinding:
      position: 101
      prefix: --slurm-partition
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU threads to use for parallel processing\n(default: 30)."
    default: 30
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "Enable this flag if reads were trimmed using Trim\nGalore. If not set, the
      pipeline will use downsampled\nfastqs."
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: output_dir
    type: Directory
    doc: "Path to the output directory where results will be\nsaved (e.g., /path/to/output/)."
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
