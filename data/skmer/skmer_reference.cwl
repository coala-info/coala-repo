cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer_reference
label: skmer_reference
doc: "Process a library of reference genome-skims or assemblies\n\nTool homepage:
  https://github.com/shahab-sarmashghi/Skmer"
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
      prefix: -t
  - id: base_error_rate
    type:
      - 'null'
      - float
    doc: Base error rate. By default, the error rate is automatically estimated.
    inputBinding:
      position: 102
      prefix: E
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length [1-31].
    inputBinding:
      position: 102
      prefix: K
  - id: max_processors
    type:
      - 'null'
      - int
    doc: 'Max number of processors to use [1-20]. Default for this machine: 20'
    inputBinding:
      position: 102
      prefix: P
  - id: output_library_dir
    type:
      - 'null'
      - Directory
    doc: Directory of output (reference) library.
    inputBinding:
      position: 102
      prefix: L
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output (distances) prefix.
    inputBinding:
      position: 102
      prefix: O
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size.
    inputBinding:
      position: 102
      prefix: S
  - id: sketching_seed
    type:
      - 'null'
      - int
    doc: Sketching random seed.
    inputBinding:
      position: 102
      prefix: S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer_reference.out
