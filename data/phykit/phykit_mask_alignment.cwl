cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - mask_alignment
label: phykit_mask_alignment
doc: 'Mask alignment sites based on threshold criteria. Sites are retained when they
  pass all active thresholds: maximum gap fraction, minimum occupancy, and maximum
  site entropy.'
inputs:
  - id: alignment
    type: File
    doc: first argument after function name should be an alignment file
    inputBinding:
      position: 1
  - id: max_gap
    type:
      - 'null'
      - float
    doc: maximum allowed fraction of missing/invalid characters at a site
    inputBinding:
      position: 102
      prefix: --max_gap
  - id: min_occupancy
    type:
      - 'null'
      - float
    doc: minimum required occupancy at a site
    inputBinding:
      position: 102
      prefix: --min_occupancy
  - id: max_entropy
    type:
      - 'null'
      - float
    doc: maximum allowed site entropy
    inputBinding:
      position: 102
      prefix: --max_entropy
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
stdout: phykit_mask_alignment.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
