cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbalign
label: pbalign
doc: "Align PacBio reads to reference sequences using an algorithm selected from a
  selection of supported alignment algorithms.\n\nTool homepage: https://github.com/PacificBiosciences/pbalign"
inputs:
  - id: input_file
    type: File
    doc: The input file can be a fasta, pls.h5, bas.h5 or ccs.h5 file or a fofn 
      (file of file names).
    inputBinding:
      position: 1
  - id: reference_path
    type: File
    doc: Either a reference fasta file or a reference repository.
    inputBinding:
      position: 2
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Select an algorithm from blasr, bowtie, and gmap.
    inputBinding:
      position: 103
      prefix: --algorithm
  - id: concordant
    type:
      - 'null'
      - boolean
    doc: Map subreads of a ZMW to the same genomic location.
    inputBinding:
      position: 103
      prefix: --concordant
  - id: filter_adapter_only
    type:
      - 'null'
      - boolean
    doc: If specified, do not report adapter-only hits.
    inputBinding:
      position: 103
      prefix: --filterAdapterOnly
  - id: max_hits
    type:
      - 'null'
      - int
    doc: The maximum number of hits of each read that shall be anchored.
    inputBinding:
      position: 103
      prefix: --maxHits
  - id: metrics
    type:
      - 'null'
      - string
    doc: A comma-separated list of metrics to be reported in the output file.
    inputBinding:
      position: 103
      prefix: --metrics
  - id: min_accuracy
    type:
      - 'null'
      - float
    doc: The minimum accuracy of alignments to be reported.
    inputBinding:
      position: 103
      prefix: --minAccuracy
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of alignments to be reported.
    inputBinding:
      position: 103
      prefix: --minLength
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of threads to be used.
    inputBinding:
      position: 103
      prefix: --nproc
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator.
    inputBinding:
      position: 103
      prefix: --seed
  - id: timeout
    type:
      - 'null'
      - int
    doc: The maximum time (in minutes) to allow for alignment.
    inputBinding:
      position: 103
      prefix: --timeout
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Specify a directory for saving temporary files.
    inputBinding:
      position: 103
      prefix: --tmpDir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: The output BAM or SAM file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbalign:v0.3.2-1-deb-py2_cv1
