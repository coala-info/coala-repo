cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2cfg.pl
label: breakdancer_bam2cfg.pl
doc: "Convert BAM files to configuration files for structural variant detection.\n\
  \nTool homepage: https://github.com/genome/breakdancer"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: coeff_variation_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff on coefficients of variation
    inputBinding:
      position: 102
      prefix: -v
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: Minimal mean insert size
    inputBinding:
      position: 102
      prefix: -s
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: -q
  - id: num_bins_histogram
    type:
      - 'null'
      - int
    doc: Number of bins in the histogram
    inputBinding:
      position: 102
      prefix: -b
  - id: num_observations
    type:
      - 'null'
      - int
    doc: Number of observation required to estimate mean and s.d. insert size
    inputBinding:
      position: 102
      prefix: -n
  - id: output_flag_distribution
    type:
      - 'null'
      - boolean
    doc: Output mapping flag distribution
    inputBinding:
      position: 102
      prefix: -g
  - id: plot_histogram
    type:
      - 'null'
      - boolean
    doc: Plot insert size histogram for each BAM library
    inputBinding:
      position: 102
      prefix: -h
  - id: rg_lib_mapping_file
    type:
      - 'null'
      - File
    doc: A two column tab-delimited text file (RG, LIB) specify the RG=>LIB 
      mapping, useful when BAM header is incomplete
    inputBinding:
      position: 102
      prefix: -f
  - id: std_dev_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff in unit of standard deviation
    inputBinding:
      position: 102
      prefix: -c
  - id: use_mapping_quality
    type:
      - 'null'
      - boolean
    doc: Using mapping quality instead of alternative mapping quality
    inputBinding:
      position: 102
      prefix: -m
  - id: use_solid_system
    type:
      - 'null'
      - boolean
    doc: Change default system from Illumina to SOLiD
    inputBinding:
      position: 102
      prefix: -C
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakdancer:1.4.5--pl5321h264e753_11
stdout: breakdancer_bam2cfg.pl.out
