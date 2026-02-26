cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - rna_dump
label: genometreetk_rna_dump
doc: "Dump all 5S, 16S, and 23S sequences to files.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: genomic_file
    type: File
    doc: file indicating path to GTDB genomes
    inputBinding:
      position: 1
  - id: gtdb_taxonomy
    type: File
    doc: file indicating taxonomy of each genome
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 3
  - id: genome_list
    type:
      - 'null'
      - string
    doc: restrict selection to genomes in list
    inputBinding:
      position: 104
      prefix: --genome_list
  - id: include_user
    type:
      - 'null'
      - boolean
    doc: include user genomes
    inputBinding:
      position: 104
      prefix: --include_user
  - id: min_16S_ar_len
    type:
      - 'null'
      - int
    doc: minimum length of archaeal 16S rRNA gene to include
    default: 900
    inputBinding:
      position: 104
      prefix: --min_16S_ar_len
  - id: min_16S_bac_len
    type:
      - 'null'
      - int
    doc: minimum length of bacterial 16S rRNA gene to include
    default: 1200
    inputBinding:
      position: 104
      prefix: --min_16S_bac_len
  - id: min_23S_len
    type:
      - 'null'
      - int
    doc: minimum length of 23S rRNA gene to include
    default: 1900
    inputBinding:
      position: 104
      prefix: --min_23S_len
  - id: min_5S_len
    type:
      - 'null'
      - int
    doc: minimum length of 5S rRNA gene to include
    default: 80
    inputBinding:
      position: 104
      prefix: --min_5S_len
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: minimum contig length
    default: 0
    inputBinding:
      position: 104
      prefix: --min_contig_len
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 104
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_rna_dump.out
