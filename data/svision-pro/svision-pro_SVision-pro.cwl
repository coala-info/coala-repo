cwlVersion: v1.2
class: CommandLineTool
baseCommand: SVision-pro
label: svision-pro_SVision-pro
doc: "SVision-Pro 2.5\n\nTool homepage: https://github.com/songbowang125/SVision-pro"
inputs:
  - id: access_path
    type:
      - 'null'
      - File
    doc: Absolute path to access file, not required
    inputBinding:
      position: 101
      prefix: --access_path
  - id: base_path
    type:
      - 'null'
      - type: array
        items: File
    doc: Absolute path to base (normal) bam files, not required
    inputBinding:
      position: 101
      prefix: --base_path
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for Unet predicting
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: bkp_mode
    type:
      - 'null'
      - string
    doc: Choose from affected and extended
    inputBinding:
      position: 101
      prefix: --bkp_mode
  - id: detect_mode
    type:
      - 'null'
      - string
    doc: Choose from germline, denovo and somatic
    inputBinding:
      position: 101
      prefix: --detect_mode
  - id: device
    type:
      - 'null'
      - string
    doc: Utilizing CPU or GPU to run Unet genotype module
    inputBinding:
      position: 101
      prefix: --device
  - id: enable_mismatch_filter
    type:
      - 'null'
      - boolean
    doc: SKip filtering reads by mismatch ratio
    inputBinding:
      position: 101
      prefix: --enable_mismatch_filter
  - id: force_cluster
    type:
      - 'null'
      - boolean
    doc: Force cluster uncovered events
    inputBinding:
      position: 101
      prefix: --force_cluster
  - id: genome_path
    type: Directory
    doc: Absolute path to your reference genome (.fai required in the directory)
    inputBinding:
      position: 101
      prefix: --genome_path
  - id: gpu_id
    type:
      - 'null'
      - int
    doc: Specific GPU ID when activating GPU device
    inputBinding:
      position: 101
      prefix: --gpu_id
  - id: img_size
    type:
      - 'null'
      - string
    doc: Image size for generating plots
    inputBinding:
      position: 101
      prefix: --img_size
  - id: interval_size
    type:
      - 'null'
      - int
    doc: 'The sliding interval/window size in segment collection (default: 10000000)'
    inputBinding:
      position: 101
      prefix: --interval_size
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: 'Maximum read coverage to detect (default: 500)'
    inputBinding:
      position: 101
      prefix: --max_coverage
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: 'Maximum SV size to detect (default: 50000)'
    inputBinding:
      position: 101
      prefix: --max_sv_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality of reads to consider (default: 20)'
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: min_supp
    type:
      - 'null'
      - int
    doc: 'Minimum support read number required for SV calling (default: 5)'
    inputBinding:
      position: 101
      prefix: --min_supp
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: 'Minimum SV size to detect (default: 50)'
    inputBinding:
      position: 101
      prefix: --min_sv_size
  - id: model_path
    type: File
    doc: Absolute path to Unet predict model
    inputBinding:
      position: 101
      prefix: --model_path
  - id: out_path
    type: Directory
    doc: Absolute path to output
    inputBinding:
      position: 101
      prefix: --out_path
  - id: preset
    type: string
    doc: Choose from hifi, error-prone (for ONT and other noisy long reads) and 
      asm
    inputBinding:
      position: 101
      prefix: --preset
  - id: process_num
    type:
      - 'null'
      - int
    doc: 'Thread numbers (default: 1)'
    inputBinding:
      position: 101
      prefix: --process_num
  - id: region
    type:
      - 'null'
      - string
    doc: Specific region (chromosome:start-end) to detect
    inputBinding:
      position: 101
      prefix: --region
  - id: report_new_bkps
    type:
      - 'null'
      - boolean
    doc: Report new breakpoints when inherityping
    inputBinding:
      position: 101
      prefix: --report_new_bkps
  - id: rescue_large
    type:
      - 'null'
      - boolean
    doc: Report large SV/CSVs that are not fully covered by reads
    inputBinding:
      position: 101
      prefix: --rescue_large
  - id: sample_name
    type: string
    doc: Name of the BAM sample name
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: skip_bnd
    type:
      - 'null'
      - boolean
    doc: SKip calling BNDs
    inputBinding:
      position: 101
      prefix: --skip_bnd
  - id: skip_coverage_filter
    type:
      - 'null'
      - boolean
    doc: SKip filtering reads by max read coverage threshold
    inputBinding:
      position: 101
      prefix: --skip_coverage_filter
  - id: skip_nearby
    type:
      - 'null'
      - boolean
    doc: SKip merging nearby Is and Ds
    inputBinding:
      position: 101
      prefix: --skip_nearby
  - id: target_path
    type: File
    doc: Absolute path to target (tumor) bam file
    inputBinding:
      position: 101
      prefix: --target_path
  - id: unet_cpu_num
    type:
      - 'null'
      - int
    doc: When using CPU, specific the process number for each Unet task
    inputBinding:
      position: 101
      prefix: --unet_cpu_num
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svision-pro:2.5--pyhdfd78af_0
stdout: svision-pro_SVision-pro.out
