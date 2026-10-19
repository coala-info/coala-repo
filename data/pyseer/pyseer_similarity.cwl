cwlVersion: v1.2
class: CommandLineTool
baseCommand: similarity_pyseer
label: pyseer_similarity
doc: "Calculate a similarity matrix using variant presence/absence information.\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: samples
    type: File
    doc: List of sample names to use.
    inputBinding:
      position: 1
  - id: kmers
    type:
      - 'null'
      - File
    doc: Kmers file.
    inputBinding:
      position: 2
      prefix: --kmers
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file. Will filter any non 'PASS' sites.
    inputBinding:
      position: 2
      prefix: --vcf
  - id: pres
    type:
      - 'null'
      - File
    doc: Presence/absence .Rtab matrix as produced by roary and piggy.
    inputBinding:
      position: 2
      prefix: --pres
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum AF.
    inputBinding:
      position: 3
      prefix: --min-af
  - id: max_af
    type:
      - 'null'
      - float
    doc: Maximum AF.
    inputBinding:
      position: 3
      prefix: --max-af
  - id: max_missing
    type:
      - 'null'
      - float
    doc: Maximum missing (vcf/Rtab).
    inputBinding:
      position: 3
      prefix: --max-missing
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Uncompressed kmers file.
    inputBinding:
      position: 3
      prefix: --uncompressed
outputs:
  - id: similarity_matrix
    type: stdout
    doc: Similarity matrix
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer_similarity.out
