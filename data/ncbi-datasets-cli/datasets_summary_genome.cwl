cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - summary
  - genome
label: datasets_summary_genome
doc: Print a data report containing genome metadata. The data report is returned
  in JSON format.
inputs:
  - id: subcommand
    type:
      - 'null'
      - string
    doc: 'Available commands: accession (by Assembly or BioProject accession) or taxon
      (by NCBI Taxonomy ID, scientific or common name)'
    inputBinding:
      position: 1
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: Limit to annotated genomes
    inputBinding:
      position: 102
      prefix: --annotated
  - id: as_json_lines
    type:
      - 'null'
      - boolean
    doc: Output results in JSON Lines format
    inputBinding:
      position: 102
      prefix: --as-json-lines
  - id: assembly_level
    type:
      - 'null'
      - string
    doc: 'Limit to genomes at one or more assembly levels (comma-separated): chromosome,
      complete, contig, scaffold'
    inputBinding:
      position: 102
      prefix: --assembly-level
  - id: assembly_source
    type:
      - 'null'
      - string
    doc: Limit to 'RefSeq' (GCF_) or 'GenBank' (GCA_) genomes
    inputBinding:
      position: 102
      prefix: --assembly-source
  - id: exclude_atypical
    type:
      - 'null'
      - boolean
    doc: Exclude atypical assemblies
    inputBinding:
      position: 102
      prefix: --exclude-atypical
  - id: limit
    type:
      - 'null'
      - string
    doc: Limit the number of genome summaries returned (all or a number)
    inputBinding:
      position: 102
      prefix: --limit
  - id: mag
    type:
      - 'null'
      - string
    doc: Limit to metagenome assembled genomes (only) or remove them from the 
      results (exclude)
    inputBinding:
      position: 102
      prefix: --mag
  - id: reference
    type:
      - 'null'
      - boolean
    doc: Limit to reference genomes
    inputBinding:
      position: 102
      prefix: --reference
  - id: released_after
    type:
      - 'null'
      - string
    doc: Limit to genomes released on or after a specified date (MM/DD/YYYY)
    inputBinding:
      position: 102
      prefix: --released-after
  - id: released_before
    type:
      - 'null'
      - string
    doc: Limit to genomes released on or before a specified date (MM/DD/YYYY)
    inputBinding:
      position: 102
      prefix: --released-before
  - id: report
    type:
      - 'null'
      - string
    doc: 'Choose the output type: genome (primary report), sequence (sequence report),
      or ids_only'
    inputBinding:
      position: 102
      prefix: --report
  - id: search
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Limit results to genomes with specified text in the searchable fields: species
      and infraspecies, assembly name and submitter'
    inputBinding:
      position: 102
      prefix: --search
  - id: api_key
    type:
      - 'null'
      - string
    doc: Specify an NCBI API key
    inputBinding:
      position: 102
      prefix: --api-key
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit debugging info
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: ensemblorg/datasets-cli:latest
stdout: datasets_summary_genome.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
