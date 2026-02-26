cwlVersion: v1.2
class: CommandLineTool
baseCommand: segmentation-fold
label: segmentation-fold
doc: "Calculates RNA secondary structure and folding parameters.\n\nTool homepage:
  https://github.com/shreyapamecha/Speed-Estimation-of-Vehicles-with-Plate-Detection"
inputs:
  - id: default_xml
    type:
      - 'null'
      - boolean
    doc: Show path to default "segments.xml" on system
    inputBinding:
      position: 101
      prefix: --default-xml
  - id: enable_segment
    type:
      - 'null'
      - boolean
    doc: Enable/disable segment functionality
    default: 1
    inputBinding:
      position: 101
      prefix: -p
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Path of FASTA_FILE containing sequence(s)
    inputBinding:
      position: 101
      prefix: -f
  - id: min_hairpin_size
    type:
      - 'null'
      - int
    doc: Minimum hairpin size
    default: 3
    inputBinding:
      position: 101
      prefix: -H
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads; 0 = maximum available
    default: 3
    inputBinding:
      position: 101
      prefix: -t
  - id: segments_xml
    type:
      - 'null'
      - File
    doc: Use custom "segments.xml"-syntaxed file
    inputBinding:
      position: 101
      prefix: -x
  - id: sequence
    type:
      - 'null'
      - string
    doc: Specific RNA SEQUENCE (overrules -f)
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold.out
