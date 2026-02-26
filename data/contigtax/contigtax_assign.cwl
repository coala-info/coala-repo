cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax_assign
label: contigtax_assign
doc: "Assigns taxonomy to contigs based on Diamond blastx results.\n\nTool homepage:
  https://github.com/NBISweden/contigtax"
inputs:
  - id: diamond_results
    type: File
    doc: Diamond blastx results
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: Output file
    inputBinding:
      position: 2
  - id: assignranks
    type:
      - 'null'
      - type: array
        items: string
    doc: Ranks to use when assigning taxa. Defaults to phylum genus species
    default:
      - phylum
      - genus
      - species
    inputBinding:
      position: 103
      prefix: --assignranks
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Size of chunks sent to process pool. For large input files using a 
      large chunksize can make the job complete much faster than using the 
      default value of 1
    default: 1
    inputBinding:
      position: 103
      prefix: --chunksize
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use. Defaults to 1.
    default: 1
    inputBinding:
      position: 103
      prefix: --cpus
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value to store hits. Default 0.001
    default: 0.001
    inputBinding:
      position: 103
      prefix: --evalue
  - id: format
    type:
      - 'null'
      - string
    doc: Type of file format for diamond results. blast=blast tabular output, 
      'contigtax'=blast tabular output with taxid in 12th column
    inputBinding:
      position: 103
      prefix: --format
  - id: mode
    type:
      - 'null'
      - string
    doc: "Mode to use for parsing taxonomy: 'rank_lca' (default), 'rank_vote' or 'score'"
    default: rank_lca
    inputBinding:
      position: 103
      prefix: --mode
  - id: rank_thresholds
    type:
      - 'null'
      - type: array
        items: float
    doc: Rank-specific thresholds corresponding to percent identity of a hit. 
      Defaults to 45 (phylum), 60 (genus) and 85 (species)
    default:
      - 45.0
      - 60.0
      - 85.0
    inputBinding:
      position: 103
      prefix: --rank_thresholds
  - id: reportranks
    type:
      - 'null'
      - type: array
        items: string
    doc: Ranks to report in output. Defaults to superkingom phylum class order 
      family genus species
    default:
      - superkingom
      - phylum
      - class
      - order
      - family
      - genus
      - species
    inputBinding:
      position: 103
      prefix: --reportranks
  - id: sqlitedb
    type:
      - 'null'
      - string
    doc: Name of ete3 sqlite file to be created within --taxdir. Defaults to 
      'taxonomy.sqlite'
    default: taxonomy.sqlite
    inputBinding:
      position: 103
      prefix: --sqlitedb
  - id: taxdir
    type:
      - 'null'
      - Directory
    doc: Directory specified during 'contigtax download taxonomy'. Defaults to 
      taxonomy/.
    default: taxonomy/
    inputBinding:
      position: 103
      prefix: --taxdir
  - id: taxidmap
    type:
      - 'null'
      - File
    doc: Provide custom protein to taxid mapfile.
    inputBinding:
      position: 103
      prefix: --taxidmap
  - id: top
    type:
      - 'null'
      - float
    doc: Top percent of best score to consider hits for (default=5)
    default: 5.0
    inputBinding:
      position: 103
      prefix: --top
  - id: vote_threshold
    type:
      - 'null'
      - float
    doc: Minimum fraction required when voting on rank assignments.
    inputBinding:
      position: 103
      prefix: --vote_threshold
outputs:
  - id: blobout
    type:
      - 'null'
      - File
    doc: Output hits.tsv table compatible with blobtools
    outputBinding:
      glob: $(inputs.blobout)
  - id: taxidout
    type:
      - 'null'
      - File
    doc: Write output with taxonomy ids instead of taxonomy names to file
    outputBinding:
      glob: $(inputs.taxidout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
