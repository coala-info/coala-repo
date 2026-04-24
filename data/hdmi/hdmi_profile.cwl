cwlVersion: v1.2
class: CommandLineTool
baseCommand: hdmi_profile
label: hdmi_profile
doc: "Profile HDMI sequencing data\n\nTool homepage: https://github.com/HaoranPeng21/HDMI"
inputs:
  - id: genome_path
    type: Directory
    doc: Directory containing genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome_path
  - id: group_info
    type: File
    doc: Group info file
    inputBinding:
      position: 101
      prefix: --group_info
  - id: hgt_table
    type:
      - 'null'
      - File
    doc: HGT events table (auto-found in output directory if not provided)
    inputBinding:
      position: 101
      prefix: --hgt_table
  - id: prefix
    type:
      - 'null'
      - string
    doc: Sample prefix (auto-extracted from read1 filename if not provided)
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: read1
    type: File
    doc: Path to read1 FASTQ file
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: Path to read2 FASTQ file
    inputBinding:
      position: 101
      prefix: --read2
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: sth
    type:
      - 'null'
      - int
    doc: Read span threshold
    inputBinding:
      position: 101
      prefix: --sth
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
