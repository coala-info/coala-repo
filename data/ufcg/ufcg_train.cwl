cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg train
label: ufcg_train
doc: "Train and generate sequence model of fungal markers\n\nTool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: checkpoint_dir
    type:
      - 'null'
      - Directory
    doc: Checkpoint directory that contains precomputed files
    inputBinding:
      position: 101
      prefix: -c
  - id: developer
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: genome_dir
    type: Directory
    doc: Directory containing reference genome sequences in FASTA format
    inputBinding:
      position: 101
      prefix: -g
  - id: marker_dir
    type: Directory
    doc: Directory containing marker sequences in FASTA format (should be able 
      to build an MSA)
    inputBinding:
      position: 101
      prefix: -i
  - id: nocolor
    type:
      - 'null'
      - boolean
    doc: Remove ANSI escapes from standard output
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: notime
    type:
      - 'null'
      - boolean
    doc: Remove timestamp in front of the prompt string
    inputBinding:
      position: 101
      prefix: --notime
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write temporary files
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
  - id: training_iteration
    type:
      - 'null'
      - int
    doc: Number of training iteration; 0 to iterate until convergence
    default: 0
    inputBinding:
      position: 101
      prefix: -n
  - id: type
    type:
      type: array
      items: string
    doc: Type of marker
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make program verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
