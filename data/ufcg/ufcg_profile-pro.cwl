cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg_profile-pro
label: ufcg_profile-pro
doc: "Extract UFCG profile from Fungal proteome\n\nTool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: developer_mode
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: E-value cutoff for validation
    inputBinding:
      position: 101
      prefix: --evalue
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force to overwrite the existing files
    inputBinding:
      position: 101
      prefix: -f
  - id: info
    type:
      - 'null'
      - string
    doc: Comma-separated metadata string (Filename*, Label*, Accession*, Taxon, 
      NCBI, Strain, Taxonomy)
    inputBinding:
      position: 101
      prefix: --info
  - id: input_file
    type: string
    doc: File containing fungal protein sequences
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_temporary
    type:
      - 'null'
      - boolean
    doc: Keep the temporary products
    inputBinding:
      position: 101
      prefix: -k
  - id: mmseqs_binary
    type:
      - 'null'
      - string
    doc: Path to MMseqs2 binary
    inputBinding:
      position: 101
      prefix: --mmseqs
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
  - id: sequence_path
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing gene sequences
    inputBinding:
      position: 101
      prefix: --seqpath
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write the temporary files
    inputBinding:
      position: 101
      prefix: -w
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
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
