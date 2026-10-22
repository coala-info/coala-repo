cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - simSV
label: survivor_simSV
doc: "Simulate SVs and SNPs on a reference genome\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: reference
    type: File
    doc: "Reference fasta file."
    inputBinding:
      position: 1
  - id: parameter_file
    type: File
    doc: "Parameter file (a template is written by running SURVIVOR simSV with only a file name)."
    inputBinding:
      position: 2
  - id: snp_frequency
    type: float
    doc: "SNP mutations frequency (0-1)."
    inputBinding:
      position: 3
  - id: real_reads
    type: int
    doc: "0= simulated reads; 1= real reads."
    inputBinding:
      position: 4
  - id: output_prefix
    type: string
    doc: "Output prefix."
    inputBinding:
      position: 5
outputs:
  - id: genome
    type: File
    doc: "Modified reference."
    outputBinding:
      glob: '$(inputs.output_prefix).fasta'
  - id: events
    type: File
    doc: "Simulated events (BED)."
    outputBinding:
      glob: '$(inputs.output_prefix).bed'
  - id: insertions
    type: File
    doc: "Inserted sequences."
    outputBinding:
      glob: '$(inputs.output_prefix).insertions.fa'
  - id: truth_vcf
    type: File
    doc: "Simulated SVs and SNPs as VCF."
    outputBinding:
      glob: '$(inputs.output_prefix).vcf'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_simSV.out
