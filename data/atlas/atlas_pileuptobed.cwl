cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: atlas_pileuptobed
doc: "Create bed file from pileup file\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: pileup_file
    type: File
    doc: Pileup file
    inputBinding:
      position: 1
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth to consider a site
    default: 10000
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to consider
    default: 0.01
    inputBinding:
      position: 102
      prefix: --min-allele-freq
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to consider a site
    default: 1
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for summary statistics
    default: 1000
    inputBinding:
      position: 102
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for summary statistics
    default: 1000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: Output BED file
    outputBinding:
      glob: $(inputs.output_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
