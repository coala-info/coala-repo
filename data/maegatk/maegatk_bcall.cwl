cwlVersion: v1.2
class: CommandLineTool
baseCommand: maegatk
label: maegatk_bcall
doc: "a Maester genome toolkit.\n\nTool homepage: https://github.com/caleblareau/maegatk"
inputs:
  - id: mode
    type: string
    doc: MODE = ['bcall', 'support']
    inputBinding:
      position: 1
  - id: alignment_quality
    type:
      - 'null'
      - int
    doc: "Minimum alignment quality to include read in\n                         \
      \         genotype."
    inputBinding:
      position: 102
      prefix: --alignment-quality
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: "Read tag (generally two letters) to separate\n                         \
      \         single cells; valid and required only in\n                       \
      \           `bcall` mode."
    inputBinding:
      position: 102
      prefix: --barcode-tag
  - id: barcodes
    type:
      - 'null'
      - File
    doc: "File path to barcodes that will be\n                                  extracted;
      useful only in `bcall` mode."
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: base_qual
    type:
      - 'null'
      - int
    doc: "Minimum base quality for inclusion in the\n                            \
      \      genotype count."
    inputBinding:
      position: 102
      prefix: --base-qual
  - id: cluster
    type:
      - 'null'
      - string
    doc: "Message to send to Snakemake to execute jobs\n                         \
      \         on cluster interface; see documentation."
    inputBinding:
      position: 102
      prefix: --cluster
  - id: ignore_samples
    type:
      - 'null'
      - string
    doc: "Comma separated list of sample names to\n                              \
      \    ignore; NONE (special string) by default.\n                           \
      \       Sample refers to basename of .bam file"
    inputBinding:
      position: 102
      prefix: --ignore-samples
  - id: input
    type: File
    doc: Input; a singular, indexed bam file.
    inputBinding:
      position: 102
      prefix: --input
  - id: jobs
    type:
      - 'null'
      - string
    doc: "Max number of jobs to be running\n                                  concurrently
      on the cluster interface."
    inputBinding:
      position: 102
      prefix: --jobs
  - id: keep_qc_bams
    type:
      - 'null'
      - boolean
    doc: "Add this flag to keep the quality-controlled\n                         \
      \         bams after processing."
    inputBinding:
      position: 102
      prefix: --keep-qc-bams
  - id: keep_samples
    type:
      - 'null'
      - string
    doc: "Comma separated list of sample names to\n                              \
      \    keep; ALL (special string) by default.\n                              \
      \    Sample refers to basename of .bam file"
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
    doc: "Maximum memory for java for running\n                                  duplicate
      removal."
    inputBinding:
      position: 102
      prefix: --max-javamem
  - id: min_barcode_reads
    type:
      - 'null'
      - int
    doc: "Minimum number of mitochondrial reads for a\n                          \
      \        barcode to be genotyped; useful only in\n                         \
      \         `bcall` mode; will not overwrite the\n                           \
      \       `--barcodes` logic."
    inputBinding:
      position: 102
      prefix: --min-barcode-reads
  - id: min_reads
    type:
      - 'null'
      - int
    doc: "Minimum number of supporting reads to call a\n                         \
      \         consensus UMI/rread."
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: mito_genome
    type: string
    doc: "mitochondrial genome configuration. Requires\n                         \
      \         bwa indexed fasta file or `rCRS` (built-in)"
    inputBinding:
      position: 102
      prefix: --mito-genome
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix for project name
    inputBinding:
      position: 102
      prefix: --name
  - id: ncores
    type:
      - 'null'
      - string
    doc: "Number of cores to run the main job in\n                               \
      \   parallel."
    inputBinding:
      position: 102
      prefix: --ncores
  - id: nhmax
    type:
      - 'null'
      - int
    doc: "Maximum number of read alignments allowed as\n                         \
      \         governed by the NH flag."
    inputBinding:
      position: 102
      prefix: --NHmax
  - id: nmmax
    type:
      - 'null'
      - int
    doc: "Maximum number of paired mismatches allowed\n                          \
      \        represented by the NM/nM tags."
    inputBinding:
      position: 102
      prefix: --NMmax
  - id: nsamples
    type:
      - 'null'
      - int
    doc: "The number of samples / cells to be\n                                  processed
      per iteration; default is all."
    inputBinding:
      position: 102
      prefix: --nsamples
  - id: skip_R
    type:
      - 'null'
      - boolean
    doc: "Generate plain-text only output. Otherwise,\n                          \
      \        this generates a .rds obejct that can be\n                        \
      \          immediately read into R for downstream\n                        \
      \          analysis."
    inputBinding:
      position: 102
      prefix: --skip-R
  - id: skip_barcodesplit
    type:
      - 'null'
      - boolean
    doc: "Skip the time consuming barcode-splitting\n                            \
      \      step if it finished successfully before"
    inputBinding:
      position: 102
      prefix: --skip-barcodesplit
  - id: snake_stdout
    type:
      - 'null'
      - boolean
    doc: "Write snakemake log to sdout rather than a\n                           \
      \       file."
    inputBinding:
      position: 102
      prefix: --snake-stdout
  - id: umi_barcode
    type:
      - 'null'
      - string
    doc: "Read tag (generally two letters) to specify\n                          \
      \        the UMI tag when removing duplicates for\n                        \
      \          genotyping."
    inputBinding:
      position: 102
      prefix: --umi-barcode
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for genotypes.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maegatk:0.2.0--pyhdfd78af_2
