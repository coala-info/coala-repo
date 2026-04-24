cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tandemtwister
  - germline
label: tandemtwister_germline
doc: "Genotyping tandem repeats from long-read alignments.\n\nTool homepage: https://github.com/Lionward/tandemtwister"
inputs:
  - id: bamIsTagged
    type:
      - 'null'
      - boolean
    doc: Treat BAM as pre-tagged/phased
    inputBinding:
      position: 101
      prefix: --bamIsTagged
  - id: cluster_iter
    type:
      - 'null'
      - int
    doc: Number of clustering iterations
    inputBinding:
      position: 101
      prefix: --cluster_iter
  - id: consensus_ratio_str
    type:
      - 'null'
      - float
    doc: Minimum consensus ratio for STR correction
    inputBinding:
      position: 101
      prefix: --consensus_ratio_str
  - id: consensus_ratio_vntr
    type:
      - 'null'
      - float
    doc: Minimum consensus ratio for VNTR correction
    inputBinding:
      position: 101
      prefix: --consensus_ratio_vntr
  - id: correct
    type:
      - 'null'
      - boolean
    doc: 'Enable genotype correction (CCS default: false; CLR/ONT default: true)'
    inputBinding:
      position: 101
      prefix: --correct
  - id: input_bam
    type: File
    doc: Path to the BAM file containing aligned reads
    inputBinding:
      position: 101
      prefix: --bam
  - id: keepCutReads
    type:
      - 'null'
      - boolean
    doc: Retain reads trimmed during preprocessing
    inputBinding:
      position: 101
      prefix: --keepCutReads
  - id: minPts_frac
    type:
      - 'null'
      - float
    doc: Minimum read fraction per cluster
    inputBinding:
      position: 101
      prefix: --minPts_frac
  - id: minReadsInRegion
    type:
      - 'null'
      - int
    doc: Minimum spanning reads required per region
    inputBinding:
      position: 101
      prefix: --minReadsInRegion
  - id: min_match_ratio_l
    type:
      - 'null'
      - float
    doc: Minimum match ratio for long motifs
    inputBinding:
      position: 101
      prefix: --min_match_ratio_l
  - id: motif_file
    type: File
    doc: Motif definition file (BED / TSV / CSV)
    inputBinding:
      position: 101
      prefix: --motif_file
  - id: noise_limit_str
    type:
      - 'null'
      - float
    doc: Noise limit for STR clustering
    inputBinding:
      position: 101
      prefix: --noise_limit_str
  - id: noise_limit_vntr
    type:
      - 'null'
      - float
    doc: Noise limit for VNTR clustering
    inputBinding:
      position: 101
      prefix: --noise_limit_vntr
  - id: padding
    type:
      - 'null'
      - int
    doc: Padding around the STR region when extracting reads
    inputBinding:
      position: 101
      prefix: --padding
  - id: quality_score
    type:
      - 'null'
      - int
    doc: Minimum read quality score
    inputBinding:
      position: 101
      prefix: --quality_score
  - id: reads_type
    type:
      - 'null'
      - string
    doc: 'Sequencing platform / read type (default: CCS)'
    inputBinding:
      position: 101
      prefix: --reads_type
  - id: reference_fasta
    type: File
    doc: Reference FASTA file (.fa / .fna)
    inputBinding:
      position: 101
      prefix: --ref
  - id: refineTrRegions
    type:
      - 'null'
      - boolean
    doc: Refine tandem repeat regions
    inputBinding:
      position: 101
      prefix: --refineTrRegions
  - id: removeOutliersZscore
    type:
      - 'null'
      - boolean
    doc: Remove outliers before phasing
    inputBinding:
      position: 101
      prefix: --removeOutliersZscore
  - id: sample_identifier
    type:
      - 'null'
      - string
    doc: Optional sample identifier
    inputBinding:
      position: 101
      prefix: --sample
  - id: sample_sex
    type: string
    doc: Sample sex (0 | female, 1 | male)
    inputBinding:
      position: 101
      prefix: --sex
  - id: start_eps_str
    type:
      - 'null'
      - float
    doc: Initial epsilon for STR clustering
    inputBinding:
      position: 101
      prefix: --start_eps_str
  - id: start_eps_vntr
    type:
      - 'null'
      - float
    doc: Initial epsilon for VNTR clustering
    inputBinding:
      position: 101
      prefix: --start_eps_vntr
  - id: tandem_run_threshold
    type:
      - 'null'
      - string
    doc: Maximum bases for merging tandem-repeat runs
    inputBinding:
      position: 101
      prefix: --tandem_run_threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Verbosity level (0: error, 1: critical, 2: info, 3: debug)'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file for region, motif, and haplotype copy numbers
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_file_statistics
    type:
      - 'null'
      - File
    doc: Optional phasing summary output file
    outputBinding:
      glob: $(inputs.output_file_statistics)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0
