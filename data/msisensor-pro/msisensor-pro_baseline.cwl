cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-pro
  - baseline
label: msisensor-pro_baseline
doc: "This module build baseline for MSI detection with pro module using only tumor
  sequencing data. To achieve it, you need sequencing data from normal samples(-i).\n\
  \nTool homepage: https://github.com/xjtu-omics/msisensor-pro"
inputs:
  - id: configure_files
    type: string
    doc: "configure files for building baseline (text file)\nyou need to provide the
      output (*_all) from pro command \ne.g.\n----------------------------------\n\
      \ case1\t/path/to/case1_sorted_all \n case2\t/path/to/case2_sorted_all \n case3\t\
      /path/to/case3-sorted_all \n----------------------------------"
    inputBinding:
      position: 101
      prefix: -i
  - id: homopolymer_microsatellite_file
    type: string
    doc: homopolymer and microsatellite file
    inputBinding:
      position: 101
      prefix: -d
  - id: min_support_samples
    type:
      - 'null'
      - double
    doc: microsatellite sites with support from fewer than -d samples will not 
      pass quality control
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_path
    type: Directory
    doc: output path for baseline
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
