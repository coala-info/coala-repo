cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamate dump
label: metamate_dump
doc: "Dump filtered ASVs based on specifications.\n\nTool homepage: https://github.com/tjcreedy/metamate"
inputs:
  - id: anyfail
    type:
      - 'null'
      - boolean
    doc: reject ASVs when any incidences fail to meet a threshold (default is 
      all incidences)
    inputBinding:
      position: 101
      prefix: --anyfail
  - id: asvs
    type: File
    doc: path to a fasta of unique sequences to filter
    inputBinding:
      position: 101
      prefix: --asvs
  - id: distancemodel
    type:
      - 'null'
      - string
    doc: substitution model for UPGMA tree estimation (passed to R dist.dna)
    inputBinding:
      position: 101
      prefix: --distancemodel
  - id: divergence
    type:
      - 'null'
      - float
    doc: divergence level to use for assigning clades
    inputBinding:
      position: 101
      prefix: --divergence
  - id: libraries
    type:
      - 'null'
      - type: array
        items: File
    doc: path to fastx file(s) of individual libraries/discrete samples from 
      which ASVs were drawn, or a single fastx with ';samplename=NAME;' or 
      ';barcodelabel=NAME;' annotations in headers.
    inputBinding:
      position: 101
      prefix: --libraries
  - id: otu_fasta
    type:
      - 'null'
      - File
    doc: path to a fasta file containing OTU centroid sequences
    inputBinding:
      position: 101
      prefix: --otu_fasta
  - id: otu_table
    type:
      - 'null'
      - File
    doc: path to a table (CSV/TSV) containing OTU counts per library
    inputBinding:
      position: 101
      prefix: --otu_table
  - id: output
    type: string
    doc: the base directory/file name path to which intermediate and final 
      output data should be written, file extensions will be added as necessary
    inputBinding:
      position: 101
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: force overwriting of intermediate and/or final output(s)
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: readmap
    type:
      - 'null'
      - File
    doc: path to a comma- or tab- separated tabular text file containing read 
      counts for ASVs by library
    inputBinding:
      position: 101
      prefix: --readmap
  - id: realign
    type:
      - 'null'
      - boolean
    doc: force (re)alignment of the input ASVs
    inputBinding:
      position: 101
      prefix: --realign
  - id: resultcache
    type:
      - 'null'
      - File
    doc: path to the _resultcache file from a previous run
    inputBinding:
      position: 101
      prefix: --resultcache
  - id: resultindex
    type:
      - 'null'
      - type: array
        items: int
    doc: one or more indices of result(s) from a previous run from which to 
      generate filtered ASVs
    inputBinding:
      position: 101
      prefix: --resultindex
  - id: specification
    type:
      - 'null'
      - type: array
        items: string
    doc: one or more [category(/ies); metric; threshold] strings denoting the 
      (multiplicative) specification for dumping errors. If provided via CLI, 
      each [] string must be quoted
    inputBinding:
      position: 101
      prefix: --specification
  - id: taxgroups
    type:
      - 'null'
      - File
    doc: path to a two-column csv file specifying the taxon for each ASV
    inputBinding:
      position: 101
      prefix: --taxgroups
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - File
    doc: path to an ultrametric tree of the ASVs
    inputBinding:
      position: 101
      prefix: --tree
  - id: uc
    type:
      - 'null'
      - File
    doc: path to a .uc file (vsearch output) mapping ASVs to OTUs
    inputBinding:
      position: 101
      prefix: --uc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
stdout: metamate_dump.out
