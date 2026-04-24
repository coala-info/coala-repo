cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poretools
  - fasta
label: poretools_fasta
doc: "Extract FASTA sequences from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: end_time
    type:
      - 'null'
      - string
    doc: Only report reads from before end timestamp
    inputBinding:
      position: 102
      prefix: --end
  - id: group
    type:
      - 'null'
      - string
    doc: Base calling group serial number to extract, default 000
    inputBinding:
      position: 102
      prefix: --group
  - id: high_quality
    type:
      - 'null'
      - boolean
    doc: Only report reads with more complement events than template.
    inputBinding:
      position: 102
      prefix: --high-quality
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum read length for FASTA entry to be reported.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length for FASTA entry to be reported.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: normal_quality
    type:
      - 'null'
      - boolean
    doc: Only report reads with fewer complement events than template.
    inputBinding:
      position: 102
      prefix: --normal-quality
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: start_time
    type:
      - 'null'
      - string
    doc: Only report reads from after start timestamp
    inputBinding:
      position: 102
      prefix: --start
  - id: type
    type:
      - 'null'
      - string
    doc: Which type of FASTQ entries should be reported?
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools_fasta.out
