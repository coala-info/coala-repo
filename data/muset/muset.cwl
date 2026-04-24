cwlVersion: v1.2
class: CommandLineTool
baseCommand: muset
label: muset
doc: "a pipeline for building an abundance unitig matrix from a list of FASTA/FASTQ
  files.\n\nTool homepage: https://github.com/CamilaDuitama/muset"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: kmtricks-like input file, see README.md.
    inputBinding:
      position: 101
      prefix: --file
  - id: in_matrix
    type:
      - 'null'
      - File
    doc: input matrix (text file or kmtricks directory).
    inputBinding:
      position: 101
      prefix: --in-matrix
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: keep temporary files.
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size. [8, 63].
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: logan
    type:
      - 'null'
      - boolean
    doc: input samples consist of Logan unitigs (i.e., with abundance).
    inputBinding:
      position: 101
      prefix: --logan
  - id: min_abundance
    type:
      - 'null'
      - int
    doc: minimum abundance to keep a k-mer.
    inputBinding:
      position: 101
      prefix: --min-abundance
  - id: min_frac_absent
    type:
      - 'null'
      - float
    doc: fraction of samples from which a k-mer should be absent. [0.0, 1.0]
    inputBinding:
      position: 101
      prefix: --min-frac-absent
  - id: min_frac_present
    type:
      - 'null'
      - float
    doc: fraction of samples in which a k-mer should be present. [0.0, 1.0]
    inputBinding:
      position: 101
      prefix: --min-frac-present
  - id: min_nb_absent
    type:
      - 'null'
      - float
    doc: minimum number of samples from which a k-mer should be absent 
      (overrides -f).
    inputBinding:
      position: 101
      prefix: --min-nb-absent
  - id: min_nb_present
    type:
      - 'null'
      - float
    doc: minimum number of samples in which a k-mer should be present (overrides
      -F).
    inputBinding:
      position: 101
      prefix: --min-nb-present
  - id: min_unitig_length
    type:
      - 'null'
      - string
    doc: minimum unitig length.
    inputBinding:
      position: 101
      prefix: --min-unitig-length
  - id: min_utg_frac
    type:
      - 'null'
      - float
    doc: minimum k-mer fraction to set unitig average abundance [0,1].
    inputBinding:
      position: 101
      prefix: --min-utg-frac
  - id: mini_size
    type:
      - 'null'
      - int
    doc: minimizer size. [4, 15].
    inputBinding:
      position: 101
      prefix: --mini-size
  - id: out_frac
    type:
      - 'null'
      - boolean
    doc: output an additional matrix containing k-mer fractions.
    inputBinding:
      position: 101
      prefix: --out-frac
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: write_seq
    type:
      - 'null'
      - boolean
    doc: write the unitig sequence instead of the identifier in the output 
      matrix
    inputBinding:
      position: 101
      prefix: --write-seq
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muset:0.5.1--h22625ea_0
