cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ncbi-genome-download]
label: ncbi-genome-download
doc: "Download genome files from the NCBI FTP server.\n\nTool homepage: https://github.com/kblin/ncbi-genome-download/"
inputs:
  - id: groups
    type: string
    doc: "The NCBI taxonomic groups to download (default: all); a comma-separated list is possible. Choose from: all, archaea, bacteria, fungi, invertebrate, metagenomes, plant, protozoa, vertebrate_mammalian, vertebrate_other, viral."
    inputBinding:
      position: 101
  - id: section
    type:
      - 'null'
      - string
    doc: "NCBI section to download: refseq or genbank (default: refseq)."
    inputBinding:
      position: 1
      prefix: --section
  - id: formats
    type:
      - 'null'
      - string
    doc: "Which formats to download (default: genbank); comma-separated, e.g. fasta,assembly-report. Choose from: genbank, fasta, rm, features, gff, protein-fasta, genpept, wgs, cds-fasta, rna-fna, rna-fasta, assembly-report, assembly-stats, translated-cds, all."
    inputBinding:
      position: 1
      prefix: --formats
  - id: assembly_levels
    type:
      - 'null'
      - string
    doc: "Assembly levels of genomes to download (default: all); comma-separated: complete, chromosome, scaffold, contig."
    inputBinding:
      position: 1
      prefix: --assembly-levels
  - id: genera
    type:
      - 'null'
      - string
    doc: "Only download sequences of the provided genera; comma-separated, e.g. Streptomyces coelicolor,Escherichia coli."
    inputBinding:
      position: 1
      prefix: --genera
  - id: fuzzy_genus
    type:
      - 'null'
      - boolean
    doc: "Use a fuzzy search on the organism name instead of an exact match."
    inputBinding:
      position: 1
      prefix: --fuzzy-genus
  - id: strains
    type:
      - 'null'
      - string
    doc: "Only download sequences of the given strain(s); comma-separated list of strain names, or a path to a file with one name per line."
    inputBinding:
      position: 1
      prefix: --strains
  - id: species_taxids
    type:
      - 'null'
      - string
    doc: "Only download sequences of the provided species NCBI taxonomy IDs; comma-separated."
    inputBinding:
      position: 1
      prefix: --species-taxids
  - id: taxids
    type:
      - 'null'
      - string
    doc: "Only download sequences of the provided NCBI taxonomy IDs; comma-separated."
    inputBinding:
      position: 1
      prefix: --taxids
  - id: assembly_accessions
    type:
      - 'null'
      - string
    doc: "Only download sequences matching the provided NCBI assembly accession(s); comma-separated list, or a path to a file with one accession per line."
    inputBinding:
      position: 1
      prefix: --assembly-accessions
  - id: fuzzy_accessions
    type:
      - 'null'
      - boolean
    doc: "Use a fuzzy search on the entry accession instead of an exact match."
    inputBinding:
      position: 1
      prefix: --fuzzy-accessions
  - id: refseq_categories
    type:
      - 'null'
      - string
    doc: "Only download sequences of the provided refseq categories (reference, representative, na); comma-separated."
    inputBinding:
      position: 1
      prefix: --refseq-categories
  - id: output_folder
    type: string
    doc: "Create output hierarchy in the specified folder (default: /tmp)."
    inputBinding:
      position: 1
      prefix: --output-folder
  - id: flat_output
    type:
      - 'null'
      - boolean
    doc: "Dump all files right into the output folder without creating any subfolders."
    inputBinding:
      position: 1
      prefix: --flat-output
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: "Create links in human-readable hierarchy."
    inputBinding:
      position: 1
      prefix: --human-readable
  - id: progress_bar
    type:
      - 'null'
      - boolean
    doc: "Create a progress bar for indicating the download progress."
    inputBinding:
      position: 1
      prefix: --progress-bar
  - id: uri
    type:
      - 'null'
      - string
    doc: "NCBI base URI to use (default: https://ftp.ncbi.nih.gov/genomes)."
    inputBinding:
      position: 1
      prefix: --uri
  - id: parallel
    type:
      - 'null'
      - int
    doc: "Run N downloads in parallel (default: 1)."
    inputBinding:
      position: 1
      prefix: --parallel
  - id: retries
    type:
      - 'null'
      - int
    doc: "Retry download N times when connection to NCBI fails (default: 0)."
    inputBinding:
      position: 1
      prefix: --retries
  - id: metadata_table
    type:
      - 'null'
      - string
    doc: "Save tab-delimited file with genome metadata."
    inputBinding:
      position: 1
      prefix: --metadata-table
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Only check which files to download, do not download genome files."
    inputBinding:
      position: 1
      prefix: --dry-run
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: "Do not cache the assembly summary file."
    inputBinding:
      position: 1
      prefix: --no-cache
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity."
    inputBinding:
      position: 1
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print debugging information."
    inputBinding:
      position: 1
      prefix: --debug
  - id: type_materials
    type:
      - 'null'
      - string
    doc: "Relation to type material (default: any); comma-separated: any, all, type, reference, synonym, proxytype, neotype."
    inputBinding:
      position: 1
      prefix: --type-materials
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder with the downloaded genomes.
    outputBinding:
      glob: $(inputs.output_folder)
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: Tab-delimited genome metadata table.
    outputBinding:
      glob: $(inputs.metadata_table)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: ncbi-genome-download.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-genome-download:0.3.3--pyh7cba7a3_0
