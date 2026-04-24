cwlVersion: v1.2
class: CommandLineTool
baseCommand: TD2.LongOrfs
label: td2_TD2.LongOrfs
doc: "Finds the longest ORFs in transcripts.\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs:
  - id: absolute_min_length
    type:
      - 'null'
      - int
    doc: minimum protein length for proteins in short transcripts, default=90
    inputBinding:
      position: 101
      prefix: --absolute-min-length
  - id: all_stopless
    type:
      - 'null'
      - boolean
    doc: report stopless sequences rather than ORFs, i.e. never require a start 
      codon, default=False
    inputBinding:
      position: 101
      prefix: --all-stopless
  - id: alt_start
    type:
      - 'null'
      - boolean
    doc: include alternative initiator codons, default=False
    inputBinding:
      position: 101
      prefix: --alt-start
  - id: complete_orfs_only
    type:
      - 'null'
      - boolean
    doc: ignore all ORFs without both a stop and start codon, default=False
    inputBinding:
      position: 101
      prefix: --complete-orfs-only
  - id: gene_trans_map
    type:
      - 'null'
      - File
    doc: gene-to-transcript mapping file (tab-delimited)
    inputBinding:
      position: 101
      prefix: --gene-trans-map
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code (NCBI integer code), default=1 (universal)
    inputBinding:
      position: 101
      prefix: --genetic-code
  - id: length_scale
    type:
      - 'null'
      - float
    doc: allow short ORFs in short transcripts if the ORF is at least a fraction
      of the total transcript length, default=1.1 (essentially off by default). 
      You must also specify -M to a lower minimum ORF length to work with -L
    inputBinding:
      position: 101
      prefix: --length-scale
  - id: memory_threshold
    type:
      - 'null'
      - float
    doc: percent of available memory to use per batch, default=None
    inputBinding:
      position: 101
      prefix: --memory-threshold
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: minimum protein length for proteins in long transcripts, default=90
    inputBinding:
      position: 101
      prefix: --min-length
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: path to output results, default=./{transcripts}
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: precise
    type:
      - 'null'
      - boolean
    doc: set --precise to enable precise mode. Equivalent to -m 98 -M 98 for 
      TD2.LongOrfs, default=False
    inputBinding:
      position: 101
      prefix: --precise
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: set -S for strand-specific ORFs (only analyzes top strand), 
      default=False
    inputBinding:
      position: 101
      prefix: --strand-specific
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use, default=20
    inputBinding:
      position: 101
      prefix: --threads
  - id: top
    type:
      - 'null'
      - int
    doc: record the top N CDS transcripts by length, default=0
    inputBinding:
      position: 101
      prefix: --top
  - id: transcripts
    type: File
    doc: REQUIRED path to transcripts.fasta
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set -v for verbose output, default=False
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_TD2.LongOrfs.out
