cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg_align
label: ufcg_align
doc: "Align genes and provide multiple sequence alignments from UFCG profiles\n\n\
  Tool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: align_multiple_copied_genes
    type:
      - 'null'
      - boolean
    doc: Align multiple copied genes
    inputBinding:
      position: 101
      prefix: -c
  - id: alignment_method
    type:
      - 'null'
      - string
    doc: Alignment method {nucleotide, codon, codon12, protein}
    default: protein
    inputBinding:
      position: 101
      prefix: -a
  - id: continue_from_checkpoint
    type:
      - 'null'
      - boolean
    doc: Continue from the checkpoint
    inputBinding:
      position: 101
      prefix: -k
  - id: developer
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: gap_rich_filter_threshold
    type:
      - 'null'
      - int
    doc: Gap-rich filter percentage threshold {0 - 100}
    default: 50
    inputBinding:
      position: 101
      prefix: -f
  - id: input_profiles
    type: Directory
    doc: Input directory containing UFCG profiles
    inputBinding:
      position: 101
      prefix: -i
  - id: label_format
    type:
      - 'null'
      - string
    doc: 'Label format, comma-separated string containing one or more of the following
      keywords: {uid, acc, label, taxon, strain, type, taxonomy}'
    inputBinding:
      position: 101
      prefix: -l
  - id: mafft_binary_path
    type:
      - 'null'
      - string
    doc: Path to MAFFT binary
    default: mafft-linsi
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
  - id: run_name
    type:
      - 'null'
      - string
    doc: Name of this run
    default: align
    inputBinding:
      position: 101
      prefix: -n
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
    doc: Output directory for alignments
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
