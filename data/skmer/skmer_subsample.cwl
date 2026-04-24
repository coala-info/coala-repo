cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer subsample
label: skmer_subsample
doc: "Performs subsample on a library of reference genome-skims or assemblies\n\n\
  Tool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory of input genome-skims or assemblies (dir of 
      .fastq/.fq/.fa/.fna/.fasta files)
    inputBinding:
      position: 1
  - id: apply_jukes_cantor
    type:
      - 'null'
      - boolean
    doc: Apply Jukes-Cantor transformation to distances. Output 5.0 if not 
      applicable
    inputBinding:
      position: 102
      prefix: --t
  - id: base_error_rate
    type:
      - 'null'
      - float
    doc: Base error rate. By default, the error rate is automatically estimated.
    inputBinding:
      position: 102
      prefix: --e
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length [1-31].
    inputBinding:
      position: 102
      prefix: --k
  - id: max_processors
    type:
      - 'null'
      - int
    doc: Max number of processors to use [1-20].
    inputBinding:
      position: 102
      prefix: --p
  - id: num_replicates
    type:
      - 'null'
      - int
    doc: Number of subsampled replicates.
    inputBinding:
      position: 102
      prefix: --b
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory of output for subsample replicates.
    inputBinding:
      position: 102
      prefix: --sub
  - id: save_sketches
    type:
      - 'null'
      - boolean
    doc: Save sketches.
    inputBinding:
      position: 102
      prefix: --msh
  - id: save_subsampled_skims
    type:
      - 'null'
      - boolean
    doc: Save subsampled genome-skims.
    inputBinding:
      position: 102
      prefix: --fa
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size.
    inputBinding:
      position: 102
      prefix: --s
  - id: sketching_seed
    type:
      - 'null'
      - int
    doc: Sketching random seed.
    inputBinding:
      position: 102
      prefix: --S
  - id: start_index
    type:
      - 'null'
      - int
    doc: Start index of subsampled replicate (eg 5 for dir rep5).
    inputBinding:
      position: 102
      prefix: --i
  - id: subsampling_exponent
    type:
      - 'null'
      - float
    doc: Exponent value for subsampling.
    inputBinding:
      position: 102
      prefix: --c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer_subsample.out
