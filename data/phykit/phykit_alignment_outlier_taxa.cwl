cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - alignment_outlier_taxa
label: phykit_alignment_outlier_taxa
doc: Identify potential outlier taxa in an alignment based on features like gap 
  rate, occupancy, composition distance, long branch proxy, rcvt, and entropy 
  burden.
inputs:
  - id: alignment
    type: File
    doc: Alignment file to be analyzed
    inputBinding:
      position: 1
  - id: gap_z
    type:
      - 'null'
      - float
    doc: z-threshold for gap_rate outlier detection
    inputBinding:
      position: 102
      prefix: --gap-z
  - id: composition_z
    type:
      - 'null'
      - float
    doc: z-threshold for composition_distance outlier detection
    inputBinding:
      position: 102
      prefix: --composition-z
  - id: distance_z
    type:
      - 'null'
      - float
    doc: z-threshold for long_branch_proxy outlier detection
    inputBinding:
      position: 102
      prefix: --distance-z
  - id: rcvt_z
    type:
      - 'null'
      - float
    doc: z-threshold for rcvt outlier detection
    inputBinding:
      position: 102
      prefix: --rcvt-z
  - id: occupancy_z
    type:
      - 'null'
      - float
    doc: z-threshold for low-occupancy outlier detection
    inputBinding:
      position: 102
      prefix: --occupancy-z
  - id: entropy_z
    type:
      - 'null'
      - float
    doc: z-threshold for entropy_burden outlier detection
    inputBinding:
      position: 102
      prefix: --entropy-z
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_alignment_outlier_taxa.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
