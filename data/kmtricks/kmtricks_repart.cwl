cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmtricks
  - repart
label: kmtricks_repart
doc: "Compute minimizer repartition.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: bloom_size
    type:
      - 'null'
      - int
    doc: bloom filter size
    inputBinding:
      position: 101
      prefix: --bloom-size
  - id: file
    type: File
    doc: kmtricks input file, see README.md.
    inputBinding:
      position: 101
      prefix: --file
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a k-mer.
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of minimizers.
    inputBinding:
      position: 101
      prefix: --minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq).
    inputBinding:
      position: 101
      prefix: --minimizer-type
  - id: nb_partitions
    type:
      - 'null'
      - int
    doc: number of partitions (0=auto).
    inputBinding:
      position: 101
      prefix: --nb-partitions
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered).
    inputBinding:
      position: 101
      prefix: --repartition-type
  - id: run_dir
    type: string
    doc: kmtricks runtime directory to create.
    inputBinding:
      position: 101
      prefix: --run-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Sequence files named in the input file; staged next to it so the names resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: run_dir_out
    type: Directory
    doc: kmtricks runtime directory.
    outputBinding:
      glob: $(inputs.run_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.file)
      - $(inputs.sequence_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
    dockerOutputDirectory: /kmtricks_work
stdout: kmtricks_repart.out
