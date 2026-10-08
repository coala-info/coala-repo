cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gencube
  - annotation
label: gencube_annotation
doc: "Search, download, and modify chromosome labels for various genome annotations, such as gaps and repeats.\n\nAll gencube subcommands use NCBI Entrez Utilities and need network access and an email address (the wrapper writes it to the gencube configuration file in the working directory). Results are written to the gencube_output directory.\n\nTool homepage: https://github.com/snu-cdrc/gencube"
inputs:
  - id: email
    type: string
    doc: "Email address for NCBI E-utilities (stored in the gencube configuration file)."
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: "Optional NCBI API key (36 characters) for faster E-utilities requests."
  - id: level
    type:
      - 'null'
      - string
    doc: "Genome assembly level (default: complete,chromosome). One or more of complete, chromosome, scaffold, contig (comma separated)."
    inputBinding:
      position: 101
      prefix: --level
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: "Show genomes that have RefSeq accession (GCF_* format)."
    inputBinding:
      position: 101
      prefix: --refseq
  - id: ucsc
    type:
      - 'null'
      - boolean
    doc: "Show genomes that have UCSC name."
    inputBinding:
      position: 101
      prefix: --ucsc
  - id: latest
    type:
      - 'null'
      - boolean
    doc: "Show genomes corresponding to the latest version."
    inputBinding:
      position: 101
      prefix: --latest
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: "Save metadata for the searched annotations."
    inputBinding:
      position: 101
      prefix: --metadata
  - id: download
    type:
      - 'null'
      - string
    doc: "Annotation file to download: gap, sr, td, wm, rmsk, cpg or gc (comma separated)."
    inputBinding:
      position: 101
      prefix: --download
  - id: chr_style
    type:
      - 'null'
      - string
    doc: "Chromosome label style used in the download file (default: ensembl): ensembl, gencode, ucsc or raw."
    inputBinding:
      position: 101
      prefix: --chr_style
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Download files regardless of their presence only if integrity check is not possible."
    inputBinding:
      position: 101
      prefix: --recursive
  - id: keywords
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxonomic names or accession numbers to search for genomes."
    inputBinding:
      position: 200
outputs:
  - id: gencube_output
    type: Directory
    doc: "Directory with the search tables, metadata and downloaded files."
    outputBinding:
      glob: gencube_output
  - id: stdout
    type: stdout
    doc: "Search summary printed by gencube."
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .gencube_entrez_info
        entry: |-
          # This information is used in E-utilities
          email = $(inputs.email)
          api_key = $(inputs.ncbi_api_key ? inputs.ncbi_api_key : '')
      - entry: "$({class: 'Directory', basename: 'gencube_output', listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
stdout: gencube_annotation.out
