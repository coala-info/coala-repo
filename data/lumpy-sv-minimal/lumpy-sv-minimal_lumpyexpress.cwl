cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpyexpress
label: lumpy-sv-minimal_lumpyexpress
doc: "Sourcing executables from /usr/local/bin/lumpyexpress.config ...\n\nTool homepage:
  https://github.com/arq5x/lumpy-sv"
inputs:
  - id: bedpe_file_of_depths
    type:
      - 'null'
      - type: array
        items: File
    doc: 'bedpe file of depths (comma separated and prefixed by sample: e.g sample_x:/path/to/sample_x.bedpe,sample_y:/path/to/sample_y.bedpe)'
    inputBinding:
      position: 101
      prefix: -d
  - id: config_file
    type:
      - 'null'
      - File
    doc: path to lumpyexpress.config file
    inputBinding:
      position: 101
      prefix: -K
  - id: discordant_reads_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: discordant reads BAM files(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -D
  - id: exclude_bed_file
    type:
      - 'null'
      - File
    doc: BED file to exclude
    inputBinding:
      position: 101
      prefix: -x
  - id: full_bam_cram_files
    type:
      type: array
      items: File
    doc: full BAM or CRAM file(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -B
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: keep temporary files
    inputBinding:
      position: 101
      prefix: -k
  - id: min_sample_weight
    type:
      - 'null'
      - int
    doc: minimum sample weight for a call
    inputBinding:
      position: 101
      prefix: -m
  - id: output_probability_curves
    type:
      - 'null'
      - boolean
    doc: output probability curves for each variant
    inputBinding:
      position: 101
      prefix: -P
  - id: reference_genome_fasta
    type:
      - 'null'
      - File
    doc: indexed reference genome fasta file (recommended for CRAMs)
    inputBinding:
      position: 101
      prefix: -R
  - id: split_reads_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: split reads BAM file(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -S
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: temp directory
    inputBinding:
      position: 101
      prefix: -T
  - id: trim_threshold
    type:
      - 'null'
      - float
    doc: trim threshold
    inputBinding:
      position: 101
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
