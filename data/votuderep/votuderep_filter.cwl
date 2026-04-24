cwlVersion: v1.2
class: CommandLineTool
baseCommand: votuderep filter
label: votuderep_filter
doc: "Filter FASTA file using CheckV quality metrics.\n\nTool homepage: https://github.com/quadram-institute-bioscience/votuderep"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file with viral contigs
    inputBinding:
      position: 1
  - id: checkv_out
    type: File
    doc: TSV output file from CheckV
    inputBinding:
      position: 2
  - id: complete
    type:
      - 'null'
      - boolean
    doc: Only keep contigs with checkv_quality == 'Complete'
    inputBinding:
      position: 103
  - id: exclude_undetermined
    type:
      - 'null'
      - boolean
    doc: Exclude contigs with checkv_quality == 'Not-determined'
    inputBinding:
      position: 103
  - id: max_contam
    type:
      - 'null'
      - float
    doc: Maximum contamination percentage
    inputBinding:
      position: 103
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum contig length (0 = unlimited)
    inputBinding:
      position: 103
  - id: min_completeness
    type:
      - 'null'
      - float
    doc: Minimum completeness percentage
    inputBinding:
      position: 103
      prefix: -c
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum contig length
    inputBinding:
      position: 103
      prefix: -m
  - id: min_quality
    type:
      - 'null'
      - string
    doc: 'Minimum quality level: low (includes Low/Medium/High/Complete), medium (Medium/High/Complete),
      or high (High/Complete)'
    inputBinding:
      position: 103
  - id: no_warnings
    type:
      - 'null'
      - boolean
    doc: Only keep contigs with no warnings
    inputBinding:
      position: 103
  - id: provirus
    type:
      - 'null'
      - boolean
    doc: Only select proviruses (provirus == 'Yes')
    inputBinding:
      position: 103
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
