cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - pretable
label: parascopy_pretable
doc: "Create homology pre-table. This command aligns genomic regions back to the genome
  to find homologous regions.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: bedtools
    type:
      - 'null'
      - File
    doc: Path to "bedtools" executable
    default: bedtools
    inputBinding:
      position: 101
      prefix: --bedtools
  - id: bgzip
    type:
      - 'null'
      - File
    doc: Path to "bgzip" executable
    default: bgzip
    inputBinding:
      position: 101
      prefix: --bgzip
  - id: bwa
    type:
      - 'null'
      - File
    doc: Path to BWA executable
    default: bwa
    inputBinding:
      position: 101
      prefix: --bwa
  - id: fasta_ref
    type: File
    doc: Input reference fasta file. Should have BWA index.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: keep_self_alns
    type:
      - 'null'
      - boolean
    doc: If true, partial self-alignments will be kept (for example keep an alignment
      with a 300bp shift). Full self-alignments are always discarded.
    inputBinding:
      position: 101
      prefix: --keep-self-alns
  - id: max_homologies
    type:
      - 'null'
      - int
    doc: Skip regions with more than <int> homologies (copies) in the genome
    default: 10
    inputBinding:
      position: 101
      prefix: --max-homologies
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimal alignment length
    default: 250
    inputBinding:
      position: 101
      prefix: --min-aln-len
  - id: min_seq_sim
    type:
      - 'null'
      - float
    doc: Minimal sequence similarity
    default: 0.96
    inputBinding:
      position: 101
      prefix: --min-seq-sim
  - id: read_len
    type:
      - 'null'
      - int
    doc: Artificial read length
    default: 900
    inputBinding:
      position: 101
      prefix: --read-len
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) in format "chr" or "chr:start-end"). Start and end are 1-based
      inclusive. Commas are ignored.
    inputBinding:
      position: 101
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).
    inputBinding:
      position: 101
      prefix: --regions-file
  - id: seed_len
    type:
      - 'null'
      - int
    doc: Minimum BWA seed length
    default: 16
    inputBinding:
      position: 101
      prefix: --seed-len
  - id: step_size
    type:
      - 'null'
      - int
    doc: Artificial reads step size
    default: 150
    inputBinding:
      position: 101
      prefix: --step-size
  - id: symmetric
    type:
      - 'null'
      - boolean
    doc: Create a symmetric homology table (may be unstable).
    inputBinding:
      position: 101
      prefix: --symmetric
  - id: tabix
    type:
      - 'null'
      - File
    doc: Path to "tabix" executable
    default: tabix
    inputBinding:
      position: 101
      prefix: --tabix
  - id: threads
    type:
      - 'null'
      - int
    doc: Use <int> threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Puts temporary files in the following directory (does not remove temporary
      files after finishing). Otherwise, creates a temporary directory.
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output
    type: File
    doc: Output bed[.gz] file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
