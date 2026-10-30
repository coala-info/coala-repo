cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_BDBHs.pl
label: get_homologues_check_BDBHs.pl
doc: "Retrieves the BLAST (bidirectional) best hits of a sequence, as produced by get_homologues.pl and get_homologues-est.pl.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: homologues_dir
    type: Directory
    doc: directory with get_homologues output (example /path/to/genomes_homologues)
    inputBinding:
      position: 1
      prefix: -d
  - id: sequence_id
    type: string
    doc: sequence identifier
    inputBinding:
      position: 1
      prefix: -i
  - id: show_self_hits
    type:
      - 'null'
      - boolean
    doc: show self hits
    inputBinding:
      position: 1
      prefix: -s
  - id: hits_per_species
    type:
      - 'null'
      - int
    doc: number of hits to show per species (default 1)
    inputBinding:
      position: 1
      prefix: -n
  - id: show_pfam_domains
    type:
      - 'null'
      - boolean
    doc: show Pfam protein domains if available
    inputBinding:
      position: 1
      prefix: -D
  - id: guess_identifier
    type:
      - 'null'
      - boolean
    doc: guess sequence identifier for the -i label (find out ids for sequence names, such as 'rpoB')
    inputBinding:
      position: 1
      prefix: -g
  - id: taxon
    type:
      - 'null'
      - string
    doc: show only hits from this taxon (example genome1.faa)
    inputBinding:
      position: 1
      prefix: -t
  - id: est_sequences
    type:
      - 'null'
      - boolean
    doc: sequences are (possibly redundant) ESTs (get coverage of short isoforms if not labelled as full-length)
    inputBinding:
      position: 1
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Best hits of the query sequence per taxon.
stdout: get_homologues_check_BDBHs.pl.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
