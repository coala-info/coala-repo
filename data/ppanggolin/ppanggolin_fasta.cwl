cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin fasta
label: ppanggolin_fasta
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: anno
    type:
      - 'null'
      - File
    doc: A tab-separated file listing the genome names, and the gff/gbff 
      filepath of its annotations (the files can be compressed with gzip). One 
      line per genome. If this is provided, those annotations will be used.
    inputBinding:
      position: 101
      prefix: --anno
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the files in .gz
    inputBinding:
      position: 101
      prefix: --compress
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
    doc: Number of available threads
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
  - id: gene_families
    type:
      - 'null'
      - string
    doc: Write representative nucleotide sequences of gene families. Possible 
      values are all, persistent, shell, cloud, rgp, softcore, core, module_X 
      with X being a module id.
    inputBinding:
      position: 101
      prefix: --gene_families
  - id: genes
    type:
      - 'null'
      - string
    doc: Write all nucleotide CDS sequences. Possible values are all, 
      persistent, shell, cloud, rgp, softcore, core, module_X with X being a 
      module id.
    inputBinding:
      position: 101
      prefix: --genes
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keeping temporary files (useful for debugging).
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: prot_families
    type:
      - 'null'
      - string
    doc: Write representative amino acid sequences of gene families. Possible 
      values are all, persistent, shell, cloud, rgp, softcore, core, module_X 
      with X being a module id.
    inputBinding:
      position: 101
      prefix: --prot_families
  - id: proteins
    type:
      - 'null'
      - string
    doc: Write representative amino acid sequences of genes. Possible values are
      all, persistent, shell, cloud, rgp, softcore, core, module_X with X being 
      a module id.
    inputBinding:
      position: 101
      prefix: --proteins
  - id: regions
    type:
      - 'null'
      - string
    doc: Write the RGP nucleotide sequences (requires --anno or --fasta used to 
      compute the pangenome to be given)
    inputBinding:
      position: 101
      prefix: --regions
  - id: soft_core
    type:
      - 'null'
      - string
    doc: Soft core threshold to use if 'softcore' partition is chosen
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
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table (genetic code) to use.
    inputBinding:
      position: 101
      prefix: --translation_table
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
    type: Directory
    doc: Output directory where the file(s) will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
