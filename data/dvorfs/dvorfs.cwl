cwlVersion: v1.2
class: CommandLineTool
baseCommand: dvorfs
label: dvorfs
doc: "DVORFS v1.0.1\n\nTool homepage: https://github.com/ilevantis/dvorfs"
inputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: Skip presearch step and use a bed file to limit search regions.
    inputBinding:
      position: 101
      prefix: --bed
  - id: bit_cutoff
    type:
      - 'null'
      - float
    doc: Bit score threshold for reported hits
    default: 15.0
    inputBinding:
      position: 101
      prefix: --bit-cutoff
  - id: fai
    type:
      - 'null'
      - File
    doc: Input fasta index file
    default: <input.fasta>.fai
    inputBinding:
      position: 101
      prefix: --fai
  - id: fasta
    type: File
    doc: Input fasta file.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: filter
    type:
      - 'null'
      - string
    doc: 'all: All hits are kept (default). no_overlap: Hits are removed if they are
      overlapped by a better hit from a different query. best_per: Only the highest
      scoring hit per contig is kept.'
    default: all
    inputBinding:
      position: 101
      prefix: --filter
  - id: full_search
    type:
      - 'null'
      - boolean
    doc: 'Skip presearch step and run genewise on the whole input fasta. WARNING:
      this can take a very long time.'
    inputBinding:
      position: 101
      prefix: --full-search
  - id: full_tsv
    type:
      - 'null'
      - boolean
    doc: Extra columns containing postprocessing details are included in the 
      output tsv.
    inputBinding:
      position: 101
      prefix: --full-tsv
  - id: hit_mask
    type:
      - 'null'
      - File
    doc: Three column TSV file for filtering out hits based on query regions.
    inputBinding:
      position: 101
      prefix: --hit-mask
  - id: hmm2
    type:
      - 'null'
      - File
    doc: Input query hmm file (HMMER2 file format).
    inputBinding:
      position: 101
      prefix: --hmm2
  - id: hmm3
    type:
      - 'null'
      - File
    doc: Input query hmm file (HMMER3 file format).
    inputBinding:
      position: 101
      prefix: --hmm3
  - id: keep_workdir
    type:
      - 'null'
      - boolean
    doc: Do not delete the temporary working directory after DVORFS has 
      finished.
    inputBinding:
      position: 101
      prefix: --keep-workdir
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: Length threshold (no. of codons) for reported hits
    default: 30
    inputBinding:
      position: 101
      prefix: --length-cutoff
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: Maximum allowed distance between GeneWise hits to be merged.
    inputBinding:
      position: 101
      prefix: --merge-distance
  - id: noali
    type:
      - 'null'
      - boolean
    doc: Do not output explicit codon alignments of hits.
    inputBinding:
      position: 101
      prefix: --noali
  - id: nomerge
    type:
      - 'null'
      - boolean
    doc: Adjacent GeneWise hits will not be merged.
    inputBinding:
      position: 101
      prefix: --nomerge
  - id: nuc_tsv
    type:
      - 'null'
      - boolean
    doc: Nucleotide sequences with comma seperated codons are inlcuded in the 
      output tsv.
    inputBinding:
      position: 101
      prefix: --nuc-tsv
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: current working directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: dvorfs
    inputBinding:
      position: 101
      prefix: --prefix
  - id: presearch_slop
    type:
      - 'null'
      - int
    doc: Size of flanking regions next to presearch hits in which to search
    default: 3000
    inputBinding:
      position: 101
      prefix: --presearch-slop
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of processor threads to use for running HMMER and GeneWise.
    inputBinding:
      position: 101
      prefix: --procs
  - id: seed
    type:
      - 'null'
      - File
    doc: Input query seed alignment file (stockholm or fasta format).
    inputBinding:
      position: 101
      prefix: --seed
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Directory in which DVORFS will save files during a run
    default: <outdir>/dvorfs.tmp
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dvorfs:1.0.1--pyhdfd78af_0
stdout: dvorfs.out
