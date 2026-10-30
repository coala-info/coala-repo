cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_merge_vcf_into_fasta.py
label: vsnp_vsnp_merge_vcf_into_fasta.py
doc: "Merge VCF changes into a FASTA sequence and write <vcf>_merged_into_<fasta>.fasta.\n\
  \nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: fasta_file
    type: File
    doc: 'REQUIRED: In file to be processed'
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
  - id: vcf_file
    type: File
    doc: 'REQUIRED: In file to be processed'
    inputBinding:
      position: 101
      prefix: -v
      valueFrom: $(self.basename)
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: 'OPTIONAL: QUAL values below this value will not be applied.'
    inputBinding:
      position: 101
      prefix: -q
  - id: map_threshold
    type:
      - 'null'
      - int
    doc: 'OPTIONAL: Map Quality values below this value will not be applied.'
    inputBinding:
      position: 101
      prefix: -m
  - id: ambiguity_not
    type:
      - 'null'
      - boolean
    doc: 'OPTIONAL: when -a used ambiguity will not be applied. By default it will be applied.'
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: merged_fasta
    type: File
    doc: FASTA with the VCF changes applied
    outputBinding:
      glob: '*_merged_into_*.fasta'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
      - entry: $(inputs.vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_merge_vcf_into_fasta.py.out
