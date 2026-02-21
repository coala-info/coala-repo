cwlVersion: v1.2
class: CommandLineTool
baseCommand: BICseq2-norm.pl
label: bicseq2-norm_BICseq2-norm.pl
doc: "BIC-seq2 normalization for bias correction in NGS data. (Note: The provided
  help text contained only system error logs; arguments are based on standard tool
  documentation).\n\nTool homepage: http://compbio.med.harvard.edu/BIC-seq/"
inputs:
  - id: config_file
    type: File
    doc: Configuration file containing the bin counts and genomic features
    inputBinding:
      position: 1
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: Average fragment size
    inputBinding:
      position: 102
      prefix: -s
  - id: lambda
    type:
      - 'null'
      - float
    doc: Penalty parameter for the roughness of the normalization
    inputBinding:
      position: 102
      prefix: -lambda
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length
    inputBinding:
      position: 102
      prefix: -l
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    inputBinding:
      position: 102
      prefix: -tmp
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for normalization
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_file
    type: File
    doc: Output file for the normalized data
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bicseq2-norm:0.2.4--h7b50bb2_6
