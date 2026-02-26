cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy install
label: genomepy_install
doc: "Install a genome & run active plugins.\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs:
  - id: name
    type: string
    doc: Genome name
    inputBinding:
      position: 1
  - id: annotation
    type:
      - 'null'
      - boolean
    doc: download annotation
    inputBinding:
      position: 102
      prefix: --annotation
  - id: bgzip
    type:
      - 'null'
      - boolean
    doc: bgzip genome
    inputBinding:
      position: 102
      prefix: --bgzip
  - id: ensembl_toplevel
    type:
      - 'null'
      - boolean
    doc: always download toplevel-genome
    inputBinding:
      position: 102
      prefix: --Ensembl-toplevel
  - id: ensembl_version
    type:
      - 'null'
      - int
    doc: select release version
    inputBinding:
      position: 102
      prefix: --Ensembl-version
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing files
    inputBinding:
      position: 102
      prefix: --force
  - id: genomes_dir
    type:
      - 'null'
      - Directory
    doc: create output directory here
    inputBinding:
      position: 102
      prefix: --genomes_dir
  - id: keep_alt
    type:
      - 'null'
      - boolean
    doc: keep alternative regions
    inputBinding:
      position: 102
      prefix: --keep-alt
  - id: local_path_to_annotation
    type:
      - 'null'
      - File
    doc: link to the annotation file, required if this is not in the same 
      directory as the fasta file
    inputBinding:
      position: 102
      prefix: --Local-path-to-annotation
  - id: localname
    type:
      - 'null'
      - string
    doc: custom name
    inputBinding:
      position: 102
      prefix: --localname
  - id: mask
    type:
      - 'null'
      - string
    doc: 'DNA masking: hard/soft/none'
    default: soft
    inputBinding:
      position: 102
      prefix: --mask
  - id: no_match
    type:
      - 'null'
      - boolean
    doc: select sequences that *don't* match regex
    inputBinding:
      position: 102
      prefix: --no-match
  - id: only_annotation
    type:
      - 'null'
      - boolean
    doc: only download annotation (sets -a)
    inputBinding:
      position: 102
      prefix: --only_annotation
  - id: provider
    type:
      - 'null'
      - string
    doc: download from this provider
    inputBinding:
      position: 102
      prefix: --provider
  - id: regex
    type:
      - 'null'
      - string
    doc: regex to filter sequences
    inputBinding:
      position: 102
      prefix: --regex
  - id: skip_filter
    type:
      - 'null'
      - boolean
    doc: skip filtering out contigs in the gene annotation missing from the 
      genome (sets -a)
    inputBinding:
      position: 102
      prefix: --skip_filter
  - id: skip_matching
    type:
      - 'null'
      - boolean
    doc: skip matching contigs between the gene annotation and the genome (sets 
      -a)
    inputBinding:
      position: 102
      prefix: --skip_matching
  - id: threads
    type:
      - 'null'
      - int
    doc: build index using multithreading
    inputBinding:
      position: 102
      prefix: --threads
  - id: ucsc_annotation
    type:
      - 'null'
      - string
    doc: 'specify annotation to download: ncbiRefSeq, refGene, ensGene, knownGene
      (case-insensitive)'
    inputBinding:
      position: 102
      prefix: --UCSC-annotation
  - id: url_to_annotation
    type:
      - 'null'
      - string
    doc: link to the annotation file, required if this is not in the same 
      directory as the fasta file
    inputBinding:
      position: 102
      prefix: --URL-to-annotation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy_install.out
