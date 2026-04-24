cwlVersion: v1.2
class: CommandLineTool
baseCommand: epa-ng
label: epa-ng
doc: "Massively-Parallel Evolutionary Placement Algorithm\n\nTool homepage: https://github.com/Pbdas/epa-ng"
inputs:
  - id: baseball_heur
    type:
      - 'null'
      - boolean
    doc: Baseball heuristic as known from pplacer. 
      strike_box=3,max_strikes=6,max_pitches=40.
    inputBinding:
      position: 101
      prefix: --baseball-heur
  - id: bfast_convert
    type:
      - 'null'
      - File
    doc: Convert the given fasta file to bfast format.
    inputBinding:
      position: 101
      prefix: --bfast
  - id: binary
    type:
      - 'null'
      - File
    doc: Path to binary reference file, as created using --dump-binary.
    inputBinding:
      position: 101
      prefix: --binary
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of query sequences to be read in at a time. May influence 
      performance.
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: dump_binary
    type:
      - 'null'
      - boolean
    doc: 'Binary Dump mode: write ref. tree in binary format then exit. NOTE: not
      compatible with premasking!'
    inputBinding:
      position: 101
      prefix: --dump-binary
  - id: dyn_heur
    type:
      - 'null'
      - float
    doc: Two-phase heuristic, determination of candidate edges using 
      accumulative threshold. Enabled by default! See --no-heur for disabling it
    inputBinding:
      position: 101
      prefix: --dyn-heur
  - id: filter_acc_lwr
    type:
      - 'null'
      - float
    doc: Accumulated likelihood weight after which further placements are 
      discarded.
    inputBinding:
      position: 101
      prefix: --filter-acc-lwr
  - id: filter_max
    type:
      - 'null'
      - int
    doc: Maximum number of placements per sequence to include in final output.
    inputBinding:
      position: 101
      prefix: --filter-max
  - id: filter_min
    type:
      - 'null'
      - int
    doc: Minimum number of placements per sequence to include in final output.
    inputBinding:
      position: 101
      prefix: --filter-min
  - id: filter_min_lwr
    type:
      - 'null'
      - float
    doc: Minimum likelihood weight below which a placement is discarded.
    inputBinding:
      position: 101
      prefix: --filter-min-lwr
  - id: fix_heur
    type:
      - 'null'
      - float
    doc: Two-phase heuristic, determination of candidate edges by specified 
      percentage of total edges.
    inputBinding:
      position: 101
      prefix: --fix-heur
  - id: model
    type:
      - 'null'
      - string
    doc: 'Description string of the model to be used, or a RAxML_info file. --model
      STRING | FILE See: https://github.com/amkozlov/raxml-ng/wiki/Input-data#evolutionary-model'
    inputBinding:
      position: 101
      prefix: --model
  - id: no_heur
    type:
      - 'null'
      - boolean
    doc: Disables heuristic preplacement completely. Overrides all other 
      heuristic flags.
    inputBinding:
      position: 101
      prefix: --no-heur
  - id: no_pre_mask
    type:
      - 'null'
      - boolean
    doc: Do NOT pre-mask sequences. Enables repeats unless --no-repeats is also 
      specified.
    inputBinding:
      position: 101
      prefix: --no-pre-mask
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: precision
    type:
      - 'null'
      - int
    doc: Output decimal point precision for floating point numbers.
    inputBinding:
      position: 101
      prefix: --precision
  - id: preserve_rooting
    type:
      - 'null'
      - string
    doc: Preserve the rooting of rooted trees. When disabled, EPA-ng will print 
      the result as an unrooted tree.
    inputBinding:
      position: 101
      prefix: --preserve-rooting
  - id: query
    type:
      - 'null'
      - File
    doc: Path to Query MSA file.
    inputBinding:
      position: 101
      prefix: --query
  - id: rate_scalers
    type:
      - 'null'
      - string
    doc: Use individual rate scalers. Important to avoid numerical underflow in 
      taxa rich trees.
    inputBinding:
      position: 101
      prefix: --rate-scalers
  - id: raxml_blo
    type:
      - 'null'
      - boolean
    doc: 'Employ old style of branch length optimization during thorough insertion
      as opposed to sliding approach. WARNING: may significantly slow down computation.'
    inputBinding:
      position: 101
      prefix: --raxml-blo
  - id: redo
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files.
    inputBinding:
      position: 101
      prefix: --redo
  - id: ref_msa
    type:
      - 'null'
      - File
    doc: Path to Reference MSA file.
    inputBinding:
      position: 101
      prefix: --ref-msa
  - id: split
    type:
      - 'null'
      - type: array
        items: File
    doc: Takes a reference MSA (phylip/fasta/fasta.gz) and combined ref + query 
      MSA(s) (phylip/fasta/fasta.gz) and outputs a monolithic query file 
      (fasta), as well as a reference file (fasta), ready for use.
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. If 0 is passed as argument,program will run 
      with the maximum number of threads available.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - File
    doc: Path to Reference Tree file.
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display debug output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epa-ng:0.3.8--h077b44d_7
stdout: epa-ng.out
