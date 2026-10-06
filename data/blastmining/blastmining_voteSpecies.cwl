cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blastMining
  - voteSpecies
label: blastmining_voteSpecies
doc: 'blastMining: vote at species level for all. Needs an NCBI taxonomy dump (nodes.dmp, names.dmp, merged.dmp, delnodes.dmp) for TaxonKit.

Tool homepage: https://github.com/NuruddinKhoiry/blastMining'
inputs:
  - id: input
    type: File
    doc: 'blast.out file. Please use this blast outfmt 6 ONLY: ("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")'
    inputBinding:
      position: 101
      prefix: -i
  - id: outdir
    type: string
    doc: 'Output directory (relative path)'
    inputBinding:
      position: 101
      prefix: -o
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'Threshold of evalue (Ignore hits if their evalues are above this threshold) [default=1-e3]'
    inputBinding:
      position: 101
      prefix: -e
  - id: pident
    type:
      - 'null'
      - int
    doc: 'Threshold of p. identity (Ignore hits if their p. identities are below this threshold) [default=99]'
    inputBinding:
      position: 101
      prefix: -pi
  - id: top_n
    type:
      - 'null'
      - int
    doc: 'Top N hits used for voting [default=10]'
    inputBinding:
      position: 101
      prefix: -n
  - id: sample_name
    type:
      - 'null'
      - string
    doc: 'Sample name in the print out table [default="sample"]'
    inputBinding:
      position: 101
      prefix: -sm
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'Number of jobs to run parallelly [default=1]'
    inputBinding:
      position: 101
      prefix: -j
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Output prefix [default=''voteSpecies_method'']'
    inputBinding:
      position: 101
      prefix: -p
  - id: krona_plot
    type:
      - 'null'
      - boolean
    doc: 'Draw krona plot [default=False]'
    inputBinding:
      position: 101
      prefix: -kp
  - id: rm_tmpdir
    type:
      - 'null'
      - boolean
    doc: 'Remove temporary directory (TMPDIR) [default=False]'
    inputBinding:
      position: 101
      prefix: -rm
  - id: taxonkit_db
    type: Directory
    doc: TaxonKit data directory with the NCBI taxonomy dump (nodes.dmp, names.dmp, merged.dmp, delnodes.dmp); passed through the TAXONKIT_DB environment variable
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
  - id: result_table
    type: File
    doc: Per-query taxonomy assignment table (<prefix>.tsv)
    outputBinding:
      glob: "$(inputs.outdir + '/' + (inputs.prefix ? inputs.prefix : 'voteSpecies_method') + '.tsv')"
  - id: summary
    type: File
    doc: Taxon count summary table (<prefix>.summary)
    outputBinding:
      glob: "$(inputs.outdir + '/' + (inputs.prefix ? inputs.prefix : 'voteSpecies_method') + '.summary')"
  - id: krona_html
    type:
      - 'null'
      - File
    doc: Krona plot (<prefix>.html), written with krona_plot
    outputBinding:
      glob: "$(inputs.outdir + '/' + (inputs.prefix ? inputs.prefix : 'voteSpecies_method') + '.html')"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TAXONKIT_DB
        envValue: $(inputs.taxonkit_db.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
