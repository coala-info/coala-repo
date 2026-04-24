cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax search
label: contigtax_search
doc: "Search for contigs in a Diamond database and assign taxonomy.\n\nTool homepage:
  https://github.com/NBISweden/contigtax"
inputs:
  - id: query
    type: File
    doc: Query contig nucleotide file
    inputBinding:
      position: 1
  - id: dbfile
    type: File
    doc: Diamond database file
    inputBinding:
      position: 2
  - id: blocksize
    type:
      - 'null'
      - float
    doc: Sequence block size in billions of letters (default=2.0). Set to 20 on 
      clusters
    inputBinding:
      position: 103
      prefix: --blocksize
  - id: chunks
    type:
      - 'null'
      - int
    doc: Number of chunks for index processing (default=4)
    inputBinding:
      position: 103
      prefix: --chunks
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use for diamond
    inputBinding:
      position: 103
      prefix: --cpus
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments (default=0.001)
    inputBinding:
      position: 103
      prefix: --evalue
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length of queries. Shorter queries will be filtered prior to 
      search.
    inputBinding:
      position: 103
      prefix: --minlen
  - id: mode
    type:
      - 'null'
      - string
    doc: "Choice of search mode for diamond: 'blastx' (default) for DNA query sequences
      or 'blastp' for amino acid query sequences"
    inputBinding:
      position: 103
      prefix: --mode
  - id: taxonmap
    type:
      - 'null'
      - File
    doc: Protein accession to taxid mapfile (must be gzipped). Only required for
      searching if diamond version <0.9.19
    inputBinding:
      position: 103
      prefix: --taxonmap
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: top
    type:
      - 'null'
      - int
    doc: Report alignments within this percentage range of top bitscore 
      (default=10)
    inputBinding:
      position: 103
      prefix: --top
outputs:
  - id: outfile
    type: File
    doc: Diamond output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
