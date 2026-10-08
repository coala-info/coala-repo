cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- kmers
label: sourmash_sig_kmers
doc: 'Show k-mers and sequences that match the signature hashes.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: signatures
  type:
  - 'null'
  - type: array
    items: File
  doc: signatures
  inputBinding:
    position: 1
    prefix: --signatures
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: force
  type:
  - 'null'
  - boolean
  doc: try to load all files as signatures
  inputBinding:
    position: 1
    prefix: --force
- id: from_file
  type:
  - 'null'
  - File
  doc: a text file containing a list of files to load signatures from
  inputBinding:
    position: 1
    prefix: --from-file
- id: ksize
  type:
  - 'null'
  - int
  doc: k-mer size to select; no default.
  inputBinding:
    position: 1
    prefix: --ksize
- id: protein
  type:
  - 'null'
  - boolean
  doc: choose a protein signature; by default, a nucleotide signature is used
  inputBinding:
    position: 1
    prefix: --protein
- id: no_protein
  type:
  - 'null'
  - boolean
  doc: do not choose a protein signature
  inputBinding:
    position: 1
    prefix: --no-protein
- id: dayhoff
  type:
  - 'null'
  - boolean
  doc: choose Dayhoff-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --dayhoff
- id: no_dayhoff
  type:
  - 'null'
  - boolean
  doc: do not choose Dayhoff-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --no-dayhoff
- id: hp
  type:
  - 'null'
  - boolean
  doc: choose hydrophobic-polar-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --hp
- id: no_hp
  type:
  - 'null'
  - boolean
  doc: do not choose hydrophobic-polar-encoded amino acid signatures
  inputBinding:
    position: 1
    prefix: --no-hp
- id: skipm1n3
  type:
  - 'null'
  - boolean
  doc: choose skipmer (m1n3) signatures
  inputBinding:
    position: 1
    prefix: --skipm1n3
- id: no_skipm1n3
  type:
  - 'null'
  - boolean
  doc: do not choose skipmer (m1n3) signatures
  inputBinding:
    position: 1
    prefix: --no-skipm1n3
- id: skipm2n3
  type:
  - 'null'
  - boolean
  doc: choose skipmer (m2n3) signatures
  inputBinding:
    position: 1
    prefix: --skipm2n3
- id: no_skipm2n3
  type:
  - 'null'
  - boolean
  doc: do not choose skipmer (m2n3) signatures
  inputBinding:
    position: 1
    prefix: --no-skipm2n3
- id: dna
  type:
  - 'null'
  - boolean
  doc: 'choose a nucleotide signature (default: True)'
  inputBinding:
    position: 1
    prefix: --dna
- id: no_dna
  type:
  - 'null'
  - boolean
  doc: do not choose a nucleotide signature
  inputBinding:
    position: 1
    prefix: --no-dna
- id: picklist
  type:
  - 'null'
  - string
  doc: select signatures based on a picklist, i.e. 'file.csv:colname:coltype'
  inputBinding:
    position: 1
    prefix: --picklist
- id: picklist_require_all
  type:
  - 'null'
  - boolean
  doc: require that all picklist values be found or else fail
  inputBinding:
    position: 1
    prefix: --picklist-require-all
- id: sequences
  type:
  - 'null'
  - type: array
    items: File
  doc: FASTA/FASTQ/bz2/gz files with sequences
  inputBinding:
    position: 1
    prefix: --sequences
- id: save_kmers
  type:
  - 'null'
  - string
  doc: save k-mers and hash values to a CSV file
  inputBinding:
    position: 1
    prefix: --save-kmers
- id: save_sequences
  type:
  - 'null'
  - string
  doc: save sequences with matching hashes to a FASTA file
  inputBinding:
    position: 1
    prefix: --save-sequences
- id: translate
  type:
  - 'null'
  - boolean
  doc: translate DNA k-mers into amino acids (for protein, dayhoff, and hp sketches)
  inputBinding:
    position: 1
    prefix: --translate
- id: check_sequence
  type:
  - 'null'
  - boolean
  doc: 'complain if input sequence is invalid (NOTE: only checks DNA)'
  inputBinding:
    position: 1
    prefix: --check-sequence
- id: picklist_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Picklist files named in --picklist (file.csv:colname:coltype); staged in the working directory so the name resolves.
outputs:
- id: save_kmers_result
  type:
  - 'null'
  - File
  doc: save k-mers and hash values to a CSV file
  outputBinding:
    glob: $(inputs.save_kmers)
- id: save_sequences_result
  type:
  - 'null'
  - File
  doc: save sequences with matching hashes to a FASTA file
  outputBinding:
    glob: $(inputs.save_sequences)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_sig_kmers.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.picklist_files)
