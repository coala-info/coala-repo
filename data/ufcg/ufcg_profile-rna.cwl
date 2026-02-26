cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg profile-rna
label: ufcg_profile-rna
doc: "Extract UFCG profile from Fungal RNA-seq reads\n\nTool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: developer_mode
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: exclude_introns
    type:
      - 'null'
      - boolean
    doc: Exclude introns and store cDNA sequences
    inputBinding:
      position: 101
      prefix: -n
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force to overwrite the existing files
    inputBinding:
      position: 101
      prefix: -f
  - id: input_single_reads
    type: File
    doc: File containing single reads in FASTQ/FASTA format
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_temp_products
    type:
      - 'null'
      - boolean
    doc: Keep the temporary products
    inputBinding:
      position: 101
      prefix: -k
  - id: left_reads
    type: File
    doc: File containing left reads in FASTQ/FASTA format
    inputBinding:
      position: 101
      prefix: -l
  - id: marker_set
    type:
      - 'null'
      - string
    doc: Set of markers to extract - see advanced options for details
    inputBinding:
      position: 101
      prefix: -s
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Remove ANSI escapes from standard output
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: no_time
    type:
      - 'null'
      - boolean
    doc: Remove timestamp in front of the prompt string
    inputBinding:
      position: 101
      prefix: --notime
  - id: paired_mode
    type: int
    doc: 'Paired or unpaired reads (paired: 1; unpaired: 0)'
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode - report results only
    inputBinding:
      position: 101
      prefix: -q
  - id: right_reads
    type: File
    doc: File containing right reads in FASTQ/FASTA format
    inputBinding:
      position: 101
      prefix: -r
  - id: temp_write_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write the temporary files
    default: /tmp
    inputBinding:
      position: 101
      prefix: -w
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make program verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
