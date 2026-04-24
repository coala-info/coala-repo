cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-asm-pipeline.sh
label: 3d-dna
doc: "This is a script to assemble draft assemblies (represented in input by draft
  fasta and deduplicated list of alignments of Hi-C reads to this fasta as produced
  by the Juicer pipeline) into chromosome-length scaffolds. The script will produce
  an output fasta file, a Hi-C map of the final assembly, and a few supplementary
  annotation files to help review the result in Juicebox.\n\nTool homepage: https://github.com/aidenlab/3d-dna/tree/201008"
inputs:
  - id: input_fasta
    type: File
    doc: Specify file path to draft assembly fasta file.
    inputBinding:
      position: 1
  - id: input_mnd
    type: File
    doc: 'Specify path to deduplicated list of alignments of Hi-C reads to the draft
      assembly fasta as produced by the Juicer pipeline: the merged_nodups file (mnd).'
    inputBinding:
      position: 2
  - id: chromosome_map
    type:
      - 'null'
      - int
    doc: Option to build a standard sandboxed hic file for the first chromosome_count
      Hi-C scaffolds
    inputBinding:
      position: 103
      prefix: --chromosome-map
  - id: early_exit
    type:
      - 'null'
      - boolean
    doc: Option to exit after first round of scaffolding.
    inputBinding:
      position: 103
      prefix: --early-exit
  - id: editor_coarse_region
    type:
      - 'null'
      - int
    doc: Misjoin editor triangular motif region size (default is 125000).
    inputBinding:
      position: 103
      prefix: --editor-coarse-region
  - id: editor_coarse_resolution
    type:
      - 'null'
      - int
    doc: 'Misjoin editor coarse matrix resolution, should be one of the following:
      2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (default
      is 25000).'
    inputBinding:
      position: 103
      prefix: --editor-coarse-resolution
  - id: editor_coarse_stringency
    type:
      - 'null'
      - int
    doc: Misjoin editor stringency parameter (default is 55).
    inputBinding:
      position: 103
      prefix: --editor-coarse-stringency
  - id: editor_fine_resolution
    type:
      - 'null'
      - int
    doc: 'Misjoin editor fine matrix resolution, should be one of the following: 2500000,
      1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (default is
      1000).'
    inputBinding:
      position: 103
      prefix: --editor-fine-resolution
  - id: editor_repeat_coverage
    type:
      - 'null'
      - int
    doc: Misjoin editor threshold repeat coverage (default is 2).
    inputBinding:
      position: 103
      prefix: --editor-repeat-coverage
  - id: editor_saturation_centile
    type:
      - 'null'
      - int
    doc: Misjoin editor saturation parameter (default is 5).
    inputBinding:
      position: 103
      prefix: --editor-saturation-centile
  - id: fast_start
    type:
      - 'null'
      - boolean
    doc: Option to pick up processing assuming the first round of scaffolding is done.
    inputBinding:
      position: 103
      prefix: --fast-start
  - id: gap_size
    type:
      - 'null'
      - int
    doc: Gap size to be added between scaffolded sequences in the final chromosome-length
      scaffolds (default is 500).
    inputBinding:
      position: 103
      prefix: --gap-size
  - id: input_size
    type:
      - 'null'
      - int
    doc: Specifies threshold input contig/scaffold size (default is 15000). Contigs/scaffolds
      smaller than input_size are going to be ignored.
    inputBinding:
      position: 103
      prefix: --input
  - id: mapq
    type:
      - 'null'
      - int
    doc: Mapq threshold for scaffolding and visualization (default is 1).
    inputBinding:
      position: 103
      prefix: --mapq
  - id: merger_alignment_identity
    type:
      - 'null'
      - int
    doc: 'Minimal identity score required from similar nearby sequences (per length)
      for them to be classified as alternative haplotypes. Default: 20.'
    inputBinding:
      position: 103
      prefix: --merger-alignment-identity
  - id: merger_alignment_length
    type:
      - 'null'
      - int
    doc: 'Minimal length necessary to recognize similar nearby sequences as alternative
      haplotypes. Default: 20000.'
    inputBinding:
      position: 103
      prefix: --merger-alignment-length
  - id: merger_alignment_score
    type:
      - 'null'
      - int
    doc: 'Minimal LASTZ alignment score for nearby sequences to be recongnized as
      alternative haplotypes. Default: 50000000.'
    inputBinding:
      position: 103
      prefix: --merger-alignment-score
  - id: merger_lastz_options
    type:
      - 'null'
      - string
    doc: 'Option string to customize LASTZ alignment. Default: "--gfextend\ --gapped\
      --chain=200,200"'
    inputBinding:
      position: 103
      prefix: --merger-lastz-options
  - id: merger_search_band
    type:
      - 'null'
      - int
    doc: 'Distance (in bp) within which to locally search for alternative haplotypes
      to a given contig or scaffold. Default: 3000000.'
    inputBinding:
      position: 103
      prefix: --merger-search-band
  - id: mode
    type:
      - 'null'
      - string
    doc: Runs in specific mode, either haploid or diploid (default is haploid).
    inputBinding:
      position: 103
      prefix: --mode
  - id: polisher_coarse_region
    type:
      - 'null'
      - int
    doc: Polisher triangular motif region size (default is 3000000).
    inputBinding:
      position: 103
      prefix: --polisher-coarse-region
  - id: polisher_coarse_resolution
    type:
      - 'null'
      - int
    doc: Polisher coarse matrix resolution (default is 25000).
    inputBinding:
      position: 103
      prefix: --polisher-coarse-resolution
  - id: polisher_coarse_stringency
    type:
      - 'null'
      - int
    doc: Polisher stringency parameter (default is 55).
    inputBinding:
      position: 103
      prefix: --polisher-coarse-stringency
  - id: polisher_fine_resolution
    type:
      - 'null'
      - int
    doc: Polisher fine matrix resolution (default is 1000).
    inputBinding:
      position: 103
      prefix: --polisher-fine-resolution
  - id: polisher_input_size
    type:
      - 'null'
      - int
    doc: Polisher input size threshold. Scaffolds smaller than polisher_input_size
      are going to be placed into unresolved (default is 1000000).
    inputBinding:
      position: 103
      prefix: --polisher-input-size
  - id: polisher_saturation_centile
    type:
      - 'null'
      - int
    doc: Polisher saturation parameter (default is 5).
    inputBinding:
      position: 103
      prefix: --polisher-saturation-centile
  - id: rounds
    type:
      - 'null'
      - int
    doc: Specifies number of iterative rounds for misjoin correction (default is 2).
    inputBinding:
      position: 103
      prefix: --rounds
  - id: sort_output
    type:
      - 'null'
      - boolean
    doc: Option to sort the chromosome-length scaffolds by size, in the descending
      order.
    inputBinding:
      position: 103
      prefix: --sort-output
  - id: splitter_coarse_region
    type:
      - 'null'
      - int
    doc: 'Splitter triangular motif region size (Default: 3000000).'
    inputBinding:
      position: 103
      prefix: --splitter-coarse-region
  - id: splitter_coarse_resolution
    type:
      - 'null'
      - int
    doc: 'Splitter coarse matrix resolution (Default: 25000).'
    inputBinding:
      position: 103
      prefix: --splitter-coarse-resolution
  - id: splitter_coarse_stringency
    type:
      - 'null'
      - int
    doc: 'Splitter stringency parameter (Default: 55).'
    inputBinding:
      position: 103
      prefix: --splitter-coarse-stringency
  - id: splitter_fine_resolution
    type:
      - 'null'
      - int
    doc: 'Splitter fine matrix resolution (Default: 1000).'
    inputBinding:
      position: 103
      prefix: --splitter-fine-resolution
  - id: splitter_input_size
    type:
      - 'null'
      - int
    doc: 'Splitter input size threshold. Scaffolds smaller than polisher_input_size
      are going to be placed into unresolved (Default: 1000000).'
    inputBinding:
      position: 103
      prefix: --splitter-input-size
  - id: splitter_saturation_centile
    type:
      - 'null'
      - int
    doc: 'Splitter saturation parameter (Default: 5).'
    inputBinding:
      position: 103
      prefix: --splitter-saturation-centile
  - id: stage
    type:
      - 'null'
      - string
    doc: Fast forward to later assembly steps, can be polish, split, seal, merge and
      finalize.
    inputBinding:
      position: 103
      prefix: --stage
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/3d-dna:201008--hdfd78af_0
stdout: 3d-dna.out
