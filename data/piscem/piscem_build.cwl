cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - piscem
  - build
label: piscem_build
doc: "Index a reference sequence\n\nTool homepage: https://github.com/COMBINE-lab/piscem"
inputs:
  - id: decoy_paths
    type:
      - 'null'
      - string
    doc: path to (optional) ',' sparated list of decoy sequences used to insert poison
      k-mer information into the index
    inputBinding:
      position: 101
      prefix: --decoy-paths
  - id: keep_intermediate_dbg
    type:
      - 'null'
      - boolean
    doc: retain the reduced format GFA files produced by cuttlefish that describe
      the reference cDBG (the default is to remove these)
    inputBinding:
      position: 101
      prefix: --keep-intermediate-dbg
  - id: klen
    type:
      - 'null'
      - int
    doc: length of k-mer to use, must be <= 31 and odd
    default: 31
    inputBinding:
      position: 101
      prefix: --klen
  - id: mlen
    type:
      - 'null'
      - int
    doc: length of minimizer to use; must be < `klen`
    default: 19
    inputBinding:
      position: 101
      prefix: --mlen
  - id: no_ec_table
    type:
      - 'null'
      - boolean
    doc: skip the construction of the equivalence class lookup table when building
      the index (not recommended)
    inputBinding:
      position: 101
      prefix: --no-ec-table
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwite an existing index if the output path is the same
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: polya_clip_length
    type:
      - 'null'
      - int
    doc: If provided (default is not to clip polyA), then reference sequences ending
      with polyA tails of length greater than or equal to this value will be clipped
    inputBinding:
      position: 101
      prefix: --polya-clip-length
  - id: ref_dirs
    type:
      - 'null'
      - string
    doc: "',' separated list of directories (all FASTA files in each directory will
      be indexed, but not recursively)"
    inputBinding:
      position: 101
      prefix: --ref-dirs
  - id: ref_lists
    type:
      - 'null'
      - string
    doc: "',' separated list of files (each listing input FASTA files)"
    inputBinding:
      position: 101
      prefix: --ref-lists
  - id: ref_seqs
    type:
      - 'null'
      - string
    doc: "',' separated list of reference FASTA files"
    inputBinding:
      position: 101
      prefix: --ref-seqs
  - id: seed
    type:
      - 'null'
      - int
    doc: index construction seed (seed value passed to SSHash index construction;
      useful if empty buckets occur)
    default: 1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type: int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: working directory where temporary files should be placed
    default: ./workdir.noindex
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: output
    type: File
    doc: output file stem
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
