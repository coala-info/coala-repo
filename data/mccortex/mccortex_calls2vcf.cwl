cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - calls2vcf
label: mccortex_calls2vcf
doc: "Convert a bubble or breakpoint call file to VCF. For a bubble file the mapped flanks (--flanks) are required.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
  - id: out
    type: string
    default: calls.vcf
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
  - id: flanks
    type:
      - 'null'
      - File
    doc: Mapped flanks in SAM or BAM format (required for bubble calls).
    inputBinding:
      position: 1
      prefix: --flanks
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Flank must map with MAPQ at least this value (default 30).
    inputBinding:
      position: 1
      prefix: --min-mapq
  - id: max_align
    type:
      - 'null'
      - int
    doc: Maximum alignment attempted (default 500).
    inputBinding:
      position: 1
      prefix: --max-align
  - id: max_allele
    type:
      - 'null'
      - int
    doc: Maximum allele length printed (default 500).
    inputBinding:
      position: 1
      prefix: --max-allele
  - id: match
    type:
      - 'null'
      - int
    doc: Alignment score for a match (default 1).
    inputBinding:
      position: 1
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: Alignment score for a mismatch (default -2).
    inputBinding:
      position: 1
      prefix: --mismatch
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Alignment score for a gap open (default -4).
    inputBinding:
      position: 1
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: Alignment score for a gap extension (default -1).
    inputBinding:
      position: 1
      prefix: --gap-extend
  - id: calls
    type: File
    doc: Bubble or breakpoint call file (.txt.gz).
    inputBinding:
      position: 100
  - id: ref
    type:
      type: array
      items: File
    doc: Reference FASTA file(s).
    inputBinding:
      position: 101
outputs:
  - id: vcf_out
    type: File
    doc: VCF file of the calls.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
