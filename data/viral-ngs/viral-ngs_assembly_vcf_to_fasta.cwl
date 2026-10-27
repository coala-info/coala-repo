cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - vcf_to_fasta
label: viral-ngs_assembly_vcf_to_fasta
doc: "Take input genotypes (VCF) and construct a consensus sequence (fasta) by using majority-read-count alleles in the VCF. Genotypes in the VCF will be ignored; we will use the allele with majority read support (or an ambiguity base if there is no clear majority). Uncalled positions will be emitted as N's.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: true
    doc: "Input VCF file (bgzip-compressed and tabix-indexed, with a .tbi file beside it)"
    inputBinding:
      position: 1
  - id: out_fasta
    type: string
    doc: "Output FASTA file"
    inputBinding:
      position: 2
  - id: trim_ends
    type:
      - 'null'
      - boolean
    doc: "If specified, we will strip off continuous runs of N's from the beginning and end of the sequences before writing to output. Interior N's will not be changed."
    inputBinding:
      position: 20
      prefix: --trim_ends
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "Specify minimum read coverage (with full agreement) to make a call. [default: 3]"
    inputBinding:
      position: 20
      prefix: --min_coverage
  - id: major_cutoff
    type:
      - 'null'
      - float
    doc: "If the major allele is present at a frequency higher than this cutoff, we will call an unambiguous base at that position. If it is equal to or below this cutoff, we will call an ambiguous base representing all possible alleles at that position. [default: 0.5]"
    inputBinding:
      position: 20
      prefix: --major_cutoff
  - id: min_dp_ratio
    type:
      - 'null'
      - float
    doc: "The input VCF file often reports two read depth values (DP)--one for the position as a whole, and one for the sample in question. We can optionally reject calls in which the sample read count is below a specified fraction of the total read count. [default: 0.0]"
    inputBinding:
      position: 20
      prefix: --min_dp_ratio
  - id: name
    type:
      - 'null'
      - type: array
        items: string
    doc: "output sequence names (default: reference names in VCF file)"
    inputBinding:
      position: 30
      prefix: --name
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_fasta_file
    type: File
    doc: "Consensus fasta"
    outputBinding:
      glob: $(inputs.out_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_assembly_vcf_to_fasta.out
