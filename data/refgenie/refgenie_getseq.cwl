cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie getseq
label: refgenie_getseq
doc: "Get sequences from a genome.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: genome
    type: string
    doc: Reference assembly ID, e.g. mm10.
    inputBinding:
      position: 101
      prefix: --genome
  - id: genome_config
    type:
      - 'null'
      - File
    doc: Path to local genome configuration file. Optional if REFGENIE 
      environment variable is set.
    inputBinding:
      position: 101
      prefix: --genome-config
  - id: locus
    type: string
    doc: Coordinates of desired sequence; e.g. 'chr1:50000-50200'.
    inputBinding:
      position: 101
      prefix: --locus
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 101
      prefix: --skip-read-lock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_getseq.out
