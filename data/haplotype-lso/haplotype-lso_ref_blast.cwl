cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hlso
  - ref_blast
label: haplotype-lso_ref_blast
doc: "Run the seed sequences through NCBI WWW BLAST (blastn, nt).\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of parallel searches to run"
    inputBinding:
      position: 1
      prefix: --num-threads
  - id: in_tsv
    type: File
    doc: "Path to input TSV file (seeds_paths.tsv)."
    inputBinding:
      position: 2
  - id: seed_files
    type:
      type: array
      items: File
    doc: "Seed FASTA files named in the path column of the TSV file; staged next to it"
outputs:
  - id: blast_xml
    type:
      - 'null'
      - type: array
        items: File
    doc: "BLAST result for each seed"
    outputBinding:
      glob: '*.blast.xml'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: $([inputs.in_tsv].concat(inputs.seed_files))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
