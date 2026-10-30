cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - uniqkmers
label: mccortex_uniqkmers
doc: "Generate N random unique k-mers that are not in the graph.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
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
    default: uniqkmers.fa
    doc: Output FASTA file.
    inputBinding:
      position: 1
      prefix: --out
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size (required if only giving --seq input).
    inputBinding:
      position: 1
      prefix: --kmer
  - id: graph
    type:
      - 'null'
      - File
    doc: Load k-mers from this graph file (.ctx).
    inputBinding:
      position: 1
      prefix: --graph
  - id: seq
    type:
      - 'null'
      - File
    doc: Load k-mers from a sequence file (SAM, BAM, FASTQ, FASTA).
    inputBinding:
      position: 1
      prefix: --seq
  - id: flank
    type:
      - 'null'
      - File
    doc: Add flanking k-mers to this FASTA file.
    inputBinding:
      position: 1
      prefix: --flank
  - id: num
    type: int
    doc: Number of random unique k-mers to generate.
    inputBinding:
      position: 100
outputs:
  - id: kmers_fa
    type: File
    doc: Random unique k-mers.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
