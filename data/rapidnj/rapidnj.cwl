cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapidnj
label: rapidnj
doc: 'Rapid neighbour-joining. An implementation of the canonical neighbour-joining
  method which utilize a fast search heuristic to reduce the running time. RapidNJ
  can be used to reconstruct large trees using a very small amount of memory by utilizing
  the HDD as storage.


  Tool homepage: http://birc.au.dk/software/rapidnj/'
inputs:
  - id: input_file
    type: File
    doc: The INPUT can be a distance matrix in phylip (.phylip) format or a multiple
      alignment in stockholm (.sth) or phylip format (.phylip).
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: turn on verbose output.
    inputBinding:
      position: 102
      prefix: -v
  - id: input_format
    type:
      - 'null'
      - string
    doc: Specifies the type of input. pd = distance matrix in phylip format, sth =
      multiple alignment in (single line) stockholm format. fa = multiple alignment
      in (single line) FASTA format.
    inputBinding:
      position: 102
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: Specifies the type of output. t = phylogenetic tree in newick format (default),
      m = distance matrix.
    inputBinding:
      position: 102
      prefix: -o
  - id: evolution_model
    type:
      - 'null'
      - string
    doc: Specifies which sequence evolution method to use when computing distance
      estimates from multiple alignments. jc = juke cantor, kim = Kimura's distance
      (default).
    inputBinding:
      position: 102
      prefix: -a
  - id: memory_size
    type:
      - 'null'
      - int
    doc: The maximum amount of memory which rapidNJ is allowed to use (in MB). Default
      is 90% of all available memory.
    inputBinding:
      position: 102
      prefix: -m
  - id: rapidnj_mem
    type:
      - 'null'
      - int
    doc: Force RapidNJ to use a memory efficient version of rapidNJ. The 'arg' specifies
      the percentage of a sorted distance matrix which should be stored in memory
      (arg=10 means 10%).
    inputBinding:
      position: 102
      prefix: -k
  - id: rapidnj_disk
    type:
      - 'null'
      - string
    doc: Force RapidNJ to use HDD caching where 'arg' is the directory used to store
      cached files.
    inputBinding:
      position: 102
      prefix: -d
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use for computating distance matrices from multiple alignments.
      All available cores are used by default.
    inputBinding:
      position: 102
      prefix: -c
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: Compute bootstrap values using ARG samples. The output tree will be annotated
      with the bootstrap values.
    inputBinding:
      position: 102
      prefix: -b
  - id: alignment_type
    type:
      - 'null'
      - string
    doc: 'Force the input alignment to be treated as: p = protein alignment, d = DNA
      alignment.'
    inputBinding:
      position: 102
      prefix: -t
  - id: no_negative_length
    type:
      - 'null'
      - boolean
    doc: Adjust for negative branch lengths.
    inputBinding:
      position: 102
      prefix: -n
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output the result to this file instead of stdout.
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Tree or distance matrix written to standard output (empty when an output
      file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Result written with the output file option
    outputBinding:
      glob: $(inputs.output_file_path || '__none__')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapidnj:v2.3.2--h2d50403_0
stdout: rapidnj.out
