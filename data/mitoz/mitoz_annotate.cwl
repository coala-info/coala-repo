cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz
  - annotate
label: mitoz_annotate
doc: "Annotate PCGs, tRNA and rRNA genes.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: fastafiles
    type:
      type: array
      items: File
    doc: fasta file(s). The length of sequence id should be <= 13 characters, 
      and each sequence should have 'topology=linear' or 'topology=circular' at 
      the header line, otherwise it is assumbed to be 'topology=linear'. For 
      example, '>Contig1 topology=linear'
    inputBinding:
      position: 1
  - id: clade
    type:
      - 'null'
      - string
    doc: which clade does your species belong to?
    default: Arthropoda
    inputBinding:
      position: 102
      prefix: --clade
  - id: fq1
    type:
      - 'null'
      - File
    doc: Fastq1 file if you want to visualize the depth distribution
    inputBinding:
      position: 102
      prefix: --fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: Fastq2 file if you want to visualize the depth distribution
    inputBinding:
      position: 102
      prefix: --fq2
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: which genetic code table to use? 'auto' means determined by '--clade' 
      option.
    default: auto
    inputBinding:
      position: 102
      prefix: --genetic_code
  - id: outprefix
    type: string
    doc: output prefix
    inputBinding:
      position: 102
      prefix: --outprefix
  - id: profiles_dir
    type:
      - 'null'
      - Directory
    doc: Directory cotaining 'CDS_HMM/', 'MT_database/' and 'rRNA_CM/'.
    default: /usr/local/lib/python3.8/site-packages/mitoz/profiles
    inputBinding:
      position: 102
      prefix: --profiles_dir
  - id: species_name
    type:
      - 'null'
      - string
    doc: species name to use in output genbank file
    default: Test sp.
    inputBinding:
      position: 102
      prefix: --species_name
  - id: template_sbt
    type:
      - 'null'
      - File
    doc: The sqn template to generate the resulting genbank file. Go to 
      https://www.ncbi.nlm.nih.gov/genbank/tbl2asn/#Template to generate your 
      own template file if you like.
    default: 
      /usr/local/lib/python3.8/site-packages/mitoz/annotate/script/template.sbt
    inputBinding:
      position: 102
      prefix: --template_sbt
  - id: thread_number
    type:
      - 'null'
      - int
    doc: thread number
    default: 8
    inputBinding:
      position: 102
      prefix: --thread_number
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: workdir
    default: ./
    inputBinding:
      position: 102
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
stdout: mitoz_annotate.out
