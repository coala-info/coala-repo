cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - typeHLA.js
label: bwakit_typeHLA.js
doc: "Type HLA genes from the alignment of HLA exons to de novo assembled contigs. The
  output is TAB delimited; each GT line has allele1, allele2, mismatches/gaps on primary
  exons, mismatches/gaps on other exons and the number of exons used.\n\nTool homepage: https://github.com/lh3/bwa/tree/master/bwakit"
inputs:
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: drop a contig if the edit distance to the closest gene is >INT
    inputBinding:
      position: 1
      prefix: -n
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: drop a contig if its match too short
    inputBinding:
      position: 1
      prefix: -l
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: drop inconsistent contigs if their length <FLOAT fraction of total length
    inputBinding:
      position: 1
      prefix: -f
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output extra info for debugging
    inputBinding:
      position: 1
      prefix: -d
  - id: exon_to_contig_sam
    type: File
    doc: SAM (plain or gzipped) of HLA exon sequences mapped to the contigs
    inputBinding:
      position: 2
outputs:
  - id: genotypes
    type: stdout
    doc: HLA genotype calls (GT lines)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
stdout: bwakit_typeHLA.js.gt
