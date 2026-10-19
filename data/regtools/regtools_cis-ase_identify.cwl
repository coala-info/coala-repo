cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - cis-ase
  - identify
label: regtools_cis-ase_identify
doc: "Identify cis allele specific expression.\n\nTool homepage: https://github.com/griffithlab/regtools"
inputs:
  - id: output_file
    type: string
    doc: "Output file containing the ase variants in VCF format."
    inputBinding:
      position: 1
      prefix: -o
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum total read-depth for a somatic/ASE variant. [10]"
    inputBinding:
      position: 1
      prefix: -d
  - id: window
    type:
      - 'null'
      - int
    doc: "Window around a somatic variant to look for transcripts. ASE variants will be in these transcripts. [1000]"
    inputBinding:
      position: 1
      prefix: -w
  - id: binomial
    type:
      - 'null'
      - boolean
    doc: "Use the binomial model for modeling ASE in RNAseq (uses the beta model by default)"
    inputBinding:
      position: 1
      prefix: -B
  - id: all_polymorphisms
    type:
      - 'null'
      - boolean
    doc: "Look at all polymorphisms for ASE, not just exonic."
    inputBinding:
      position: 1
      prefix: -E
  - id: somatic_variants
    type: File
    doc: "Somatic variants (VCF)."
    inputBinding:
      position: 100
  - id: polymorphisms
    type: File
    doc: "Polymorphisms (VCF; when bgzipped, the .tbi index must sit beside it)."
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
  - id: tumor_dna_alignments
    type: File
    doc: "Tumor DNA alignments (BAM)."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 102
  - id: tumor_rna_alignments
    type: File
    doc: "Tumor RNA alignments (BAM)."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 103
  - id: reference
    type: File
    doc: "Reference genome FASTA (ref.fa)."
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 104
  - id: annotations
    type: File
    doc: "Gene annotations in GTF format."
    inputBinding:
      position: 105
outputs:
  - id: out_output_file
    type: File
    doc: "ASE variants (VCF)"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
