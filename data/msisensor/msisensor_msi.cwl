cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor msi
label: msisensor_msi
doc: "Calculate MSI score and distribution\n\nTool homepage: https://github.com/ding-lab/msisensor"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: bed file, optional
    inputBinding:
      position: 101
      prefix: -e
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
  - id: homopolymer_microsatellite_file
    type: string
    doc: homopolymer and microsates file
    inputBinding:
      position: 101
      prefix: -d
  - id: max_homopolymer_size_distribution
    type:
      - 'null'
      - int
    doc: maximal homopolymer size for distribution analysis
    inputBinding:
      position: 101
      prefix: -m
  - id: max_microsatellite_size_distribution
    type:
      - 'null'
      - int
    doc: maximal microstaes size for distribution analysis
    inputBinding:
      position: 101
      prefix: -w
  - id: min_comentropy_threshold
    type:
      - 'null'
      - float
    doc: minimal comentropy threshold for somatic sites detection (just for 
      tumor only data)
    inputBinding:
      position: 101
      prefix: -i
  - id: min_homopolymer_size
    type:
      - 'null'
      - int
    doc: minimal homopolymer size
    inputBinding:
      position: 101
      prefix: -l
  - id: min_homopolymer_size_distribution
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
    doc: minimal microsates size
    inputBinding:
      position: 101
      prefix: -q
  - id: min_microsatellite_size_distribution
    type:
      - 'null'
      - int
    doc: minimal microsates size for distribution analysis
    inputBinding:
      position: 101
      prefix: -s
  - id: normal_bam_file
    type: File
    doc: normal bam file
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
  - id: output_microsatellite_only
    type:
      - 'null'
      - int
    doc: 'output microsatellite only, 0: no; 1: yes'
    inputBinding:
      position: 101
      prefix: -y
  - id: region
    type:
      - 'null'
      - string
    doc: 'choose one region, format: 1:10000000-20000000'
    inputBinding:
      position: 101
      prefix: -r
  - id: span_size_around_window
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
    doc: tumor bam file
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_distribution_file
    type: File
    doc: output distribution file
    outputBinding:
      glob: $(inputs.output_distribution_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor:0.5--hc755212_3
