cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg profile
label: ufcg_profile
doc: "Extract UFCG profile from Fungal whole genome sequences\n\nTool homepage: https://ufcg.steineggerlab.com"
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
  - id: input_directory
    type: Directory
    doc: Input directory containing fungal genome assemblies
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep the temporary products
    inputBinding:
      position: 101
      prefix: -k
  - id: markers
    type:
      - 'null'
      - string
    doc: Set of markers to extract - see advanced options for details [PRO]
    inputBinding:
      position: 101
      prefix: -s
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: File to the list containing metadata
    inputBinding:
      position: 101
      prefix: -m
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
  - id: output_directory
    type: Directory
    doc: Output directory to store the result files
    inputBinding:
      position: 101
      prefix: -o
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode - report results only
    inputBinding:
      position: 101
      prefix: -q
  - id: temp_directory
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
stdout: ufcg_profile.out
