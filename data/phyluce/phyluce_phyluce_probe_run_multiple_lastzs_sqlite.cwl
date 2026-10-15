cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_run_multiple_lastzs_sqlite
label: phyluce_phyluce_probe_run_multiple_lastzs_sqlite
doc: "Align a set of probes against genome sequence(s) in scaffolds or chromosomes\n\
  \nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: db
    type: string
    doc: The database in which to store results (also use --append if adding results
      to an existing database)
    inputBinding:
      prefix: --db
  - id: existing_db
    type:
      - 'null'
      - File
    doc: An existing database to add to (use with --append); a staged copy is updated
      and returned under the name given in db.
  - id: output_dir
    type: string
    doc: The directory in which to store the LASTZ files
    inputBinding:
      prefix: --output
  - id: probefile
    type: File
    doc: The probe file to align against the sequences
    inputBinding:
      prefix: --probefile
  - id: chromolist
    type:
      - 'null'
      - &id001
        type: array
        items: string
    doc: The list of organisms with genome sequences in chromosomes
    inputBinding:
      prefix: --chromolist
  - id: scaffoldlist
    type:
      - 'null'
      - *id001
    doc: The list of organisms with genome sequences in scaffolds/contigs
    inputBinding:
      prefix: --scaffoldlist
  - id: append
    type:
      - 'null'
      - boolean
    doc: Insert results to an existing database
    inputBinding:
      prefix: --append
  - id: no_dir
    type:
      - 'null'
      - boolean
    doc: If genome sequences are not in their own abbr. directory
    inputBinding:
      prefix: --no-dir
  - id: cores
    type:
      - 'null'
      - int
    doc: The number of compute cores to use
    inputBinding:
      prefix: --cores
  - id: genome_base_path
    type: Directory
    doc: The base path to a directory containing genomes sequences (<name>/<name>.2bit,
      or <name>.2bit with --no-dir)
    inputBinding:
      prefix: --genome-base-path
  - id: coverage
    type:
      - 'null'
      - float
    doc: The default coverage to search for using lastz
    inputBinding:
      prefix: --coverage
  - id: identity
    type:
      - 'null'
      - float
    doc: The default percent identity to search for using lastz
    inputBinding:
      prefix: --identity
outputs:
  - id: database
    type: File
    doc: The SQLite database of probe matches.
    outputBinding:
      glob: $(inputs.db)
  - id: lastz_files
    type: Directory
    doc: The directory of lastz files.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.existing_db)
        entryname: $(inputs.db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
