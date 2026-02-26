cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - haplotagphase
label: whatshap_haplotagphase
doc: "Phase variants in VCF based on information from haplotagged reads\n\nTool homepage:
  https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file with variants to phase (must be gzip-compressed and indexed)
    inputBinding:
      position: 1
  - id: alignments
    type: File
    doc: BAM/CRAM file with alignments tagged by haplotype and phase set
    inputBinding:
      position: 2
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome to phase. If not given, all chromosomes in the input
      VCF are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --chromosome
  - id: cut_poly
    type:
      - 'null'
      - int
    doc: Ignore variants within homopolymers longer than the cut value.
    inputBinding:
      position: 103
      prefix: --cut-poly
  - id: exclude_chromosome
    type:
      - 'null'
      - string
    doc: Name of chromosome not to phase.
    inputBinding:
      position: 103
      prefix: --exclude-chromosome
  - id: gap_threshold
    type:
      - 'null'
      - float
    doc: Threshold percentage for qualities. If the percentage of votes for the 
      variant is less than this value, the algorithm does not assign any 
      information to the variant.
    inputBinding:
      position: 103
      prefix: --gap-threshold
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Ignore read groups in BAM/CRAM header and assume all reads come from 
      the same sample.
    inputBinding:
      position: 103
      prefix: --ignore-read-groups
  - id: no_mav
    type:
      - 'null'
      - boolean
    doc: Ignore multiallelic variants.
    inputBinding:
      position: 103
      prefix: --no-mav
  - id: only_indels
    type:
      - 'null'
      - boolean
    doc: Add phasing information only to indels.
    inputBinding:
      position: 103
      prefix: --only-indels
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file. Must be accompanied by .fai index (create with samtools
      faidx)
    inputBinding:
      position: 103
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of a sample to phase. If not given, all samples in the input VCF 
      are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --sample
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file. If omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
