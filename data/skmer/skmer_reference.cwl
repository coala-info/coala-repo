cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skmer
  - reference
label: skmer_reference
doc: "Process a library of reference genome-skims or assemblies\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory of input genome-skims or assemblies (dir of .fastq/.fq/.fa/.fna/.fasta files)
    inputBinding:
      position: 100
  - id: library_dir
    type: string
    default: library
    doc: Directory of output (reference) library
    inputBinding:
      position: 1
      prefix: -l
  - id: output_prefix
    type: string
    default: ref-dist-mat
    doc: Output (distances) prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: kmer_length
    type: ['null', int]
    doc: K-mer length [1-31]
    inputBinding:
      position: 1
      prefix: -k
  - id: sketch_size
    type: ['null', int]
    doc: Sketch size
    inputBinding:
      position: 1
      prefix: -s
  - id: sketching_seed
    type: ['null', int]
    doc: Sketching random seed
    inputBinding:
      position: 1
      prefix: -S
  - id: base_error_rate
    type: ['null', float]
    doc: Base error rate. By default, the error rate is automatically estimated
    inputBinding:
      position: 1
      prefix: -e
  - id: apply_jukes_cantor
    type: ['null', boolean]
    doc: Apply Jukes-Cantor transformation to distances. Output 5.0 if not applicable
    inputBinding:
      position: 1
      prefix: -t
  - id: max_processors
    type: ['null', int]
    doc: Max number of processors to use [1-20]
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: library
    type: Directory
    doc: Processed reference library
    outputBinding:
      glob: $(inputs.library_dir)
  - id: distance_matrix
    type: ['null', File]
    doc: Pairwise distance matrix of the reference library
    outputBinding:
      glob: $(inputs.output_prefix)*.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
