cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqverify
label: seqverify
doc: "Perform sequence verification and analysis.\n\nTool homepage: https://github.com/mpiersonsmela/SeqVerify"
inputs:
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size for certain analyses.
    inputBinding:
      position: 101
      prefix: --bin_size
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: database
    type:
      - 'null'
      - Directory
    doc: Path to the Kraken2 database directory.
    inputBinding:
      position: 101
      prefix: --database
  - id: download_defaults
    type:
      - 'null'
      - boolean
    doc: Download default configuration files.
    inputBinding:
      position: 101
      prefix: --download_defaults
  - id: genome
    type:
      - 'null'
      - File
    doc: Path to the reference genome file.
    inputBinding:
      position: 101
      prefix: --genome
  - id: granularity
    type:
      - 'null'
      - string
    doc: Granularity level for Kraken2 classification.
    inputBinding:
      position: 101
      prefix: --granularity
  - id: gtf
    type:
      - 'null'
      - File
    doc: Path to the GTF annotation file.
    inputBinding:
      position: 101
      prefix: --gtf
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files generated during processing.
    inputBinding:
      position: 101
      prefix: --keep_temp
  - id: keepgoing
    type:
      - 'null'
      - boolean
    doc: Continue processing even if errors occur.
    inputBinding:
      position: 101
      prefix: --keepgoing
  - id: kraken
    type:
      - 'null'
      - boolean
    doc: Enable Kraken2 classification.
    inputBinding:
      position: 101
      prefix: --kraken
  - id: manual_plots
    type:
      - 'null'
      - boolean
    doc: Generate manual plots.
    inputBinding:
      position: 101
      prefix: --manual_plots
  - id: max_mem
    type:
      - 'null'
      - string
    doc: Maximum memory to allocate (e.g., '4G').
    inputBinding:
      position: 101
      prefix: --max_mem
  - id: min_matches
    type:
      - 'null'
      - int
    doc: Minimum number of matches required for classification.
    inputBinding:
      position: 101
      prefix: --min_matches
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score for reads.
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: mitochondrial
    type:
      - 'null'
      - boolean
    doc: Enable mitochondrial genome analysis.
    inputBinding:
      position: 101
      prefix: --mitochondrial
  - id: reads_1
    type:
      - 'null'
      - File
    doc: Path to the first FASTQ file (R1).
    inputBinding:
      position: 101
      prefix: --reads_1
  - id: reads_2
    type:
      - 'null'
      - File
    doc: Path to the second FASTQ file (R2).
    inputBinding:
      position: 101
      prefix: --reads_2
  - id: similarity
    type:
      - 'null'
      - type: array
        items: float
    doc: Similarity thresholds for comparison.
    inputBinding:
      position: 101
      prefix: --similarity
  - id: spurious_filtering_threshold
    type:
      - 'null'
      - float
    doc: Threshold for filtering spurious results.
    inputBinding:
      position: 101
      prefix: --spurious_filtering_threshold
  - id: start
    type:
      - 'null'
      - string
    doc: Starting point for analysis (e.g., 'kraken').
    inputBinding:
      position: 101
      prefix: --start
  - id: stringency
    type:
      - 'null'
      - string
    doc: Stringency level for filtering results.
    inputBinding:
      position: 101
      prefix: --stringency
  - id: targeted
    type:
      - 'null'
      - File
    doc: Path to a targeted reference file (e.g., a specific gene panel).
    inputBinding:
      position: 101
      prefix: --targeted
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: untargeted
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to untargeted reference files (e.g., genomes, databases).
    inputBinding:
      position: 101
      prefix: --untargeted
  - id: variant_calling
    type:
      - 'null'
      - type: array
        items: string
    doc: Parameters for variant calling.
    inputBinding:
      position: 101
      prefix: --variant_calling
  - id: variant_intensity
    type:
      - 'null'
      - float
    doc: Intensity threshold for variant calling.
    inputBinding:
      position: 101
      prefix: --variant_intensity
  - id: variant_window_size
    type:
      - 'null'
      - int
    doc: Window size for variant calling.
    inputBinding:
      position: 101
      prefix: --variant_window_size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output directory or file path.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqverify:1.3.0--hdfd78af_0
