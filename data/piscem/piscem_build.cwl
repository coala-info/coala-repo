cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sh
  - -c
  - ulimit -Sn 65536 && exec piscem build "$@"
  - piscem_build
label: piscem_build
doc: "Index a reference sequence. The command runs through sh to raise the open-file limit (ulimit -Sn 65536) because the k-mer counting step fails with the default limit of 1024\n\nTool homepage: https://github.com/COMBINE-lab/piscem"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: ref_seqs
    type:
      - 'null'
      - type: array
        items: File
    doc: 'reference FASTA files (joined with commas)'
    inputBinding:
      position: 101
      prefix: --ref-seqs
      itemSeparator: ','
  - id: ref_lists
    type:
      - 'null'
      - type: array
        items: File
    doc: 'files, each listing input FASTA files (joined with commas)'
    inputBinding:
      position: 101
      prefix: --ref-lists
      itemSeparator: ','
  - id: klen
    type:
      - 'null'
      - int
    doc: 'length of k-mer to use, must be <= 31 and odd (default 31)'
    inputBinding:
      position: 101
      prefix: --klen
  - id: mlen
    type:
      - 'null'
      - int
    doc: 'length of minimizer to use; must be < klen (default 19)'
    inputBinding:
      position: 101
      prefix: --mlen
  - id: decoy_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: 'decoy sequences used to insert poison k-mer information into the index (joined with commas)'
    inputBinding:
      position: 101
      prefix: --decoy-paths
      itemSeparator: ','
  - id: no_ec_table
    type:
      - 'null'
      - boolean
    doc: 'skip the construction of the equivalence class lookup table (not recommended)'
    inputBinding:
      position: 101
      prefix: --no-ec-table
  - id: polya_clip_length
    type:
      - 'null'
      - int
    doc: 'reference sequences ending with polyA tails of at least this length will be clipped'
    inputBinding:
      position: 101
      prefix: --polya-clip-length
  - id: seed
    type:
      - 'null'
      - int
    doc: 'index construction seed (default 1)'
    inputBinding:
      position: 101
      prefix: --seed
  - id: keep_intermediate_dbg
    type:
      - 'null'
      - boolean
    doc: 'retain the reduced format GFA files produced by cuttlefish'
    inputBinding:
      position: 101
      prefix: --keep-intermediate-dbg
  - id: work_dir
    type:
      - 'null'
      - string
    doc: 'working directory for temporary files (default ./workdir.noindex)'
    inputBinding:
      position: 101
      prefix: --work-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: 'overwrite an existing index if the output path is the same'
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: threads
    type: int
    doc: 'number of threads to use'
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: 'output file stem'
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: index_out
    type:
      type: array
      items: File
    doc: 'Index files with the given output stem'
    outputBinding:
      glob: $(inputs.output_path)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
