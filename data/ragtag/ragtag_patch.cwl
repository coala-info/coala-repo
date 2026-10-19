cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - patch
label: ragtag_patch
doc: "Homology-based assembly patching: Make continuous joins and fill gaps in 'target.fa'\
  \ using sequences from 'query.fa'.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: target
    type: File
    doc: target fasta file (uncompressed or bgzipped) (staged writable because the
      tool writes a .fai index beside it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: query
    type: File
    doc: query fasta file (uncompressed or bgzipped) (staged writable because the
      tool writes a .fai index beside it)
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: exclude
    type:
      - 'null'
      - File
    doc: list of target sequences to ignore [null]
    inputBinding:
      position: 101
      prefix: -e
  - id: skip
    type:
      - 'null'
      - File
    doc: list of query sequences to ignore [null]
    inputBinding:
      position: 101
      prefix: -j
  - id: min_unique_alignment_length
    type:
      - 'null'
      - int
    doc: minimum unique alignment length [1000]
    inputBinding:
      position: 101
      prefix: -f
  - id: remove_small
    type:
      - 'null'
      - boolean
    doc: remove unique alignments shorter than '-f'
    inputBinding:
      position: 101
      prefix: --remove-small
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapq (NA for Nucmer alignments) [10]
    inputBinding:
      position: 101
      prefix: -q
  - id: max_merge_distance
    type:
      - 'null'
      - int
    doc: maximum alignment merge distance [100000]
    inputBinding:
      position: 101
      prefix: -d
  - id: min_merged_alignment_length
    type:
      - 'null'
      - int
    doc: minimum merged alignment length [50000]
    inputBinding:
      position: 101
      prefix: -s
  - id: max_terminus_distance
    type:
      - 'null'
      - float
    doc: maximum merged alignment distance from sequence terminus. fraction of the
      sequence length if < 1 [0.05]
    inputBinding:
      position: 101
      prefix: -i
  - id: fill_only
    type:
      - 'null'
      - boolean
    doc: only fill existing target gaps. do not join target sequences
    inputBinding:
      position: 101
      prefix: --fill-only
  - id: join_only
    type:
      - 'null'
      - boolean
    doc: only join and patch target sequences. do not fill existing gaps
    inputBinding:
      position: 101
      prefix: --join-only
  - id: output_dir
    type:
      - 'null'
      - string
    doc: output directory (default ragtag_output)
    default: ragtag_output
    inputBinding:
      position: 101
      prefix: -o
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite intermediate files
    inputBinding:
      position: 101
      prefix: -w
  - id: add_suffix
    type:
      - 'null'
      - boolean
    doc: add suffix to unplaced sequence headers
    inputBinding:
      position: 101
      prefix: -u
  - id: threads
    type:
      - 'null'
      - int
    doc: number of minimap2/unimap threads [1]
    inputBinding:
      position: 101
      prefix: -t
  - id: aligner
    type:
      - 'null'
      - string
    doc: whole genome aligner executable ('nucmer', 'unimap' or 'minimap2') [nucmer]
    inputBinding:
      position: 101
      prefix: --aligner
  - id: mm2_params
    type:
      - 'null'
      - string
    doc: space delimited minimap2 parameters (overrides '-t') ['-x asm5']
    inputBinding:
      position: 101
      prefix: --mm2-params
  - id: unimap_params
    type:
      - 'null'
      - string
    doc: space delimited unimap parameters (overrides '-t') ['-x asm5']
    inputBinding:
      position: 101
      prefix: --unimap-params
  - id: nucmer_params
    type:
      - 'null'
      - string
    doc: space delimted nucmer parameters ['--maxmatch -l 100 -c 500']
    inputBinding:
      position: 101
      prefix: --nucmer-params
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Output directory with the result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.target)
        writable: true
      - entry: $(inputs.query)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_patch.out
