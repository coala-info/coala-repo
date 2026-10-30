cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - rmsubstr
label: mccortex_rmsubstr
doc: "Remove duplicate sequences and those that occur as substrings of others (case insensitive, includes reverse complement).\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit on processing threads (default 2).
    inputBinding:
      position: 1
      prefix: --threads
  - id: out
    type: string
    default: rmsubstr.fa
    doc: Output file.
    inputBinding:
      position: 1
      prefix: --out
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size, odd (31 >= k >= 3).
    inputBinding:
      position: 1
      prefix: --kmer
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: FASTA or FASTQ (default FASTQ).'
    inputBinding:
      position: 1
      prefix: --format
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Only print strings that are substrings.
    inputBinding:
      position: 1
      prefix: --invert
  - id: seqs
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ sequence files.
    inputBinding:
      position: 100
outputs:
  - id: reduced
    type: File
    doc: Reduced sequence set.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
