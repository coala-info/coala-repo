cwlVersion: v1.2
class: CommandLineTool
baseCommand: beav
label: beav
doc: "BEAV- Bacterial Element Annotation reVamped\n\nTool homepage: https://github.com/weisberglab/beav"
inputs:
  - id: agrobacterium
    type:
      - 'null'
      - boolean
    doc: Agrobacterium specific tools that identify biovar/species group, Ti/Ri 
      plasmid, T-DNA borders, virboxes and traboxes
    inputBinding:
      position: 101
      prefix: --agrobacterium
  - id: antismash_arguments
    type:
      - 'null'
      - string
    doc: 'Additional arguments specific to antiSMASH (Default: "")'
    default: ''
    inputBinding:
      position: 101
      prefix: --antismash_arguments
  - id: bakta_arguments
    type:
      - 'null'
      - string
    doc: Additional arguments specific to Bakta
    inputBinding:
      position: 101
      prefix: --bakta_arguments
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Continue a previously started run
    inputBinding:
      position: 101
      prefix: --continue
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Use a GenBank file as input
    inputBinding:
      position: 101
      prefix: --genbank
  - id: input
    type: File
    doc: Input file in fasta nucleotide format (Required)
    inputBinding:
      position: 101
      prefix: --input
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: 'Output directory (default: current working directory)'
    default: current working directory
    inputBinding:
      position: 101
      prefix: --output
  - id: run_operon_email
    type:
      - 'null'
      - string
    doc: Run the Operon-mapper pipeline [remote]. Requires an email address for 
      the operon-mapper webserver job
    inputBinding:
      position: 101
      prefix: --run_operon_email
  - id: skip_antismash
    type:
      - 'null'
      - boolean
    doc: Skip detection and annotation of biosynthetic gene clusters
    inputBinding:
      position: 101
      prefix: --skip_antismash
  - id: skip_dbscan_swa
    type:
      - 'null'
      - boolean
    doc: Skip detection and annotation of prophage
    inputBinding:
      position: 101
      prefix: --skip_dbscan-swa
  - id: skip_defensefinder
    type:
      - 'null'
      - boolean
    doc: Skip detection and annotation of anti-phage defense systems
    inputBinding:
      position: 101
      prefix: --skip_defensefinder
  - id: skip_gapmind
    type:
      - 'null'
      - boolean
    doc: Skip detection of amino acid biosynthesis and carbon metabolism 
      pathways
    inputBinding:
      position: 101
      prefix: --skip_gapmind
  - id: skip_integronfinder
    type:
      - 'null'
      - boolean
    doc: Skip detection and annotation of integrons
    inputBinding:
      position: 101
      prefix: --skip_integronfinder
  - id: skip_macsyfinder
    type:
      - 'null'
      - boolean
    doc: Skip detection and annotation of secretion systems
    inputBinding:
      position: 101
      prefix: --skip_macsyfinder
  - id: skip_tiger
    type:
      - 'null'
      - boolean
    doc: Skip detection and annotation of integrative conjugative elements 
      (ICEs)
    inputBinding:
      position: 101
      prefix: --skip_tiger
  - id: strain
    type:
      - 'null'
      - string
    doc: 'Strain name (default: input file prefix)'
    default: input file prefix
    inputBinding:
      position: 101
      prefix: --strain
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tiger_blast_database
    type: File
    doc: Path to a reference genome blast database for TIGER2 ICE analysis 
      (Required unless --skip_tiger is used)
    inputBinding:
      position: 101
      prefix: --tiger_blast_database
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beav:1.4.0--hdfd78af_1
stdout: beav.out
