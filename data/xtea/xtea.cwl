cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtea
label: xtea
doc: "xTea is a tool for detecting transposable element insertions.\n\nTool homepage:
  https://github.com/parklab/xTea"
inputs:
  - id: blacklist_file
    type:
      - 'null'
      - File
    doc: Reference panel database for filtering, or a blacklist region
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: case_control
    type:
      - 'null'
      - boolean
    doc: Run in case control mode
    inputBinding:
      position: 101
      prefix: --case_control
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
      prefix: --cores
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress the rep lib and reference file
    inputBinding:
      position: 101
      prefix: --decompress
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: Run in de novo mode
    inputBinding:
      position: 101
      prefix: --denovo
  - id: flank_region_file
    type:
      - 'null'
      - File
    doc: flank region file
    inputBinding:
      position: 101
      prefix: --flklen
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force to start from the very beginning
    inputBinding:
      position: 101
      prefix: --force
  - id: gene_annotation_file
    type:
      - 'null'
      - File
    doc: Gene annotation file
    inputBinding:
      position: 101
      prefix: --gene
  - id: hard
    type:
      - 'null'
      - boolean
    doc: This is hard-cut for fitering out coverage abnormal candidates
    inputBinding:
      position: 101
      prefix: --hard
  - id: input_10x_bam_file
    type:
      - 'null'
      - File
    doc: Input 10X bam file
    inputBinding:
      position: 101
      prefix: --x10
  - id: input_bam_file
    type:
      - 'null'
      - File
    doc: Input bam file
    inputBinding:
      position: 101
      prefix: --bam
  - id: lsf
    type:
      - 'null'
      - boolean
    doc: Indiates submit to LSF system
    inputBinding:
      position: 101
      prefix: --lsf
  - id: memory_limit_gb
    type:
      - 'null'
      - float
    doc: Memory limit in GB
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_clipped_reads_cutoff
    type:
      - 'null'
      - int
    doc: 'cutoff of minimum # of clipped reads'
    inputBinding:
      position: 101
      prefix: --nclip
  - id: min_clipped_reads_filter_cutoff
    type:
      - 'null'
      - int
    doc: 'cutoff of minimum # of clipped reads in filtering step'
    inputBinding:
      position: 101
      prefix: --nfclip
  - id: min_clipped_reads_mates_in_rep_regions_cutoff
    type:
      - 'null'
      - int
    doc: 'cutoff of minimum # of clipped reads whose mates map in repetitive regions'
    inputBinding:
      position: 101
      prefix: --cr
  - id: min_discordant_pairs_cutoff
    type:
      - 'null'
      - int
    doc: 'cutoff of minimum # of discordant pair'
    inputBinding:
      position: 101
      prefix: --nd
  - id: min_discordant_pairs_filter_cutoff
    type:
      - 'null'
      - int
    doc: 'cutoff of minimum # of discordant pair of each sample in filtering step'
    inputBinding:
      position: 101
      prefix: --nfdisc
  - id: min_insertion_length
    type:
      - 'null'
      - int
    doc: minimum length of the insertion for future analysis
    inputBinding:
      position: 101
      prefix: --teilen
  - id: mosaic
    type:
      - 'null'
      - boolean
    doc: Calling mosaic events from high coverage data
    inputBinding:
      position: 101
      prefix: --mosaic
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: parameter file
    inputBinding:
      position: 101
      prefix: --par
  - id: purity
    type:
      - 'null'
      - float
    doc: Tumor purity
    inputBinding:
      position: 101
      prefix: --purity
  - id: queue
    type:
      - 'null'
      - string
    doc: Which queue to run the job
    inputBinding:
      position: 101
      prefix: --partition
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: repeat_type
    type:
      - 'null'
      - string
    doc: 'Type of repeats working on: 1-L1, 2-Alu, 4-SVA, 8-HERV, 16-Mitochondrial'
    inputBinding:
      position: 101
      prefix: --reptype
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume the running, which will skip the step if output file already 
      exists!
    inputBinding:
      position: 101
      prefix: --resume
  - id: run_flag
    type:
      - 'null'
      - int
    doc: Flag indicates which step to run (1-clip, 2-disc, 4-barcode, 8-xfilter,
      16-filter, 32-asm)
    inputBinding:
      position: 101
      prefix: --flag
  - id: sample_id_list_file
    type:
      - 'null'
      - File
    doc: sample id list file
    inputBinding:
      position: 101
      prefix: --id
  - id: slurm
    type:
      - 'null'
      - boolean
    doc: Indiates submit to slurm system
    inputBinding:
      position: 101
      prefix: --slurm
  - id: te_lib_config_file
    type:
      - 'null'
      - File
    doc: TE lib config file
    inputBinding:
      position: 101
      prefix: --lib
  - id: time_limit
    type:
      - 'null'
      - string
    doc: Time limit
    inputBinding:
      position: 101
      prefix: --time
  - id: tumor
    type:
      - 'null'
      - boolean
    doc: Working on tumor samples
    inputBinding:
      position: 101
      prefix: --tumor
  - id: user
    type:
      - 'null'
      - boolean
    doc: Use user specific parameters instead of automatically calculated ones
    inputBinding:
      position: 101
      prefix: --user
  - id: working_folder
    type:
      - 'null'
      - Directory
    doc: Working folder
    inputBinding:
      position: 101
      prefix: --path
  - id: xtea_folder
    type:
      - 'null'
      - Directory
    doc: xTEA folder
    inputBinding:
      position: 101
      prefix: --xtea
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtea:0.1.9--hdfd78af_0
