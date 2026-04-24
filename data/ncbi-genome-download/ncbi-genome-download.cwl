cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-genome-download
label: ncbi-genome-download
doc: "Download genome sequences from NCBI by taxid, genus, or assembly level.\n\n\
  Tool homepage: https://github.com/kblin/ncbi-genome-download/"
inputs:
  - id: section
    type: string
    doc: NCBI section to download from (e.g., bacteria, viral, archaea, fungi, 
      plant, protozoa, vertebrate_mammalian, vertebrate_other, invertebrate, 
      unknown)
    inputBinding:
      position: 1
  - id: assembly_level
    type:
      - 'null'
      - type: array
        items: string
    doc: Assembly level of genomes to download (complete, chromosome, scaffold, 
      contig)
    inputBinding:
      position: 102
      prefix: --assembly-level
  - id: format
    type:
      - 'null'
      - type: array
        items: string
    doc: Which format(s) to download (genbank, fasta, rm, features, gff, 
      protein-fasta, genpept, wgs, cds-fasta, sequence-report)
    inputBinding:
      position: 102
      prefix: --format
  - id: genus
    type:
      - 'null'
      - string
    doc: Only download genomes of this genus
    inputBinding:
      position: 102
      prefix: --genus
  - id: parallel
    type:
      - 'null'
      - int
    doc: Run N downloads in parallel
    inputBinding:
      position: 102
      prefix: --parallel
  - id: retries
    type:
      - 'null'
      - int
    doc: Number of retries for failed downloads
    inputBinding:
      position: 102
      prefix: --retries
  - id: species_taxid
    type:
      - 'null'
      - string
    doc: Only download genomes of this species taxid
    inputBinding:
      position: 102
      prefix: --species-taxid
  - id: taxid
    type:
      - 'null'
      - string
    doc: Only download genomes of this taxid
    inputBinding:
      position: 102
      prefix: --taxid
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output directory for downloaded files
    outputBinding:
      glob: $(inputs.output_folder)
  - id: metadata_table
    type:
      - 'null'
      - File
    doc: Save metadata to a tab-separated file
    outputBinding:
      glob: $(inputs.metadata_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-genome-download:0.3.3--pyh7cba7a3_0
