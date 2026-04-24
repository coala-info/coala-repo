cwlVersion: v1.2
class: CommandLineTool
baseCommand: asgal
label: asgal
doc: "ASGAL - Alternative Splicing Graph ALigner\n\nTool homepage: https://asgal.algolab.eu/"
inputs:
  - id: allevents
    type:
      - 'null'
      - boolean
    doc: Use this if you want to detect all events, also annotated ones
    inputBinding:
      position: 101
      prefix: --allevents
  - id: annotation
    type: File
    doc: Path to annotation
    inputBinding:
      position: 101
      prefix: --annotation
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Add debug prints to stderr
    inputBinding:
      position: 101
      prefix: --debug
  - id: e
    type:
      - 'null'
      - int
    doc: Error rate
    inputBinding:
      position: 101
      prefix: --erate
  - id: genome
    type: File
    doc: Path to genome
    inputBinding:
      position: 101
      prefix: --genome
  - id: l
    type:
      - 'null'
      - int
    doc: MEMs length
    inputBinding:
      position: 101
      prefix: --L
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Use this to run ASGAL in genome-wide mode
    inputBinding:
      position: 101
      prefix: --multi
  - id: sample1
    type: File
    doc: Path to sample (1)
    inputBinding:
      position: 101
      prefix: --sample
  - id: sample2
    type:
      - 'null'
      - File
    doc: Path to sample (2)
    inputBinding:
      position: 101
      prefix: --sample2
  - id: split_only
    type:
      - 'null'
      - boolean
    doc: Only split files per gene, do not run ASGAL
    inputBinding:
      position: 101
      prefix: --split-only
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for salmon mapping and parallel gene 
      computation
    inputBinding:
      position: 101
      prefix: --threads
  - id: transcripts
    type:
      - 'null'
      - File
    doc: Path to transcripts
    inputBinding:
      position: 101
      prefix: --transcripts
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Add some prints to stderr
    inputBinding:
      position: 101
      prefix: --verbose
  - id: w
    type:
      - 'null'
      - int
    doc: Minimum intron coverage
    inputBinding:
      position: 101
      prefix: --support
outputs:
  - id: output
    type: Directory
    doc: Path to output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2
