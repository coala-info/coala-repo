cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-pro
  - pro
label: msisensor-pro_pro
doc: "This module evaluate MSI using single (tumor) sample. You need to input (-d)
  microsatellites file and a bam files (-t) .\n\nTool homepage: https://github.com/xjtu-omics/msisensor-pro"
inputs:
  - id: bam_cram_file
    type: File
    doc: bam/cram file of tumor/normal(for baseline building) sample
    inputBinding:
      position: 101
      prefix: -t
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: 'coverage threshold for msi analysis, WXS: 20; WGS: 15'
    default: 15
    inputBinding:
      position: 101
      prefix: -c
  - id: homopolymers_microsatellites_file
    type: string
    doc: homopolymers and microsatellites file
    inputBinding:
      position: 101
      prefix: -d
  - id: instable_sites_threshold
    type:
      - 'null'
      - float
    doc: minimal threshold for instable sites detection (just for tumor only 
      data)
    default: 0.1
    inputBinding:
      position: 101
      prefix: -i
  - id: max_homopolymer_size
    type:
      - 'null'
      - int
    doc: maximal homopolymer size for distribution analysis
    default: 50
    inputBinding:
      position: 101
      prefix: -m
  - id: max_microsatellite_size
    type:
      - 'null'
      - int
    doc: maximal microsatellite size for distribution analysis
    default: 40
    inputBinding:
      position: 101
      prefix: -w
  - id: min_homopolymer_size
    type:
      - 'null'
      - int
    doc: minimal homopolymer size for distribution analysis
    default: 8
    inputBinding:
      position: 101
      prefix: -p
  - id: min_microsatellite_size
    type:
      - 'null'
      - int
    doc: minimal microsatellite size for distribution analysis
    default: 5
    inputBinding:
      position: 101
      prefix: -s
  - id: output_homopolymer_only
    type:
      - 'null'
      - int
    doc: 'output homopolymer only, 0: no; 1: yes'
    default: 0
    inputBinding:
      position: 101
      prefix: -x
  - id: output_microsatellite_only
    type:
      - 'null'
      - int
    doc: 'output microsatellite only, 0: no; 1: yes'
    default: 0
    inputBinding:
      position: 101
      prefix: -y
  - id: output_site_no_coverage
    type:
      - 'null'
      - int
    doc: 'output site have no read coverage, 1: no; 0: yes'
    default: 1
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
    default: 500
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: threads number for parallel computing
    default: 1
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: output_path
    type: Directory
    doc: output path (Ending with a slash is not allowed.)
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
