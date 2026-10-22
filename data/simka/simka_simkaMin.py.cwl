cwlVersion: v1.2
class: CommandLineTool
baseCommand: simkaMin.py
label: simka_simkaMin.py
doc: "SimkaMin computes approximate pairwise distances between samples from a
  subsample of k-mers.\n\nTool homepage: https://github.com/GATB/simka"
inputs:
  - id: input_file
    type: File
    doc: "input file of datasets. One sample per line: id1: filename1... File names are resolved relative to the folder of this file, so it is staged in the working directory next to the sample files."
    inputBinding:
      position: 101
      prefix: -in
      valueFrom: $(self.basename)
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files named in the sample list. They are staged in the working directory so the relative names in the list resolve.
  - id: output_dir_path
    type: string
    doc: output directory for result files (distance matrices)
    inputBinding:
      position: 101
      prefix: -out
  - id: seed
    type:
      - 'null'
      - int
    doc: "seed used for random k-mer selection [Default: 100]"
    inputBinding:
      position: 101
      prefix: -seed
  - id: bin_path
    type:
      - 'null'
      - string
    doc: "path to simkaMinCore program (to be specified if not in PATH, or not in standard installation directory)"
    inputBinding:
      position: 101
      prefix: -bin
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: "number of cores [Default: 0]"
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: max_memory
    type:
      - 'null'
      - int
    doc: "max memory (MB) [Default: 8000]"
    inputBinding:
      position: 101
      prefix: -max-memory
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "size of a kmer [Default: 21]"
    inputBinding:
      position: 101
      prefix: -kmer-size
  - id: nb_kmers
    type:
      - 'null'
      - int
    doc: "number of kmers used to compute distances [Default: 1000000]"
    inputBinding:
      position: 101
      prefix: -nb-kmers
  - id: filter
    type:
      - 'null'
      - boolean
    doc: "filter out k-mer seen one time (potentially erroneous)"
    inputBinding:
      position: 101
      prefix: -filter
  - id: max_reads
    type:
      - 'null'
      - int
    doc: "maximum number of reads per sample to process [Default: 0]"
    inputBinding:
      position: 101
      prefix: -max-reads
  - id: min_read_size
    type:
      - 'null'
      - int
    doc: "minimal size a read should have to be kept [Default: 0]"
    inputBinding:
      position: 101
      prefix: -min-read-size
  - id: min_shannon_index
    type:
      - 'null'
      - float
    doc: "minimal Shannon index a read should have to be kept. Float in [0,2] [Default: 0]"
    inputBinding:
      position: 101
      prefix: -min-shannon-index
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the distance matrices
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)
      - $(inputs.sample_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simka:1.5.3--h077b44d_5
