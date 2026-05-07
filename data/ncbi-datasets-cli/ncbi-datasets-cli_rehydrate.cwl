cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datasets
  - rehydrate
label: ncbi-datasets-cli_rehydrate
doc: Download data files for an unzipped, dehydrated genome data package. Data 
  files specified in fetch.txt will be downloaded from NCBI.
inputs:
  - id: directory
    type: Directory
    doc: Specify the directory containing the unzipped dehydrated bag
    inputBinding:
      position: 101
      prefix: --directory
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: rehydrate files to gzip format
    inputBinding:
      position: 101
      prefix: --gzip
  - id: list
    type:
      - 'null'
      - boolean
    doc: List files that would be downloaded during rehydration
    inputBinding:
      position: 101
      prefix: --list
  - id: match
    type:
      - 'null'
      - string
    doc: Specify substring that matches files for rehydration
    inputBinding:
      position: 101
      prefix: --match
  - id: max_workers
    type:
      - 'null'
      - int
    doc: Limit the maximum number of concurrent download workers (allowed range 
      is 1-30)
    inputBinding:
      position: 101
      prefix: --max-workers
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
stdout: ncbi-datasets-cli_rehydrate.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
