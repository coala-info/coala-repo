cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangolin
label: pangolin
doc: "Phylogenetic Assignment of Named Global Outbreak LINeages\n\nTool homepage:
  https://github.com/hCoV-2019/pangolin"
inputs:
  - id: query
    type: File
    doc: Query fasta file of sequences to analyse.
    inputBinding:
      position: 1
  - id: add_assignment_cache
    type:
      - 'null'
      - boolean
    doc: Install the pangolin-assignment repository for use with 
      --use-assignment-cache. This makes updates slower and makes pangolin 
      slower for small numbers of input sequences but much faster for large 
      numbers of input sequences.
    inputBinding:
      position: 102
      prefix: --add-assignment-cache
  - id: aliases
    type:
      - 'null'
      - boolean
    doc: Print Pango alias_key.json and exit.
    inputBinding:
      position: 102
      prefix: --aliases
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Output multiple sequence alignment.
    inputBinding:
      position: 102
      prefix: --alignment
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Multiple sequence alignment file name.
    inputBinding:
      position: 102
      prefix: --alignment-file
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: Print all tool, dependency, and data versions then exit.
    inputBinding:
      position: 102
      prefix: --all-versions
  - id: analysis_mode
    type:
      - 'null'
      - string
    doc: 'Pangolin includes multiple analysis engines: UShER and pangoLEARN. Scorpio
      is used in conjunction with pangoLEARN to curate variant of concern (VOC)-related
      lineage calls. UShER is the default and is selected using option "usher" or
      "accurate". pangoLEARN has been depreciated, but older models can be run using
      "pangolearn" or "fast" with "--datadir" provided. Finally, it is possible to
      skip the UShER/ pangoLEARN step by selecting "scorpio" mode, but in this case
      only VOC-related lineages will be assigned.'
    inputBinding:
      position: 102
      prefix: --analysis-mode
  - id: assignment_cache
    type:
      - 'null'
      - File
    doc: Cached precomputed assignment file to use instead of default from 
      pangolin-assignment repository. Does not require installation of 
      pangolin-assignment.
    inputBinding:
      position: 102
      prefix: --assignment-cache
  - id: datadir
    type:
      - 'null'
      - Directory
    doc: Data directory minimally containing the pangoLEARN model and header 
      files or UShER tree.
    inputBinding:
      position: 102
      prefix: --datadir
  - id: expanded_lineage
    type:
      - 'null'
      - boolean
    doc: Optional expanded lineage from alias.json in report.
    inputBinding:
      position: 102
      prefix: --expanded-lineage
  - id: max_ambig
    type:
      - 'null'
      - float
    doc: Maximum proportion of Ns allowed for pangolin to attempt assignment.
    inputBinding:
      position: 102
      prefix: --max-ambig
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum query length allowed for pangolin to attempt assignment.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: no_temp
    type:
      - 'null'
      - boolean
    doc: Output all intermediate files, for dev purposes.
    inputBinding:
      position: 102
      prefix: --no-temp
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: outfile
    type:
      - 'null'
      - string
    doc: Optional output file name.
    inputBinding:
      position: 102
      prefix: --outfile
  - id: pangolin_data_version
    type:
      - 'null'
      - boolean
    doc: show version number of pangolin data files (UShER tree and pangoLEARN 
      model files) and exit.
    inputBinding:
      position: 102
      prefix: --pangolin-data-version
  - id: skip_designation_cache
    type:
      - 'null'
      - boolean
    doc: Developer option - do not use designation cache to assign lineages.
    inputBinding:
      position: 102
      prefix: --skip-designation-cache
  - id: skip_scorpio
    type:
      - 'null'
      - boolean
    doc: Developer option - do not use scorpio to check VOC/VUI lineage 
      assignments.
    inputBinding:
      position: 102
      prefix: --skip-scorpio
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Specify where you want the temp stuff to go.
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: update
    type:
      - 'null'
      - boolean
    doc: Automatically updates to latest release of pangolin, pangolin-data, 
      scorpio and constellations (and pangolin-assignment if it has been 
      installed using --add-assignment-cache), then exits.
    inputBinding:
      position: 102
      prefix: --update
  - id: update_data
    type:
      - 'null'
      - boolean
    doc: Automatically updates to latest release of constellations and 
      pangolin-data, including the pangoLEARN model, UShER tree file and alias 
      file (also pangolin-assignment if it has been installed using 
      --add-assignment-cache), then exits.
    inputBinding:
      position: 102
      prefix: --update-data
  - id: use_assignment_cache
    type:
      - 'null'
      - boolean
    doc: 'Use assignment cache from optional pangolin-assignment repository. NOTE:
      the repository must be installed by --add-assignment-cache before using --use-assignment-cache.'
    inputBinding:
      position: 102
      prefix: --use-assignment-cache
  - id: use_old_datadir
    type:
      - 'null'
      - boolean
    doc: Use the data from data directory even if older than data installed via 
      Python packages.
    inputBinding:
      position: 102
      prefix: --use-old-datadir
  - id: usher_tree
    type:
      - 'null'
      - File
    doc: UShER Mutation Annotated Tree protobuf file to use instead of default 
      from pangolin-data repository or --datadir.
    inputBinding:
      position: 102
      prefix: --usher-tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print lots of stuff to screen
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangolin:4.3.4--pyhdfd78af_1
stdout: pangolin.out
