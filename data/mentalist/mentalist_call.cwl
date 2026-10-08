cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - call
label: mentalist_call
doc: "MentaLiST MLST calling function. Calls alleles on a given MLST database (a database folder made by build_db or one of the download commands). The Julia environment variables let the image compile its package cache in a writable temporary folder (the image has no precompiled cache and its own folder is read-only).\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
arguments:
  - prefix: --db
    valueFrom: $(inputs.db_dir.path)/$(inputs.db_name)
    position: 101
inputs:
  - id: db_dir
    type: Directory
    doc: "Database folder made by mentalist build_db/download_* (holds the k-mer database file and its scheme FASTA folder)"
  - id: db_name
    type: string
    default: "mlst.db"
    doc: "File name of the k-mer database inside db_dir"
  - id: output_name
    type: string
    default: "mlst_calls.txt"
    doc: "Output file with MLST call"
    inputBinding:
      position: 102
      prefix: -o
  - id: mutation_threshold
    type:
      - 'null'
      - int
    doc: "Maximum number of mutations when looking for novel alleles. (default: 6)"
    inputBinding:
      position: 102
      prefix: --mutation_threshold
  - id: kt
    type:
      - 'null'
      - int
    doc: "Minimum # of times a kmer is seen to be considered present in the sample (solid). (default: 10)"
    inputBinding:
      position: 102
      prefix: --kt
  - id: output_votes
    type:
      - 'null'
      - boolean
    doc: "Outputs the results for the original voting algorithm."
    inputBinding:
      position: 102
      prefix: --output_votes
  - id: output_special
    type:
      - 'null'
      - boolean
    doc: "Outputs a FASTA file with the alleles from 'special cases' such as incomplete coverage, novel, and multiple alleles."
    inputBinding:
      position: 102
      prefix: --output_special
  - id: sample_input_file
    type:
      - 'null'
      - File
    doc: "Input TXT file for multiple samples. First column has the sample name, second the FASTQ file. Repeat the sample name for samples with more than one file (paired reads, f.i.)"
    inputBinding:
      position: 102
      prefix: --sample_input_file
  - id: sample_files
    type:
      - 'null'
      - File[]
    doc: "FASTQ files named in sample_input_file; staged in the working directory so the names resolve"
  - id: reads_forward
    type:
      - 'null'
      - File[]
    doc: "FastQ input files, one per sample, forward reads (or unpaired reads)."
    inputBinding:
      position: 102
      prefix: '-1'
  - id: reads_reverse
    type:
      - 'null'
      - File[]
    doc: "FastQ input files, one per sample, reverse reads."
    inputBinding:
      position: 102
      prefix: '-2'
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Input files are in FASTA format, instead of the default FASTQs."
    inputBinding:
      position: 102
      prefix: --fasta
outputs:
  - id: calls
    type: File
    doc: "Output file with MLST call"
    outputBinding:
      glob: $(inputs.output_name)
  - id: coverage
    type:
      - 'null'
      - File
    doc: "Per-locus coverage and call details"
    outputBinding:
      glob: $(inputs.output_name).coverage.txt
  - id: novel
    type:
      - 'null'
      - File
    doc: "Novel alleles report"
    outputBinding:
      glob: $(inputs.output_name).novel.txt
  - id: novel_fasta
    type:
      - 'null'
      - File
    doc: "Novel allele sequences"
    outputBinding:
      glob: $(inputs.output_name).novel.fa
  - id: special_cases
    type:
      - 'null'
      - File
    doc: "FASTA file with the alleles from special cases (with output_special)"
    outputBinding:
      glob: $(inputs.output_name).special_cases.fa
  - id: votes
    type:
      - 'null'
      - File[]
    doc: "Results of the original voting algorithm (with output_votes)"
    outputBinding:
      glob: [$(inputs.output_name).byvote, $(inputs.output_name).votes.txt, $(inputs.output_name).ties.txt]
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      JULIA_PKGDIR: $(runtime.tmpdir)/julia_pkg
      JULIA_LOAD_PATH: /usr/local/share/julia/site/v0.5
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.sample_files ? inputs.sample_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
