cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - partition
label: ppanggolin_partition
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
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
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: draw_icl
    type:
      - 'null'
      - boolean
    doc: Use if you want to draw the ICL curve for all the tested K values. Will
      not be done if K is given.
    inputBinding:
      position: 101
      prefix: --draw_ICL
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
  - id: icl_margin
    type:
      - 'null'
      - float
    doc: K is detected automatically by maximizing ICL. However at some point 
      the ICL reaches a plateau. Therefore we are looking for the minimal value 
      of K without significant gain from the larger values of K measured by ICL.
      For that we take the lowest K that is found within a given 'margin' of the
      maximal ICL value. Basically, change this option only if you truly 
      understand it, otherwise just leave it be.
    inputBinding:
      position: 101
      prefix: --ICL_margin
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: Use if you want to keep the temporary NEM files
    inputBinding:
      position: 101
      prefix: --keep_tmp_files
  - id: krange
    type:
      - 'null'
      - type: array
        items: int
    doc: Range of K values to test when detecting K automatically.
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
  - id: max_degree_smoothing
    type:
      - 'null'
      - int
    doc: max. degree of the nodes to be included in the smoothing process.
    inputBinding:
      position: 101
      prefix: --max_degree_smoothing
  - id: nb_of_partitions
    type:
      - 'null'
      - int
    doc: Number of partitions to use. Must be at least 2. If under 2, it will be
      detected automatically.
    inputBinding:
      position: 101
      prefix: --nb_of_partitions
  - id: pangenome
    type: File
    doc: The pangenome.h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: seed
    type:
      - 'null'
      - int
    doc: seed used to generate random numbers
    inputBinding:
      position: 101
      prefix: --seed
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
