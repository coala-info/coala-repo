cwlVersion: v1.2
class: CommandLineTool
baseCommand: craq
label: craq
doc: "Genome benchmarking using CRAQ\n\nTool homepage: https://github.com/JiaoLaboratory/CRAQ"
inputs:
  - id: break
    type:
      - 'null'
      - string
    doc: Break chimera fragment
    inputBinding:
      position: 101
      prefix: --break
  - id: error_region
    type:
      - 'null'
      - string
    doc: Search noisy error region nearby an CSE breakpoint
    inputBinding:
      position: 101
      prefix: --error_region
  - id: gapmodel
    type:
      - 'null'
      - int
    doc: Gap[N] is treated as 1:CRE 2:CSE
    inputBinding:
      position: 101
      prefix: --gapmodel
  - id: genome
    type: File
    doc: Assembly sequence file (.fa)
    inputBinding:
      position: 101
      prefix: --genome
  - id: he_max
    type:
      - 'null'
      - float
    doc: Upper clipping rate for heterozygous allele
    inputBinding:
      position: 101
      prefix: --he_max
  - id: he_min
    type:
      - 'null'
      - float
    doc: Lower clipping rate for heterozygous allele
    inputBinding:
      position: 101
      prefix: --he_min
  - id: map
    type:
      - 'null'
      - string
    doc: Mapping use map-pb/map-hifi/map-ont for PacBio CLR/HiFi or Nanopore vs reference
      [ignored if .bam provided]
    inputBinding:
      position: 101
      prefix: --map
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum reads mapping quality
    inputBinding:
      position: 101
      prefix: --mapq
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: Gap[N] length greater than the threshold will be treated as breakage
    inputBinding:
      position: 101
      prefix: --min_gap_size
  - id: min_ngs_clip_num
    type:
      - 'null'
      - int
    doc: Minimum number of NGS clipped-reads
    inputBinding:
      position: 101
      prefix: --min_ngs_clip_num
  - id: min_sms_clip_num
    type:
      - 'null'
      - int
    doc: Minimum number of SMS clipped-reads
    inputBinding:
      position: 101
      prefix: --min_sms_clip_num
  - id: ngs_clip_cover_rate
    type:
      - 'null'
      - float
    doc: Minimum proportion of NGS clipped-reads
    inputBinding:
      position: 101
      prefix: --ngs_clip_coverRate
  - id: ngs_coverage
    type:
      - 'null'
      - int
    doc: Average NGS coverage
    inputBinding:
      position: 101
      prefix: --ngs_coverage
  - id: ngs_input
    type:
      type: array
      items: string
    doc: NGS short-read alignment(.bam) or sequences(.fq.gz), separated with comma
      if paired
    inputBinding:
      position: 101
      prefix: --ngs_input
  - id: norm_window
    type:
      - 'null'
      - string
    doc: Window size for normalizing error count
    inputBinding:
      position: 101
      prefix: --norm_window
  - id: plot
    type:
      - 'null'
      - string
    doc: Plotting CRAQ metrics. pycircos (python 3.7later) is required if 'T'
    inputBinding:
      position: 101
      prefix: --plot
  - id: plot_ids
    type:
      - 'null'
      - File
    doc: An file including selected assembly IDs for plotting. Default use all IDs.
    inputBinding:
      position: 101
      prefix: --plot_ids
  - id: regional_window
    type:
      - 'null'
      - int
    doc: Regional quality benchmarking
    inputBinding:
      position: 101
      prefix: --regional_window
  - id: report_snv
    type:
      - 'null'
      - string
    doc: Report tiny Indel errors or heterozyous variants (<40bp)
    inputBinding:
      position: 101
      prefix: --report_SNV
  - id: sms_clip_cover_rate
    type:
      - 'null'
      - float
    doc: Minimum proportion of SMS clipped-reads
    inputBinding:
      position: 101
      prefix: --sms_clip_coverRate
  - id: sms_coverage
    type:
      - 'null'
      - int
    doc: Average SMS coverage
    inputBinding:
      position: 101
      prefix: --sms_coverage
  - id: sms_input
    type: File
    doc: SMS long-read alignment(.bam) or sequences(.fq.gz)
    inputBinding:
      position: 101
      prefix: --sms_input
  - id: thread
    type:
      - 'null'
      - int
    doc: The number of thread used in alignment
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: User-specified output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/craq:1.10--hdfd78af_0
