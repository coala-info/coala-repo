cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep
  - classify
label: haplogrep_classify
doc: "mtDNA haplogroup classification of VCF, FASTA or HSD input.\n\nTool homepage:
  https://github.com/seppinho/haplogrep-cmd"
inputs:
  - id: chip
    type:
      - 'null'
      - boolean
    doc: VCF data from a genotype chip
    inputBinding:
      position: 101
      prefix: --chip
  - id: extend_report
    type:
      - 'null'
      - boolean
    doc: Add flag for a extended final output
    inputBinding:
      position: 101
      prefix: --extend-report
  - id: format
    type: string
    doc: 'Specify input file format: vcf, fasta or hsd'
    inputBinding:
      position: 101
      prefix: --format
  - id: het_level
    type:
      - 'null'
      - float
    doc: 'Add heteroplasmies with a level > X from the VCF file to the profile (default:
      0.9)'
    inputBinding:
      position: 101
      prefix: --hetLevel
  - id: hits
    type:
      - 'null'
      - int
    doc: Calculate best n hits
    inputBinding:
      position: 101
      prefix: --hits
  - id: input
    type: File
    doc: Input VCF, fasta or hsd file
    inputBinding:
      position: 101
      prefix: --in
  - id: lineage
    type:
      - 'null'
      - int
    doc: Export lineage information as dot file, 0=no tree, 1=with SNPs, 2=only
      structure, no SNPs
    inputBinding:
      position: 101
      prefix: --lineage
  - id: metric
    type:
      - 'null'
      - string
    doc: Specifiy other metrics (hamming or jaccard) than default (kulczynski)
    inputBinding:
      position: 101
      prefix: --metric
  - id: out
    type: string
    doc: Output file location
    inputBinding:
      position: 101
      prefix: --out
  - id: phylotree
    type:
      - 'null'
      - string
    doc: Specify phylotree version
    inputBinding:
      position: 101
      prefix: --phylotree
  - id: rsrs
    type:
      - 'null'
      - boolean
    doc: Use RSRS Version
    inputBinding:
      position: 101
      prefix: --rsrs
  - id: skip_alignment_rules
    type:
      - 'null'
      - boolean
    doc: Skip mtDNA nomenclature fixes based on rules for FASTA import
    inputBinding:
      position: 101
      prefix: --skip-alignment-rules
  - id: write_fasta
    type:
      - 'null'
      - boolean
    doc: Write results in fasta format
    inputBinding:
      position: 101
      prefix: --write-fasta
  - id: write_fasta_msa
    type:
      - 'null'
      - boolean
    doc: Write multiple sequence alignment (_MSA.fasta)
    inputBinding:
      position: 101
      prefix: --write-fasta-msa
outputs:
  - id: haplogroups
    type: File
    doc: Haplogroup classification table
    outputBinding:
      glob: $(inputs.out)
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: Sequences in FASTA format, written with --write-fasta
    outputBinding:
      glob: $(inputs.out.replace(/\.[^.\/]*$/, '')).fasta
  - id: msa_out
    type:
      - 'null'
      - File
    doc: Multiple sequence alignment, written with --write-fasta-msa
    outputBinding:
      glob: $(inputs.out.replace(/\.[^.\/]*$/, ''))_MSA.fasta
  - id: lineage_dot
    type:
      - 'null'
      - File
    doc: Lineage tree as dot file, written with --lineage
    outputBinding:
      glob: $(inputs.out.replace(/\.[^.\/]*$/, '')).dot
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep:2.4.0--hdfd78af_0
