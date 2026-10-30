cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_fasta_to_snps_table.py
label: vsnp3_vsnp3_fasta_to_snps_table.py
doc: "Build a SNP table and RAxML tree from an aligned FASTA file.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: fasta
    type: File
    doc: Provide an alignment file in FASTA format
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
  - id: parsimonious
    type:
      - 'null'
      - boolean
    doc: Only keep parsimonious SNPs from FASTA alignment file. This is different than the
      uninformative SNPs removed via vSNP pipeline. This is to be used when just working with
      an aligned FASTA file.
    inputBinding:
      position: 101
      prefix: -p
  - id: show_groups
    type:
      - 'null'
      - boolean
    doc: Show group names in SNP table
    inputBinding:
      position: 101
      prefix: --show_groups
  - id: hash_names
    type:
      - 'null'
      - boolean
    doc: Hash FASTA names to rid of any RAxML illegal characters
    inputBinding:
      position: 101
      prefix: -n
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Optional: Keep debugging files and run without pooling'
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tree
    type: &id001
      type: array
      items: File
    doc: Tree files
    outputBinding:
      glob: '*.tre'
  - id: tables
    type: *id001
    doc: SNP tables
    outputBinding:
      glob: '*.xlsx'
  - id: parsimonious_fasta
    type: *id001
    doc: Parsimonious alignment
    outputBinding:
      glob: '*parsimonious*.fasta'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_fasta_to_snps_table.py.stdout.txt
