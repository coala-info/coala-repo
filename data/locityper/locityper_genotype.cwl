cwlVersion: v1.2
class: CommandLineTool
baseCommand: locityper_genotype
label: locityper_genotype
doc: "Genotype complex loci.\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs:
  - id: databases
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Database directory (see locityper target). Multiple databases allowed, 
      but must contain unique loci names.
    inputBinding:
      position: 101
      prefix: --database[s]
  - id: debug
    type:
      - 'null'
      - int
    doc: 'Save debug CSV files: 0 = none, 1 = some, 2 = all.'
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_alignment
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads in BAM/CRAM format, mutually exclusive with -i/--input. Unless 
      --no-index, mapped, sorted & indexed BAM/CRAM file is expected. If 
      provided, second file should contain path to the alignment index.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: input_list
    type:
      - 'null'
      - File
    doc: File with input filenames (see documentation).
    inputBinding:
      position: 101
      prefix: --in-list
  - id: input_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads 1 and 2 in FASTA or FASTQ format, optionally gzip compressed. 
      Reads 1 are required, reads 2 are optional.
    inputBinding:
      position: 101
      prefix: --input
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved paired-end reads in single input file.
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: 'Use input BAM/CRAM file (-a) without index: goes over all reads. Single-end
      and paired-end interleaved (-^) data is allowed.'
    inputBinding:
      position: 101
      prefix: --no-index
  - id: out_bams
    type:
      - 'null'
      - int
    doc: Output BAM files for INT best genotypes [0].
    default: 0
    inputBinding:
      position: 101
      prefix: --out-bams
  - id: preproc
    type:
      - 'null'
      - Directory
    doc: Preprocessed dataset directory or `.gz` file (see locityper preproc).
    inputBinding:
      position: 101
      prefix: --preproc
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference FASTA file. Required with input CRAM file (-a alns.cram).
    inputBinding:
      position: 101
      prefix: --reference
  - id: rerun
    type:
      - 'null'
      - string
    doc: Rerun mode [none]. Rerun all loci (all); do not rerun read recruitment 
      (part); do not rerun completed loci (none).
    default: none
    inputBinding:
      position: 101
      prefix: --rerun
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed. Ensures reproducibility for the same input and program 
      version.
    inputBinding:
      position: 101
      prefix: --seed
  - id: stop_after
    type:
      - 'null'
      - string
    doc: 'Stop after one of the steps: recruit, map or all (default).'
    default: all
    inputBinding:
      position: 101
      prefix: --stop-after
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [8].
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
