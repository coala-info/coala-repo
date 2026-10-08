cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep3
  - classify
label: haplogrep3_classify
doc: "Classify mtDNA profiles (VCF, FASTA or HSD) into haplogroups.\n\nTool homepage: https://github.com/genepi/haplogrep3"
inputs:
  - id: chip
    type:
      - 'null'
      - boolean
    doc: "VCF data from a genotype chip"
    inputBinding:
      position: 101
      prefix: --chip
  - id: extend_report
    type:
      - 'null'
      - boolean
    doc: "Add flag for a extended final output"
    inputBinding:
      position: 101
      prefix: --extend-report
  - id: het_level
    type:
      - 'null'
      - float
    doc: "Add heteroplasmies with a level > X from the VCF file to the profile (default: 0.9)"
    inputBinding:
      position: 101
      prefix: --hetLevel
  - id: hits
    type:
      - 'null'
      - int
    doc: "Calculate best n hits"
    inputBinding:
      position: 101
      prefix: --hits
  - id: input
    type: File
    doc: "Input file (vcf, fasta, hsd)"
    inputBinding:
      position: 101
      prefix: --in
  - id: metric
    type:
      - 'null'
      - string
    doc: "Distance (metric) used for the classification"
    inputBinding:
      position: 101
      prefix: --metric
  - id: out
    type: string
    doc: "Output file location"
    inputBinding:
      position: 101
      prefix: --out
  - id: skip_alignment_rules
    type:
      - 'null'
      - boolean
    doc: "Skip nomenclature fixes based on rules for FASTA import"
    inputBinding:
      position: 101
      prefix: --skip-alignment-rules
  - id: tree
    type: string
    doc: "Tree Id (for example phylotree-rcrs@17.2)"
    inputBinding:
      position: 101
      prefix: --tree
  - id: write_fasta
    type:
      - 'null'
      - boolean
    doc: "Write results in fasta format"
    inputBinding:
      position: 101
      prefix: --write-fasta
  - id: write_fasta_msa
    type:
      - 'null'
      - boolean
    doc: "Write multiple sequence alignment (_MSA.fasta)"
    inputBinding:
      position: 101
      prefix: --write-fasta-msa
  - id: write_qc
    type:
      - 'null'
      - boolean
    doc: "Write quality control results into csvfile"
    inputBinding:
      position: 101
      prefix: --write-qc
outputs:
  - id: haplogroups
    type: File
    doc: "Haplogroup classification table"
    outputBinding:
      glob: $(inputs.out)
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Sequences in FASTA format, written with --write-fasta"
    outputBinding:
      glob: $(inputs.out.replace(/\.[^.\/]*$/, '')).fasta
  - id: msa_out
    type:
      - 'null'
      - File
    doc: "Multiple sequence alignment, written with --write-fasta-msa"
    outputBinding:
      glob: $(inputs.out.replace(/\.[^.\/]*$/, ''))_MSA.fasta
  - id: qc_out
    type:
      - 'null'
      - File
    doc: "Quality control report, written with --write-qc"
    outputBinding:
      glob: $(inputs.out.replace(/\.[^.\/]*$/, '')).qc.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
