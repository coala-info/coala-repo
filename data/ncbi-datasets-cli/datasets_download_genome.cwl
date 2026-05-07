cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - download
  - genome
label: datasets_download_genome
doc: Download a genome data package. Genome data packages may include genome, 
  transcript and protein sequences, annotation and one or more data reports. 
  Data packages are downloaded as a zip archive.
inputs:
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: Limit to annotated genomes
    inputBinding:
      position: 101
      prefix: --annotated
  - id: assembly_level
    type:
      - 'null'
      - string
    doc: 'Limit to genomes at one or more assembly levels (comma-separated): chromosome,
      complete, contig, scaffold'
    inputBinding:
      position: 101
      prefix: --assembly-level
  - id: assembly_source
    type:
      - 'null'
      - string
    doc: Limit to 'RefSeq' (GCF_) or 'GenBank' (GCA_) genomes
    inputBinding:
      position: 101
      prefix: --assembly-source
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Limit to a specified, comma-delimited list of chromosomes, or 'all' for
      all chromosomes
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: dehydrated
    type:
      - 'null'
      - boolean
    doc: Download a dehydrated zip archive including the data report and 
      locations of data files (use the rehydrate command to retrieve data 
      files).
    inputBinding:
      position: 101
      prefix: --dehydrated
  - id: exclude_atypical
    type:
      - 'null'
      - boolean
    doc: Exclude atypical assemblies
    inputBinding:
      position: 101
      prefix: --exclude-atypical
  - id: mag
    type:
      - 'null'
      - string
    doc: Limit to metagenome assembled genomes (only) or remove them from the 
      results (exclude)
    inputBinding:
      position: 101
      prefix: --mag
  - id: preview
    type:
      - 'null'
      - boolean
    doc: Show information about the requested data package
    inputBinding:
      position: 101
      prefix: --preview
  - id: reference
    type:
      - 'null'
      - boolean
    doc: Limit to reference genomes
    inputBinding:
      position: 101
      prefix: --reference
  - id: released_after
    type:
      - 'null'
      - string
    doc: Limit to genomes released on or after a specified date (MM/DD/YYYY)
    inputBinding:
      position: 101
      prefix: --released-after
  - id: released_before
    type:
      - 'null'
      - string
    doc: Limit to genomes released on or before a specified date (MM/DD/YYYY)
    inputBinding:
      position: 101
      prefix: --released-before
  - id: search
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Limit results to genomes with specified text in the searchable fields: species
      and infraspecies, assembly name and submitter. To search multiple strings, use
      the flag multiple times.'
    inputBinding:
      position: 101
      prefix: --search
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify an NCBI API key
    inputBinding:
      position: 101
      prefix: --api-key
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit debugging info
    inputBinding:
      position: 101
      prefix: --debug
  - id: filename
    type: string
    doc: Specify a custom file name for the downloaded data package
    inputBinding:
      position: 101
      prefix: --filename
  - id: no_progressbar
    type:
      - 'null'
      - boolean
    doc: Hide progress bar
    inputBinding:
      position: 101
      prefix: --no-progressbar
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Specify a custom file name for the downloaded data package
    outputBinding:
      glob: $(inputs.filename)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: ensemblorg/datasets-cli:latest
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
