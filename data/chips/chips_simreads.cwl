cwlVersion: v1.2
class: CommandLineTool
baseCommand: chips simreads
label: chips_simreads
doc: "Simulate ChIP-seq reads for a set of peaks.\n\nTool homepage: https://github.com/gymreklab/chips"
inputs:
  - id: binsize
    type:
      - 'null'
      - int
    doc: Consider bins of this size when simulating
    default: 100000
    inputBinding:
      position: 101
      prefix: --binsize
  - id: bound_fraction
    type:
      - 'null'
      - float
    doc: Fraction of the genome that is bound
    default: 0.03713
    inputBinding:
      position: 101
      prefix: --frac
  - id: custom_deletion_rate
    type:
      - 'null'
      - float
    doc: Customized deletion value in sequecing
    inputBinding:
      position: 101
      prefix: --del
  - id: custom_insertion_rate
    type:
      - 'null'
      - float
    doc: Customized insertion value in sequecing
    inputBinding:
      position: 101
      prefix: --ins
  - id: custom_substitution_rate
    type:
      - 'null'
      - float
    doc: Customized substitution value in sequecing
    inputBinding:
      position: 101
      prefix: --sub
  - id: gamma_fragment_length
    type:
      - 'null'
      - string
    doc: Parameters for fragment length distribution (alpha, beta).
    default: 15.67,15.49
    inputBinding:
      position: 101
      prefix: --gamma-frag
  - id: model_file
    type:
      - 'null'
      - File
    doc: JSON file with model parameters (e.g. from running learn)
    inputBinding:
      position: 101
      prefix: --model
  - id: no_scale_peak_scores
    type:
      - 'null'
      - boolean
    doc: Don't scale peak scores by the max score.
    inputBinding:
      position: 101
      prefix: --noscale
  - id: num_copies
    type:
      - 'null'
      - int
    doc: Number of copies of the genome to simulate
    default: 100
    inputBinding:
      position: 101
      prefix: --numcopies
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads (or read pairs) to simulate
    default: 1000000
    inputBinding:
      position: 101
      prefix: --numreads
  - id: output_prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: -o
  - id: pcr_rate
    type:
      - 'null'
      - float
    doc: The rate of geometric distribution for PCR simulation
    default: 1
    inputBinding:
      position: 101
      prefix: --pcr_rate
  - id: peak_file_type
    type: string
    doc: The file format of your input peak file. Only `homer` or `bed` are 
      supported. You can use -t wce with no BED file to simulate whole cell 
      extract control data.
    inputBinding:
      position: 101
      prefix: -t
  - id: peak_score_column_index
    type:
      - 'null'
      - int
    doc: The index of the BED file column used to score each peak (index 
      starting from 1). Required if -b not used.
    default: -1
    inputBinding:
      position: 101
      prefix: -c
  - id: peaks_file
    type: File
    doc: BED file with peak regions
    inputBinding:
      position: 101
      prefix: -p
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length to generate
    default: 36
    inputBinding:
      position: 101
      prefix: --readlen
  - id: reads_bam_file
    type:
      - 'null'
      - File
    doc: Read BAM file used to score each peak
    inputBinding:
      position: 101
      prefix: -b
  - id: recompute_frac
    type:
      - 'null'
      - boolean
    doc: Recompute --frac param based on input peaks.
    inputBinding:
      position: 101
      prefix: --recomputeF
  - id: reference_genome
    type: File
    doc: FASTA file with reference genome
    inputBinding:
      position: 101
      prefix: -f
  - id: region
    type:
      - 'null'
      - string
    doc: Only simulate reads from this region chrom:start-end
    inputBinding:
      position: 101
      prefix: --region
  - id: scale_outliers
    type:
      - 'null'
      - boolean
    doc: Set all peaks with scores >2*median score to have binding prob 1. 
      Recommended with real peak files
    inputBinding:
      position: 101
      prefix: --scale-outliers
  - id: seed
    type:
      - 'null'
      - string
    doc: the seed for initiating randomization opertions
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequencer_error_profile
    type:
      - 'null'
      - string
    doc: Sequencing error values
    inputBinding:
      position: 101
      prefix: --sequencer
  - id: simulate_paired_end
    type:
      - 'null'
      - boolean
    doc: Simulate paired-end reads
    default: false
    inputBinding:
      position: 101
      prefix: --paired
  - id: spot_score
    type:
      - 'null'
      - float
    doc: SPOT score (fraction of reads in peaks)
    default: 0.17594
    inputBinding:
      position: 101
      prefix: --spot
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used for computing
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chips:2.4--h43eeafb_7
stdout: chips_simreads.out
