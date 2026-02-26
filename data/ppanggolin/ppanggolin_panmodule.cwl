cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin panmodule
label: ppanggolin_panmodule
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: anno
    type:
      - 'null'
      - File
    doc: A tab-separated file listing the genome names, and the gff filepath of 
      its annotations (the gffs can be compressed). One line per genome. This 
      option can be used alone IF the fasta sequences are in the gff files, 
      otherwise --fasta needs to be used.
    inputBinding:
      position: 101
      prefix: --anno
  - id: basename
    type:
      - 'null'
      - string
    doc: basename for the output file
    inputBinding:
      position: 101
      prefix: --basename
  - id: clusters
    type:
      - 'null'
      - File
    doc: a tab-separated file listing the cluster names, the gene IDs, and 
      optionally whether they are a fragment or not.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimal coverage of the alignment for two proteins to be in the same 
      cluster
    inputBinding:
      position: 101
      prefix: --coverage
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
  - id: fasta
    type:
      - 'null'
      - File
    doc: A tab-separated file listing the genome names, and the fasta filepath 
      of its genomic sequence(s) (the fastas can be compressed). One line per 
      genome. This option can be used alone.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimal identity percent for two proteins to be in the same cluster
    inputBinding:
      position: 101
      prefix: --identity
  - id: infer_singletons
    type:
      - 'null'
      - boolean
    doc: Use this option together with --clusters. If a gene is not present in 
      the provided clustering result file, it will be assigned to its own unique
      cluster as a singleton.
    inputBinding:
      position: 101
      prefix: --infer_singletons
  - id: kingdom
    type:
      - 'null'
      - string
    doc: Kingdom to which the prokaryota belongs to, to know which models to use
      for rRNA annotation.
    inputBinding:
      position: 101
      prefix: --kingdom
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - int
    doc: 'the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected
      component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: nb_of_partitions
    type:
      - 'null'
      - int
    doc: Number of partitions to use. Must be at least 2. If under 2, it will be
      detected automatically.
    inputBinding:
      position: 101
      prefix: --nb_of_partitions
  - id: no_defrag
    type:
      - 'null'
      - boolean
    doc: DO NOT Realign gene families to link fragments with their 
      non-fragmented gene family.
    inputBinding:
      position: 101
      prefix: --no_defrag
  - id: no_flat_files
    type:
      - 'null'
      - boolean
    doc: Generate only the HDF5 pangenome file.
    inputBinding:
      position: 101
      prefix: --no_flat_files
  - id: rarefaction
    type:
      - 'null'
      - boolean
    doc: 'Use to compute the rarefaction curves (WARNING: can be time consuming)'
    inputBinding:
      position: 101
      prefix: --rarefaction
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for storing temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table (genetic code) to use.
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: use_pseudo
    type:
      - 'null'
      - boolean
    doc: In the context of provided annotation, use this option to read 
      pseudogenes. (Default behavior is to ignore them)
    inputBinding:
      position: 101
      prefix: --use_pseudo
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
