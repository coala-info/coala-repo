cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff_cutsite
label: hicstuff_cutsite
doc: "Generates new gzipped fastq files from original fastq. The function will cut
  the reads at their religation sites and creates new pairs of reads with the different
  fragments obtained after cutting at the digestion sites.\n\nThere are three choices
  to how combine the fragments. 1. \"for_vs_rev\": All the combinations are made between
  one forward fragment and one reverse fragment. 2. \"all\": All 2-combinations are
  made. 3. \"pile\": Only combinations between adjacent fragments in the initial reads
  are made.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: enzyme
    type: string
    doc: 'The list of restriction enzyme used to digest the genome separated by a
      comma. Example: HpaII,MluCI.'
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: forward_file
    type: File
    doc: Fastq file containing the forward reads to digest.
    inputBinding:
      position: 101
      prefix: --forward
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Digestion mode. There are three possibilities: "for_vs_rev", "all" and "pile".
      The first one "for_vs_rev" makes all possible contact between fragments from
      forward read versus the fragments of the reverse reads. The second one "all"
      consist two make all pairs of fragments possible. The third one "pile" will
      make the contacts only with the adjacent fragments.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: prefix
    type: string
    doc: Prefix of the path where to write the digested gzipped fastq files. 
      Filenames will be added the suffix "_R{1,2}.fq.gz".
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reverse_file
    type: File
    doc: Fastq file containing the reverse reads to digest.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: seed_size
    type:
      - 'null'
      - int
    doc: Minimum size of a read. (i.e. seed size used in mapping as reads 
      smaller won't be mapped.)
    inputBinding:
      position: 101
      prefix: --seed-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads allocated for the alignement.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
stdout: hicstuff_cutsite.out
