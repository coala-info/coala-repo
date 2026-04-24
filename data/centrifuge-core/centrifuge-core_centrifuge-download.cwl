cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-download
label: centrifuge-core_centrifuge-download
doc: "Download sequence databases for Centrifuge.\n\nTool homepage: https://github.com/infphilo/centrifuge"
inputs:
  - id: database
    type: string
    doc: 'One of refseq, genbank, contaminants or taxonomy: - use refseq or genbank
      for genomic sequences, - contaminants gets contaminant sequences from UniVec
      and EmVec, - taxonomy for taxonomy mappings.'
    inputBinding:
      position: 1
  - id: assembly_level
    type:
      - 'null'
      - string
    doc: Only download genomes with the specified assembly level. Use 'Any' for 
      any assembly level.
    inputBinding:
      position: 102
      prefix: -a
  - id: domain
    type:
      - 'null'
      - string
    doc: What domain to download. One or more of bacteria, viral, archaea, 
      fungi, protozoa, invertebrate, plant, vertebrate_mammalian, 
      vertebrate_other (comma separated).
    inputBinding:
      position: 102
      prefix: -d
  - id: download_program
    type:
      - 'null'
      - string
    doc: 'Download using program. Options: rsync, curl, wget.'
    inputBinding:
      position: 102
      prefix: -g
  - id: download_rna
    type:
      - 'null'
      - boolean
    doc: Download RNA sequences, too.
    inputBinding:
      position: 102
      prefix: -r
  - id: filter_unplaced
    type:
      - 'null'
      - boolean
    doc: Filter unplaced sequences.
    inputBinding:
      position: 102
      prefix: -u
  - id: mask_low_complexity
    type:
      - 'null'
      - boolean
    doc: Mask low-complexity regions using dustmasker.
    inputBinding:
      position: 102
      prefix: -m
  - id: modify_header
    type:
      - 'null'
      - boolean
    doc: Modify header to include taxonomy ID.
    inputBinding:
      position: 102
      prefix: -l
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Folder to which the files are downloaded.
    inputBinding:
      position: 102
      prefix: -o
  - id: refseq_category
    type:
      - 'null'
      - string
    doc: Only download genomes in the specified refseq category.
    inputBinding:
      position: 102
      prefix: -c
  - id: taxids
    type:
      - 'null'
      - string
    doc: Only download the specified taxonomy IDs, comma separated.
    inputBinding:
      position: 102
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes when downloading (uses xargs).
    inputBinding:
      position: 102
      prefix: -P
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge-download.out
