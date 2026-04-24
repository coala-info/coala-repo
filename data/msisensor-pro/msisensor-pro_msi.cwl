cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-pro
  - msi
label: msisensor-pro_msi
doc: "This module evaluate MSI using the difference between normal and tumor length
  distribution of microsatellites. You need to input (-d) microsatellites file and
  two bam files (-t, -n).\n\nTool homepage: https://github.com/xjtu-omics/msisensor-pro"
inputs:
  - id: coverage_normalization
    type:
      - 'null'
      - int
    doc: 'coverage normalization for paired tumor and normal data, 0: no; 1: yes'
    inputBinding:
      position: 101
      prefix: -z
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: 'coverage threshold for msi analysis, WXS: 20; WGS: 15'
    inputBinding:
      position: 101
      prefix: -c
  - id: fdr_threshold
    type:
      - 'null'
      - float
    doc: FDR threshold for somatic sites detection
    inputBinding:
      position: 101
      prefix: -f
  - id: homopolymers_microsatellites_file
    type: string
    doc: homopolymers and microsatellites file
    inputBinding:
      position: 101
      prefix: -d
  - id: max_homopolymer_size
    type:
      - 'null'
      - int
    doc: maximal homopolymer size for distribution analysis
    inputBinding:
      position: 101
      prefix: -m
  - id: max_microsatellite_size
    type:
      - 'null'
      - int
    doc: maximal microsatellite size for distribution analysis
    inputBinding:
      position: 101
      prefix: -w
  - id: min_homopolymer_size
    type:
      - 'null'
      - int
    doc: minimal homopolymer size for distribution analysis
    inputBinding:
      position: 101
      prefix: -p
  - id: min_microsatellite_size
    type:
      - 'null'
      - int
    doc: minimal microsatellite size for distribution analysis
    inputBinding:
      position: 101
      prefix: -s
  - id: normal_bam_file
    type: File
    doc: normal bam file with index
    inputBinding:
      position: 101
      prefix: -n
  - id: output_homopolymer_only
    type:
      - 'null'
      - int
    doc: 'output homopolymer only, 0: no; 1: yes'
    inputBinding:
      position: 101
      prefix: -x
  - id: output_microsatellites_only
    type:
      - 'null'
      - int
    doc: 'output microsatellites only, 0: no; 1: yes'
    inputBinding:
      position: 101
      prefix: -y
  - id: output_path
    type: string
    doc: output path (Ending with a slash is not allowed.)
    inputBinding:
      position: 101
      prefix: -o
  - id: output_site_no_coverage
    type:
      - 'null'
      - int
    doc: 'output site have no read coverage, 1: no; 0: yes'
    inputBinding:
      position: 101
      prefix: '-0'
  - id: reference_file
    type:
      - 'null'
      - File
    doc: reference file [required if *.cram for -t]
    inputBinding:
      position: 101
      prefix: -g
  - id: span_size
    type:
      - 'null'
      - int
    doc: span size around window for extracting reads
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: threads number for parallel computing
    inputBinding:
      position: 101
      prefix: -b
  - id: tumor_bam_file
    type: File
    doc: tumor bam file with index
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
stdout: msisensor-pro_msi.out
