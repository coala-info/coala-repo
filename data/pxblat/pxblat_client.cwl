cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - client
label: pxblat_client
doc: "A client for the genomic finding program that produces a .psl file.\n\nTool
  homepage: https://pypi.org/project/pxblat/"
inputs:
  - id: host
    type: string
    doc: The name of the machine running the gfServer
    inputBinding:
      position: 1
  - id: port
    type: int
    doc: The same port that you started the gfServer with
    inputBinding:
      position: 2
  - id: seqdir
    type: Directory
    doc: The path of the .2bit or .nib files relative to the current dir
    inputBinding:
      position: 3
  - id: infasta
    type: File
    doc: Fasta format file. May contain multiple records
    inputBinding:
      position: 4
  - id: dots
    type:
      - 'null'
      - int
    doc: Output a dot every N query sequences.
    inputBinding:
      position: 105
      prefix: --dots
  - id: genome
    type:
      - 'null'
      - string
    doc: dynamic
    inputBinding:
      position: 105
      prefix: --genome
  - id: genome_data_dir
    type:
      - 'null'
      - string
    doc: dynamic
    inputBinding:
      position: 105
      prefix: --genomeDataDir
  - id: max_intron
    type:
      - 'null'
      - int
    doc: Sets maximum intron size.
    inputBinding:
      position: 105
      prefix: --maxIntron
  - id: min_identity
    type:
      - 'null'
      - int
    doc: Sets minimum sequence identity (in percent). Default is 90 for 
      nucleotide searches, 25 for protein or translated protein searches.
    inputBinding:
      position: 105
      prefix: --minIdentity
  - id: min_score
    type:
      - 'null'
      - int
    doc: Sets minimum score. This is twice the matches minus the mismatches 
      minus some sort of gap penalty.
    inputBinding:
      position: 105
      prefix: --minScore
  - id: nohead
    type:
      - 'null'
      - boolean
    doc: Suppresses 5-line psl header.
    inputBinding:
      position: 105
      prefix: --nohead
  - id: out
    type:
      - 'null'
      - string
    doc: 'Controls output file format. Type is one of: psl, pslx, axt, maf, sim4,
      wublast, blast, blast8, blast9'
    inputBinding:
      position: 105
      prefix: --out
  - id: prot
    type:
      - 'null'
      - boolean
    doc: Synonymous with -t=prot -q=prot.
    inputBinding:
      position: 105
      prefix: --prot
  - id: qtype
    type:
      - 'null'
      - string
    doc: 'Query type. Type is one of: dna, rna, prot, dnax, rnax'
    inputBinding:
      position: 105
      prefix: --qtype
  - id: type
    type:
      - 'null'
      - string
    doc: 'Database type. Type is one of: dna, prot, dnax'
    inputBinding:
      position: 105
      prefix: --type
outputs:
  - id: outpsl
    type: File
    doc: where to put the output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
