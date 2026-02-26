cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin annotate
label: ppanggolin_annotate
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: allow_overlap
    type:
      - 'null'
      - boolean
    doc: Use to not remove genes overlapping with RNA features.
    inputBinding:
      position: 101
      prefix: --allow_overlap
  - id: anno
    type: File
    doc: A tab-separated file listing the genome names, and the gff/gbff 
      filepath of its annotations (the files can be compressed with gzip). One 
      line per genome. If this is provided, those annotations will be used.
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
  - id: fasta
    type: File
    doc: A tab-separated file listing the genome names, and the fasta filepath 
      of its genomic sequence(s) (the fastas can be compressed with gzip). One 
      line per genome.
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
  - id: norna
    type:
      - 'null'
      - boolean
    doc: Use to avoid annotating RNA features.
    inputBinding:
      position: 101
      prefix: --norna
  - id: prodigal_procedure
    type:
      - 'null'
      - string
    doc: Allow to force the prodigal procedure. If nothing given, PPanGGOLiN 
      will decide in function of contig length
    inputBinding:
      position: 101
      prefix: --prodigal_procedure
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
