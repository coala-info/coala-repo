cwlVersion: v1.2
class: CommandLineTool
baseCommand: vphaser2
label: vphaser2
doc: Phases variants in a BAM file.
inputs:
  - id: alignment_window_size
    type:
      - 'null'
      - int
    doc: default 500; alignment window size
    inputBinding:
      position: 101
      prefix: -w
  - id: dinucleotide_err_prob
    type:
      - 'null'
      - int
    doc: 'default 1; 1: dinucleotide for err prob measure; 0: not'
    inputBinding:
      position: 101
      prefix: -dt
  - id: err_calibr_qual_quantile
    type:
      - 'null'
      - int
    doc: default 20; quantile of qual for err calibr
    inputBinding:
      position: 101
      prefix: -qual
  - id: ignore_bases
    type:
      - 'null'
      - int
    doc: 'default 0; # of bases to ignore on both end of a read'
    inputBinding:
      position: 101
      prefix: -ig
  - id: input_bam
    type:
      - 'null'
      - File
    doc: input sorted bam file
    inputBinding:
      position: 101
      prefix: -i
  - id: mate_pair_err_calibr
    type:
      - 'null'
      - int
    doc: 'default 1; 1: mate-pair for err calibr; 0: not'
    inputBinding:
      position: 101
      prefix: -mp
  - id: mode
    type:
      - 'null'
      - int
    doc: 'default 1; 1: pileup + phasing; 2: pileup'
    inputBinding:
      position: 101
      prefix: -e
  - id: pe_distance_delta
    type:
      - 'null'
      - int
    doc: default 2; constrain PE distance by delta x fragsize_variation (auto 
      measured by program)
    inputBinding:
      position: 101
      prefix: -delta
  - id: read_cycle_err_calibr
    type:
      - 'null'
      - int
    doc: 'default 1; 1: read cycle for err calibr; 0: not'
    inputBinding:
      position: 101
      prefix: -cy
  - id: significance_value
    type:
      - 'null'
      - float
    doc: default 0.05; significance value for stat test
    inputBinding:
      position: 101
      prefix: -a
  - id: stats_sampling_percentage
    type:
      - 'null'
      - int
    doc: default 30; percentage of reads to sample to get stats.
    inputBinding:
      position: 101
      prefix: -ps
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vphaser2:2.0--h2bd4fab_16
