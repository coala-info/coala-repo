cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blastMining
  - full_pipeline
label: blastmining_full_pipeline
doc: 'blastMining: Running BLAST + mining the output. Needs an NCBI taxonomy dump (nodes.dmp, names.dmp, merged.dmp, delnodes.dmp) for TaxonKit.

Tool homepage: https://github.com/NuruddinKhoiry/blastMining'
inputs:
  - id: input
    type: File
    doc: 'input FASTA'
    inputBinding:
      position: 101
      prefix: -i
  - id: blast_param
    type: string
    doc: 'BLAST parameters: "-outfmt" has been defined by the package, you don''t need to add it. Give the BLAST database path with -db [default="-db nt -num_threads 1 -max_target_seqs 10"]'
    inputBinding:
      position: 101
      prefix: -bp
  - id: outdir
    type: string
    doc: 'Output directory (relative path)'
    inputBinding:
      position: 101
      prefix: -o
  - id: blast_db
    type:
      - 'null'
      - Directory
    doc: 'Directory holding the BLAST+ database named in blast_param (staged in the working directory, so -db <dir basename>/<db name> resolves)'
  - id: mining
    type:
      - 'null'
      - string
    doc: 'blastMining method. Available methods={''vote'',''voteSpecies'',''lca'',''besthit''} [default=''vote'']'
    inputBinding:
      position: 101
      prefix: -m
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
    doc: 'Threshold of p. identity (Ignore hits if their p. identities are below this threshold) [default=97] Required for voteSpecies, lca, and besthit methods; not compatible with vote method'
    inputBinding:
      position: 101
      prefix: -pi
  - id: taxa_level
    type:
      - 'null'
      - string
    doc: 'P.identity cut-off for Kingdom,Phylum,Class,Order,Family,Genus,Species. A comma separated list of integers [default=99,97,95,90,85,80,75] Required for vote method; not compatible with voteSpecies, lca, and besthit methods'
    inputBinding:
      position: 101
      prefix: -txl
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
    doc: 'Output prefix [default=''blastMining'']'
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
      glob: "$(inputs.outdir + '/' + (inputs.prefix ? inputs.prefix : 'blastMining') + '.tsv')"
  - id: summary
    type: File
    doc: Taxon count summary table (<prefix>.summary)
    outputBinding:
      glob: "$(inputs.outdir + '/' + (inputs.prefix ? inputs.prefix : 'blastMining') + '.summary')"
  - id: krona_html
    type:
      - 'null'
      - File
    doc: Krona plot (<prefix>.html), written with krona_plot
    outputBinding:
      glob: "$(inputs.outdir + '/' + (inputs.prefix ? inputs.prefix : 'blastMining') + '.html')"
  - id: blast_output
    type:
      - 'null'
      - File
    doc: BLAST tabular output written by the pipeline (<outdir>/TMPDIR/<prefix>_BLASTN.out; removed by rm_tmpdir)
    outputBinding:
      glob: "$(inputs.outdir + '/' + 'TMPDIR/' + (inputs.prefix ? inputs.prefix : 'blastMining') + '_BLASTN.out')"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TAXONKIT_DB
        envValue: $(inputs.taxonkit_db.path)
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.blast_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
