cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash compute
label: sourmash_compute
doc: "Create MinHash sketches at k-mer sizes of 21, 31 and 51, for\nall FASTA and
  FASTQ files in the current directory, and save them in\nsignature files ending in
  '.sig'. You can rapidly compare these files\nwith `compare` and query them with
  `search`, among other operations; see the full documentation at http://sourmash.rtfd.io/.\n\
  The key options for compute are:\n\n * `-k/--ksize <int>[, <int>]: k-mer size(s)
  to use, e.g. -k 21,31,51\n * `-n/--num <int>` or `--scaled <int>`: set size or resolution
  of sketches\n * `--track-abundance`: track abundances of hashes (default False)\n\
  \ * `--dna or --protein`: nucleotide and/or protein signatures (default `--dna`)\n\
  \ * `--merge <name>`: compute a merged signature across all inputs.\n * `--singleton`:
  compute individual signatures for each sequence.\n * `--name-from-first`: set name
  of signature from first sequence in file.\n * `-o/--output`: save all computed signatures
  to this file.\n\nPlease see -h for all of the options as well as more detailed help.\n\
  \n---\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: file(s) of sequences
    inputBinding:
      position: 1
  - id: check_sequence
    type:
      - 'null'
      - boolean
    doc: complain if input sequence is invalid
    inputBinding:
      position: 102
      prefix: --check-sequence
  - id: dayhoff
    type:
      - 'null'
      - boolean
    doc: choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --dayhoff
  - id: dna
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 102
      prefix: --dna
  - id: force
    type:
      - 'null'
      - boolean
    doc: recompute signatures even if the file exists
    inputBinding:
      position: 102
      prefix: --force
  - id: hp
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --hp
  - id: hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --hp
  - id: input_is_protein
    type:
      - 'null'
      - boolean
    doc: Consume protein sequences - no translation needed.
    inputBinding:
      position: 102
      prefix: --input-is-protein
  - id: ksizes
    type:
      - 'null'
      - string
    doc: comma-separated list of k-mer sizes; default=21,31,51
    inputBinding:
      position: 102
      prefix: --ksizes
  - id: license
    type:
      - 'null'
      - string
    doc: signature license. Currently only CC0 is supported.
    inputBinding:
      position: 102
      prefix: --license
  - id: merge
    type:
      - 'null'
      - string
    doc: merge all input files into one signature file with the specified name
    inputBinding:
      position: 102
      prefix: --merge
  - id: name
    type:
      - 'null'
      - string
    doc: merge all input files into one signature file with the specified name
    inputBinding:
      position: 102
      prefix: --name
  - id: name_from_first
    type:
      - 'null'
      - boolean
    doc: name the signature generated from each file after the first record in 
      the file
    inputBinding:
      position: 102
      prefix: --name-from-first
  - id: no_dayhoff
    type:
      - 'null'
      - boolean
    doc: do not choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --no-dayhoff
  - id: no_dna
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 102
      prefix: --no-dna
  - id: no_hp
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --no-hp
  - id: no_hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --no-hp
  - id: no_nucleotide
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 102
      prefix: --no-nucleotide
  - id: no_protein
    type:
      - 'null'
      - boolean
    doc: do not choose a protein signature
    inputBinding:
      position: 102
      prefix: --no-protein
  - id: no_rna
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 102
      prefix: --no-rna
  - id: no_skipm1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipm1n3
  - id: no_skipm2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipm2n3
  - id: no_skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipm1n3
  - id: no_skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipm2n3
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 102
      prefix: --nucleotide
  - id: num
    type:
      - 'null'
      - int
    doc: num value should be between 50 and 50000
    inputBinding:
      position: 102
      prefix: --num
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: num value should be between 50 and 50000
    inputBinding:
      position: 102
      prefix: --num-hashes
  - id: protein
    type:
      - 'null'
      - boolean
    doc: choose a protein signature; by default, a nucleotide signature is used
    inputBinding:
      position: 102
      prefix: --protein
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress non-error output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: randomize
    type:
      - 'null'
      - boolean
    doc: shuffle the list of input filenames randomly
    inputBinding:
      position: 102
      prefix: --randomize
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 102
      prefix: --rna
  - id: scaled
    type:
      - 'null'
      - int
    doc: set size or resolution of sketches
    inputBinding:
      position: 102
      prefix: --scaled
  - id: seed
    type:
      - 'null'
      - int
    doc: seed used by MurmurHash; default=42
    inputBinding:
      position: 102
      prefix: --seed
  - id: singleton
    type:
      - 'null'
      - boolean
    doc: compute a signature for each sequence record individually
    inputBinding:
      position: 102
      prefix: --singleton
  - id: skipm1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --skipm1n3
  - id: skipm2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --skipm2n3
  - id: skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --skipm1n3
  - id: skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --skipm2n3
  - id: track_abundance
    type:
      - 'null'
      - boolean
    doc: track k-mer abundances in the generated signature
    inputBinding:
      position: 102
      prefix: --track-abundance
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output computed signatures to this file
    outputBinding:
      glob: $(inputs.output)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output computed signatures to this directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output computed signatures to this directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
