cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutserve call
label: mutserve_call
doc: "Call homoplasmic and heteroplasmic positions.\n\nTool homepage: https://github.com/seppinho/mutserve"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: BAM/CRAM files
    inputBinding:
      position: 1
  - id: align_quality
    type:
      - 'null'
      - int
    doc: Minimum Align Quality
    inputBinding:
      position: 102
      prefix: --alignQ
  - id: base_quality
    type:
      - 'null'
      - int
    doc: Minimum Base Quality
    inputBinding:
      position: 102
      prefix: --baseQ
  - id: call_deletions
    type:
      - 'null'
      - boolean
    doc: Call deletions (beta)
    inputBinding:
      position: 102
      prefix: --deletions
  - id: call_insertions
    type:
      - 'null'
      - boolean
    doc: Call insertions (beta)
    inputBinding:
      position: 102
      prefix: --insertions
  - id: contig_name
    type:
      - 'null'
      - string
    doc: Specifify mtDNA contig name
    inputBinding:
      position: 102
      prefix: --contig-name
  - id: disable_ansi
    type:
      - 'null'
      - boolean
    doc: Disable ANSI support
    inputBinding:
      position: 102
      prefix: --no-ansi
  - id: enable_baq
    type:
      - 'null'
      - boolean
    doc: Enable BAQ
    inputBinding:
      position: 102
      prefix: --baq
  - id: excluded_samples
    type:
      - 'null'
      - string
    doc: Specifify mutserve mode
    inputBinding:
      position: 102
      prefix: --excluded-samples
  - id: heteroplasmy_level
    type:
      - 'null'
      - string
    doc: Minimum Heteroplasmy Level
    inputBinding:
      position: 102
      prefix: --level
  - id: map_quality
    type:
      - 'null'
      - int
    doc: Minimum Map Quality
    inputBinding:
      position: 102
      prefix: --mapQ
  - id: mode
    type:
      - 'null'
      - string
    doc: Specifify mutserve mode
    inputBinding:
      position: 102
      prefix: --mode
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output (txt or vcf)
    inputBinding:
      position: 102
      prefix: --output
  - id: reference
    type:
      - 'null'
      - string
    doc: Reference
    inputBinding:
      position: 102
      prefix: --reference
  - id: strand_bias
    type:
      - 'null'
      - string
    doc: Set Strand Bias
    inputBinding:
      position: 102
      prefix: --strand-bias
  - id: threads
    type:
      - 'null'
      - string
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_frequency_file
    type:
      - 'null'
      - boolean
    doc: Use Frequency File
    inputBinding:
      position: 102
      prefix: --no-freq
  - id: write_fasta
    type:
      - 'null'
      - boolean
    doc: Write fasta file
    inputBinding:
      position: 102
      prefix: --write-fasta
  - id: write_raw
    type:
      - 'null'
      - boolean
    doc: Write raw file
    inputBinding:
      position: 102
      prefix: --write-raw
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutserve:2.0.3--hdfd78af_0
stdout: mutserve_call.out
