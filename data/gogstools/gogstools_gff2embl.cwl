cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2embl
label: gogstools_gff2embl
doc: "Convert GFF3 to EMBL format for ENA submission.\n\nTool homepage: https://github.com/genouest/ogs-tools"
inputs:
  - id: gff_file
    type: File
    doc: The gff to read from
    inputBinding:
      position: 1
  - id: description
    type: string
    doc: Description of the project
    inputBinding:
      position: 102
      prefix: --description
  - id: division
    type:
      - 'null'
      - string
    doc: The taxonomic division (INV=invertebrate)
    inputBinding:
      position: 102
      prefix: --division
  - id: email
    type: string
    doc: A valid email address
    inputBinding:
      position: 102
      prefix: --email
  - id: genome
    type: File
    doc: A fasta file containing genome sequence
    inputBinding:
      position: 102
      prefix: --genome
  - id: no_empty_seq
    type:
      - 'null'
      - boolean
    doc: Write only sequences having features
    inputBinding:
      position: 102
      prefix: --no_empty_seq
  - id: no_stop_codon
    type:
      - 'null'
      - boolean
    doc: Add this option if the protein sequences don't contain trailing stop 
      codons even for complete sequences
    inputBinding:
      position: 102
      prefix: --no_stop_codon
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'Flavor of EMBL output format: embl-standard=standard EMBL format; embl-ebi-submit=EMBL
      ready to submit to EBI (some special formating for automatic EBI post-processing)'
    inputBinding:
      position: 102
      prefix: --out-format
  - id: project
    type: string
    doc: A valid EBI study ID (PRJXXXXXXX)
    inputBinding:
      position: 102
      prefix: --project
  - id: proteins
    type: File
    doc: A fasta file containing protein sequences
    inputBinding:
      position: 102
      prefix: --proteins
  - id: ref_authors
    type:
      - 'null'
      - string
    doc: Authors of the reference
    inputBinding:
      position: 102
      prefix: --ref_authors
  - id: ref_consortium
    type:
      - 'null'
      - string
    doc: Consortium name of the reference
    inputBinding:
      position: 102
      prefix: --ref_consortium
  - id: ref_journal
    type:
      - 'null'
      - string
    doc: Journal of the reference
    inputBinding:
      position: 102
      prefix: --ref_journal
  - id: ref_pubmed_id
    type:
      - 'null'
      - string
    doc: PubMed ID of the reference
    inputBinding:
      position: 102
      prefix: --ref_pubmed_id
  - id: ref_title
    type:
      - 'null'
      - string
    doc: Title of the reference
    inputBinding:
      position: 102
      prefix: --ref_title
  - id: species
    type: string
    doc: The name of the species
    inputBinding:
      position: 102
      prefix: --species
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output embl file, ready for submission to EBI ENA
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gogstools:0.1.2--py310hdfd78af_0
