cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_04_do_read_mapping
label: mvip_MVP_04_do_read_mapping
doc: "Run CoverM to calculate coverage based on read mapping, using the sorted BAM
  files sorted by reference, and return to one tabular file per sample.\n\nTool homepage:
  https://gitlab.com/ccoclet/mvp"
inputs:
  - id: delete_files
    type:
      - 'null'
      - boolean
    doc: flag to delete unwanted files.
    inputBinding:
      position: 101
      prefix: --delete_files
  - id: force_read_mapping
    type:
      - 'null'
      - boolean
    doc: Do the read mapping even if outputs already exist.
    inputBinding:
      position: 101
      prefix: --force_read_mapping
  - id: interleaved
    type:
      - 'null'
      - string
    doc: Enable or disable the --interleaved option in Bowtie2 command 
      (TRUE/FALSE).
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: read_type
    type:
      - 'null'
      - string
    doc: Sequencing data type (e.g. short vs long reads).
    default: short
    inputBinding:
      position: 101
      prefix: --read_type
  - id: sample_group
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specific sample number(s) to run the script on (can be a comma-separated
      list: 1,2,6 for example). By default, MVP processes all datasets listed in the
      metadata file one after the other.'
    inputBinding:
      position: 101
      prefix: --sample_group
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = 1)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
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
stdout: mvip_MVP_04_do_read_mapping.out
