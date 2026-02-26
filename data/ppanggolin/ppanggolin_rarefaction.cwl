cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - rarefaction
label: ppanggolin_rarefaction
doc: "Compute the rarefaction curve of the pangenome\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: beta
    type:
      - 'null'
      - float
    doc: beta is the strength of the smoothing using the graph topology during 
      partitioning. 0 will deactivate spatial smoothing.
    inputBinding:
      position: 101
      prefix: --beta
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size of the chunks when performing partitioning using chunks of 
      genomes. Chunk partitioning will be used automatically if the number of 
      genomes is above this number.
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: depth
    type:
      - 'null'
      - int
    doc: Number of samplings at each sampling point
    inputBinding:
      position: 101
      prefix: --depth
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: free_dispersion
    type:
      - 'null'
      - boolean
    doc: use if the dispersion around the centroid vector of each partition 
      during must be free. It will be the same for all genomes by default.
    inputBinding:
      position: 101
      prefix: --free_dispersion
  - id: krange
    type:
      - 'null'
      - type: array
        items: int
    doc: Range of K values to test when detecting K automatically. Default 
      between 3 and the K previously computed if there is one, or 20 if there 
      are none.
    inputBinding:
      position: 101
      prefix: --krange
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: max
    type:
      - 'null'
      - int
    doc: Maximum number of genomes in a sample (if above the number of provided 
      genomes, the provided genomes will be the maximum)
    inputBinding:
      position: 101
      prefix: --max
  - id: max_degree_smoothing
    type:
      - 'null'
      - int
    doc: max. degree of the nodes to be included in the smoothing process.
    inputBinding:
      position: 101
      prefix: --max_degree_smoothing
  - id: min
    type:
      - 'null'
      - int
    doc: Minimum number of genomes in a sample
    inputBinding:
      position: 101
      prefix: --min
  - id: nb_of_partitions
    type:
      - 'null'
      - int
    doc: Number of partitions to use. Must be at least 2. By default reuse K if 
      it exists else compute it.
    inputBinding:
      position: 101
      prefix: --nb_of_partitions
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: reestimate_k
    type:
      - 'null'
      - boolean
    doc: Will recompute the number of partitions for each sample (between the 
      values provided by --krange) (VERY intensive. Can take a long time.)
    inputBinding:
      position: 101
      prefix: --reestimate_K
  - id: seed
    type:
      - 'null'
      - int
    doc: seed used to generate random numbers
    inputBinding:
      position: 101
      prefix: --seed
  - id: soft_core
    type:
      - 'null'
      - float
    doc: Soft core threshold
    inputBinding:
      position: 101
      prefix: --soft_core
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for storing temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
