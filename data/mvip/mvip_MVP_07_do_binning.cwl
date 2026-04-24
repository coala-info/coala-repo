cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_07_do_binning
label: mvip_MVP_07_do_binning
doc: "Run vRhyme for binning virus genomes and return outputs.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: binning_sample_group
    type:
      - 'null'
      - string
    doc: Specific sample number(s) to run the script on. You can provide a 
      comma-separated list (1,2,3,4) or a range (1:4).
    inputBinding:
      position: 101
      prefix: --binning_sample_group
  - id: checkv_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the CheckV database directory.
    inputBinding:
      position: 101
      prefix: --checkv_db_path
  - id: delete_files
    type:
      - 'null'
      - boolean
    doc: flag to delete unwanted files
    inputBinding:
      position: 101
      prefix: --delete_files
  - id: filtration
    type:
      - 'null'
      - string
    doc: Filtration level ("relaxed" or "conservative").
    inputBinding:
      position: 101
      prefix: --filtration
  - id: force_checkv
    type:
      - 'null'
      - boolean
    doc: Force execution of all steps, even if final_annotation_output_file 
      exists.
    inputBinding:
      position: 101
      prefix: --force_checkv
  - id: force_outputs
    type:
      - 'null'
      - boolean
    doc: Force execution of all steps, even if final_annotation_output_file 
      exists.
    inputBinding:
      position: 101
      prefix: --force_outputs
  - id: force_read_mapping
    type:
      - 'null'
      - boolean
    doc: Force execution of all steps, even if final_annotation_output_file 
      exists.
    inputBinding:
      position: 101
      prefix: --force_read_mapping
  - id: force_vrhyme
    type:
      - 'null'
      - boolean
    doc: Force execution of all steps, even if final_annotation_output_file 
      exists.
    inputBinding:
      position: 101
      prefix: --force_vrhyme
  - id: host_viral_genes_ratio
    type:
      - 'null'
      - float
    doc: the maximum ratio of host genes to viral genes required to include a 
      virus prediction
    inputBinding:
      position: 101
      prefix: --host_viral_genes_ratio
  - id: interleaved
    type:
      - 'null'
      - string
    doc: Enable or disable the --interleaved option in Bowtie2 command 
      (TRUE/FALSE)
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: keep_bam
    type:
      - 'null'
      - boolean
    doc: Flag to indicate whether to keep BAM files
    inputBinding:
      position: 101
      prefix: --keep_bam
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: normalization
    type:
      - 'null'
      - string
    doc: Metrics to normalize
    inputBinding:
      position: 101
      prefix: --normalization
  - id: read_mapping_sample_group
    type:
      - 'null'
      - string
    doc: Specific sample number(s) to run the script on. You can provide a 
      comma-separated list (1,2,3,4) or a range (1:4).
    inputBinding:
      position: 101
      prefix: --read_mapping_sample_group
  - id: read_type
    type:
      - 'null'
      - string
    doc: Sequencing data type (e.g. short vs long reads).
    inputBinding:
      position: 101
      prefix: --read_type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: viral_min_genes
    type:
      - 'null'
      - int
    doc: the minimum number of viral genes required to include a virus 
      prediction
    inputBinding:
      position: 101
      prefix: --viral_min_genes
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_07_do_binning.out
