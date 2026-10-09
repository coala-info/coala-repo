cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-inspect
label: hisat2-inspect
doc: "Inspect a HISAT2 index: print the indexed sequences as FASTA (default), the
  reference names, a summary of the index, SNPs, splice sites or exons.\n\nTool
  homepage: https://daehwankimlab.github.io/hisat2"
inputs:
  - id: ht2_base
    type: string
    doc: ht2 filename minus trailing .1.ht2/.2.ht2
    inputBinding:
      position: 2
  - id: index_files
    type:
      type: array
      items: File
    doc: HISAT2 index files (.ht2), staged in the working directory so that ht2_base
      resolves
  - id: large_index
    type:
      - 'null'
      - boolean
    doc: Force inspection of the 'large' index, even if a 'small' one is present
    inputBinding:
      position: 1
      prefix: --large-index
  - id: across
    type:
      - 'null'
      - int
    doc: 'Number of characters across in FASTA output (default: 60)'
    inputBinding:
      position: 1
      prefix: --across
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print summary including ref names, lengths, index properties
    inputBinding:
      position: 1
      prefix: --summary
  - id: names
    type:
      - 'null'
      - boolean
    doc: Print reference sequence names only
    inputBinding:
      position: 1
      prefix: --names
  - id: snp
    type:
      - 'null'
      - boolean
    doc: Print SNPs
    inputBinding:
      position: 1
      prefix: --snp
  - id: ss
    type:
      - 'null'
      - boolean
    doc: Print splice sites
    inputBinding:
      position: 1
      prefix: --ss
  - id: ss_all
    type:
      - 'null'
      - boolean
    doc: Print splice sites including those not in the global index
    inputBinding:
      position: 1
      prefix: --ss-all
  - id: exon
    type:
      - 'null'
      - boolean
    doc: Print exons
    inputBinding:
      position: 1
      prefix: --exon
  - id: ht2_ref
    type:
      - 'null'
      - boolean
    doc: Reconstruct reference from .ht2 (slow, preserves colors)
    inputBinding:
      position: 1
      prefix: --ht2-ref
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (for debugging)
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: inspect_output
    type: stdout
    doc: FASTA records, names, summary, SNPs, splice sites or exons of the index
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
stdout: hisat2-inspect.out
