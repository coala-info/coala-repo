cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer count-orfs-codon
label: ribotricer_count-orfs-codon
doc: "Count reads for detected ORFs at codon level\n\nTool homepage: https://github.com/smithlabcode/ribotricer"
inputs:
  - id: detected_orfs
    type: File
    doc: Path to the detected orfs file This file should be generated using 
      ribotricer detect-orfs
    inputBinding:
      position: 101
      prefix: --detected_orfs
  - id: features
    type: string
    doc: ORF types separated with comma
    inputBinding:
      position: 101
      prefix: --features
  - id: prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: Whether output all ORFs including those non-translating ones
    inputBinding:
      position: 101
      prefix: --report_all
  - id: ribotricer_index
    type: File
    doc: Path to the index file of ribotricer This file should be generated 
      using ribotricer prepare-orfs
    inputBinding:
      position: 101
      prefix: --ribotricer_index
  - id: ribotricer_index_fasta
    type: File
    doc: Path to ORF seq file
    inputBinding:
      position: 101
      prefix: --ribotricer_index_fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
stdout: ribotricer_count-orfs-codon.out
