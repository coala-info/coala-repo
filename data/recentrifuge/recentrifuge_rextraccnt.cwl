cwlVersion: v1.2
class: CommandLineTool
baseCommand: rextraccnt
label: recentrifuge_rextraccnt
doc: 'Extraction from fasta with accessions as NCBI nt DB


  Tool homepage: https://github.com/khyox/recentrifuge'
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Output FASTA file will be gzipped
    inputBinding:
      position: 101
      prefix: --compress
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: entrymax
    type:
      - 'null'
      - int
    doc: maximum number of nt DB entries to search for the taxa
    inputBinding:
      position: 101
      prefix: --entrymax
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude
    doc: NCBI taxid code to exclude a taxon and all underneath (multiple -x is available
      to exclude several taxid)
    inputBinding:
      position: 101
  - id: include
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --include
    doc: NCBI taxid code to include a taxon and all underneath (multiple -i is available
      to include several taxid); by default all the taxa is considered for inclusion
    inputBinding:
      position: 101
  - id: limit
    type:
      - 'null'
      - int
    doc: limit of nt DB entries to extract
    inputBinding:
      position: 101
      prefix: --limit
  - id: mapfile
    type: File
    doc: Mapping (accession to taxid) file
    inputBinding:
      position: 101
      prefix: --mapfile
  - id: nodespath
    type:
      - 'null'
      - Directory
    doc: path for the nodes information files (nodes.dmp and names.dmp from NCBI)
    inputBinding:
      position: 101
      prefix: --nodespath
  - id: ntfastafile
    type: File
    doc: NCBI nt formatted FASTA file
    inputBinding:
      position: 101
      prefix: --ntfastafile
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: extracted_fasta
    type:
      - 'null'
      - File
    doc: FASTA file with the extracted nt entries (<input name>_rxnt*.fa)
    outputBinding:
      glob: '*_rxnt*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.ntfastafile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
stdout: recentrifuge_rextraccnt.out
