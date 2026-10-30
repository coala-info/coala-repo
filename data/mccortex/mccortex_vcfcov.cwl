cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - vcfcov
label: mccortex_vcfcov
doc: "Add coverage from cortex graphs to a VCF file.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory to use (for example 1GB, 500M, 20GB). Default 1GB.
    inputBinding:
      position: 1
      prefix: --memory
  - id: nkmers
    type:
      - 'null'
      - string
    doc: Number of hash table entries (for example 4M, 1G). Default 4M.
    inputBinding:
      position: 1
      prefix: --nkmers
  - id: out
    type: string
    default: vcfcov.vcf
    doc: Output VCF file.
    inputBinding:
      position: 1
      prefix: --out
  - id: out_fmt
    type:
      - 'null'
      - string
    doc: 'Output format: vcf, vcfgz, bcf or ubcf.'
    inputBinding:
      position: 1
      prefix: --out-fmt
  - id: ref
    type: File
    doc: Reference FASTA file; its index (.fai) must be next to it.
    inputBinding:
      position: 1
      prefix: --ref
    secondaryFiles:
      - pattern: .fai
        required: true
  - id: max_var_len
    type:
      - 'null'
      - int
    doc: Only use alleles up to this many bases long (default 100).
    inputBinding:
      position: 1
      prefix: --max-var-len
  - id: max_nvars
    type:
      - 'null'
      - int
    doc: Limit haplotypes to this many variants (default 8).
    inputBinding:
      position: 1
      prefix: --max-nvars
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Two passes of the VCF to load only needed k-mers (default).
    inputBinding:
      position: 1
      prefix: --low-mem
  - id: high_mem
    type:
      - 'null'
      - boolean
    doc: One pass of the VCF, all k-mers loaded (when streaming a VCF).
    inputBinding:
      position: 1
      prefix: --high-mem
  - id: vcf
    type: File
    doc: Input VCF file, sorted by position with duplicates removed.
    inputBinding:
      position: 100
  - id: graph
    type:
      type: array
      items: File
    doc: Input cortex graph file(s) (.ctx); uncleaned graphs are recommended.
    inputBinding:
      position: 101
outputs:
  - id: vcf_out
    type: File
    doc: VCF file with coverage added.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
