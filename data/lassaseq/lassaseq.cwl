cwlVersion: v1.2
class: CommandLineTool
baseCommand: lassaseq
label: lassaseq
doc: "Download and filter Lassa virus sequences\n\nTool homepage: https://github.com/DaanJansen94/LassaSeq"
inputs:
  - id: completeness
    type:
      - 'null'
      - int
    doc: Minimum sequence completeness (1-100 percent) Required when --genome=2
    inputBinding:
      position: 101
      prefix: --completeness
  - id: consensus_l
    type:
      - 'null'
      - File
    doc: (Optional) Path to custom consensus sequence for L segment The sequence
      should be in FASTA format
    inputBinding:
      position: 101
      prefix: --consensus_L
  - id: consensus_s
    type:
      - 'null'
      - File
    doc: (Optional) Path to custom consensus sequence for S segment The sequence
      should be in FASTA format
    inputBinding:
      position: 101
      prefix: --consensus_S
  - id: countries
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of countries to filter sequences Examples: "Sierra
      Leone, Guinea" or "Nigeria, Mali" Available: Nigeria, Sierra Leone, Liberia,
      Guinea, Mali, Ghana, Benin, Burkina Faso, Ivory Coast, Togo'
    inputBinding:
      position: 101
      prefix: --countries
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Genome completeness filter: 1 = Complete genomes only (>99 percent of reference
      length) 2 = Partial genomes (specify minimum percent with --completeness) 3
      = No completeness filter'
    inputBinding:
      position: 101
      prefix: --genome
  - id: host
    type:
      - 'null'
      - string
    doc: 'Host filter: 1 = Human sequences only 2 = Rodent sequences only 3 = Both
      human and rodent sequences 4 = No host filter'
    inputBinding:
      position: 101
      prefix: --host
  - id: l_sublineage
    type:
      - 'null'
      - string
    doc: '(Optional) Filter L segment sequences by sublineage Example: --l_sublineage
      III'
    inputBinding:
      position: 101
      prefix: --l_sublineage
  - id: lineage
    type:
      - 'null'
      - string
    doc: '(Optional) Filter sequences by lineage Example: --lineage IV'
    inputBinding:
      position: 101
      prefix: --lineage
  - id: metadata
    type:
      - 'null'
      - string
    doc: 'Metadata completeness filter: 1 = Keep only sequences with known location
      2 = Keep only sequences with known date 3 = Keep only sequences with both known
      location and date 4 = No metadata filter'
    inputBinding:
      position: 101
      prefix: --metadata
  - id: outdir
    type: Directory
    doc: Output directory for sequences
    inputBinding:
      position: 101
      prefix: --outdir
  - id: phylogeny
    type:
      - 'null'
      - boolean
    doc: (Optional) Create concatenated FASTA files for phylogenetic analysis 
      Creates directories for MSA, recombination detection, and tree building
    inputBinding:
      position: 101
      prefix: --phylogeny
  - id: remove
    type:
      - 'null'
      - File
    doc: '(Optional) File containing accession numbers to remove One accession number
      per line, lines starting with # are ignored'
    inputBinding:
      position: 101
      prefix: --remove
  - id: s_sublineage
    type:
      - 'null'
      - string
    doc: '(Optional) Filter S segment sequences by sublineage Example: --s_sublineage
      II'
    inputBinding:
      position: 101
      prefix: --s_sublineage
  - id: sublineage
    type:
      - 'null'
      - string
    doc: '(Optional) Filter sequences by sublineage (applies to both segments) Example:
      --sublineage III'
    inputBinding:
      position: 101
      prefix: --sublineage
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lassaseq:0.1.2--pyhdfd78af_0
stdout: lassaseq.out
