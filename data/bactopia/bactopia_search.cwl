cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-search
label: bactopia_search
doc: "Query against ENA and SRA for public accessions to process with Bactopia\n\n\
  Tool homepage: https://github.com/bactopia/bactopia"
inputs:
  - id: query
    type:
      - string
      - File
    doc: Taxon ID or Study, BioSample, or Run accession (can also be comma separated
      or a file of accessions)
    inputBinding:
      position: 1
      prefix: --query
  - id: exact_taxon
    type:
      - 'null'
      - boolean
    doc: Exclude Taxon ID descendants
    inputBinding:
      position: 1
      prefix: --exact-taxon
  - id: limit
    type:
      - 'null'
      - int
    doc: 'Maximum number of results (per query) to return [default: 1000000]'
    inputBinding:
      position: 1
      prefix: --limit
  - id: accession_limit
    type:
      - 'null'
      - int
    doc: 'Maximum number of accessions to query at once [default: 5000]'
    inputBinding:
      position: 1
      prefix: --accession-limit
  - id: biosample_subset
    type:
      - 'null'
      - int
    doc: 'If a BioSample has multiple Experiments, maximum number to randomly select
      (0 = disabled) [default: 0]'
    inputBinding:
      position: 1
      prefix: --biosample-subset
  - id: include_empty
    type:
      - 'null'
      - boolean
    doc: Include metadata columns that are empty for all rows
    inputBinding:
      position: 1
      prefix: --include-empty
  - id: min_base_count
    type:
      - 'null'
      - int
    doc: 'Filters samples based on minimum base pair count (0 = disabled) [default:
      0]'
    inputBinding:
      position: 1
      prefix: --min-base-count
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: 'Filters samples based on minimum mean read length (0 = disabled) [default:
      0]'
    inputBinding:
      position: 1
      prefix: --min-read-length
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'Filter samples based on minimum coverage (requires --genome_size, 0 = disabled)
      [default: 0]'
    inputBinding:
      position: 1
      prefix: --min-coverage
  - id: genome_size
    type:
      - 'null'
      - int
    doc: 'Genome size to be used for all samples, and for calculating min coverage
      [default: 0]'
    inputBinding:
      position: 1
      prefix: --genome-size
  - id: outdir
    type: string
    doc: Directory to write output
    inputBinding:
      position: 1
      prefix: --outdir
    default: bactopia-search
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix to use for output file names [default: bactopia]'
    inputBinding:
      position: 1
      prefix: --prefix
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the search results, accessions, filtered and summary reports
    outputBinding:
      glob: $(inputs.outdir)
  - id: reports
    type: File[]
    doc: Result, accession, filtered and summary text files
    outputBinding:
      glob: $(inputs.outdir)/*.txt
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.outdir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
