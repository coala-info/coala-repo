cwlVersion: v1.2
class: CommandLineTool
baseCommand: rcf
label: recentrifuge_rcf
doc: "Robust comparative analysis and contamination removal for metagenomics\n\nTool
  homepage: https://github.com/khyox/recentrifuge"
inputs:
  - id: avoid_cross_analysis
    type:
      - 'null'
      - boolean
    doc: avoid cross analysis
    inputBinding:
      position: 101
      prefix: --avoidcross
  - id: centrifuge_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Centrifuge output files; if a single directory is entered, every .out 
      file inside will be taken as a different sample; multiple -f is available 
      to include several Centrifuge samples
    inputBinding:
      position: 101
      prefix: --file
  - id: clark_file
    type:
      - 'null'
      - type: array
        items: File
    doc: CLARK full-mode output files; if a single directory is entered, every 
      .csv file inside will be taken as a different sample; multiple -r is 
      available to include several CLARK, CLARK-l, and CLARK-S full-mode samples
    inputBinding:
      position: 101
      prefix: --clark
  - id: controls_number
    type:
      - 'null'
      - int
    doc: this number of first samples will be treated as negative controls; 
      default is no controls
    inputBinding:
      position: 101
      prefix: --controls
  - id: ctrl_min_score
    type:
      - 'null'
      - float
    doc: minimum score/confidence of the classification of a read in control 
      samples to pass the quality filter; it defaults to "minscore"
    inputBinding:
      position: 101
      prefix: --ctrlminscore
  - id: ctrl_min_taxa
    type:
      - 'null'
      - int
    doc: minimum taxa to avoid collapsing one level into the parent (if not 
      specified a value will be automatically assigned)
    inputBinding:
      position: 101
      prefix: --ctrlmintaxa
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 101
      prefix: --debug
  - id: exclude_taxid
    type:
      - 'null'
      - type: array
        items: string
    doc: NCBI taxid code to exclude a taxon and all underneath (multiple -x is 
      available to exclude several taxid)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: extra_output_type
    type:
      - 'null'
      - string
    doc: type of extra output to be generated, and can be one of ['FULL', 'CSV',
      'MULTICSV', 'TSV', 'DYNOMICS']
    inputBinding:
      position: 101
      prefix: --extra
  - id: format
    type:
      - 'null'
      - string
    doc: format of the output files from a generic classifier; It is a string 
      like "TYP:csv,TID:1,LEN:3,SCO:6,UNC:0" where valid file TYPes are 
      csv/tsv/ssv, and the rest of fields indicate the number of column used 
      (starting in 1) for the TaxIDs assigned, the LENgth of the read, the SCOre
      given to the assignment, and the taxid code used for UNClassified reads
    inputBinding:
      position: 101
      prefix: --format
  - id: generic_file
    type:
      - 'null'
      - type: array
        items: File
    doc: output file from a generic classifier; it requires the flag --format 
      (see such option for details); if a single directory is entered, every 
      file inside will be taken as a different sample; multiple -g is available 
      to include several generic samples by filename
    inputBinding:
      position: 101
      prefix: --generic
  - id: include_taxid
    type:
      - 'null'
      - type: array
        items: string
    doc: NCBI taxid code to include a taxon and all underneath (multiple -i is 
      available to include several taxid); by default, all the taxa are 
      considered for inclusion
    inputBinding:
      position: 101
      prefix: --include
  - id: kraken_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Kraken output files; if a single directory is entered, every .krk file 
      inside will be taken as a different sample; multiple -k is available to 
      include several Kraken (version 1 or 2) samples by filename
    inputBinding:
      position: 101
      prefix: --kraken
  - id: lmat_file
    type:
      - 'null'
      - type: array
        items: File
    doc: LMAT output dir or file prefix; if just "." is entered, every 
      subdirectory under the current directory will be taken as a sample and 
      scanned looking for LMAT output files; multiple -l is available to include
      several samples
    inputBinding:
      position: 101
      prefix: --lmat
  - id: min_score
    type:
      - 'null'
      - float
    doc: minimum score/confidence of the classification of a read to pass the 
      quality filter; all pass by default
    inputBinding:
      position: 101
      prefix: --minscore
  - id: min_taxa
    type:
      - 'null'
      - int
    doc: minimum taxa to avoid collapsing one level into the parent (if not 
      specified a value will be automatically assigned)
    inputBinding:
      position: 101
      prefix: --mintaxa
  - id: no_html
    type:
      - 'null'
      - boolean
    doc: suppress saving the HTML output file
    inputBinding:
      position: 101
      prefix: --nohtml
  - id: no_kollapse
    type:
      - 'null'
      - boolean
    doc: show the "cellular organisms" taxon
    inputBinding:
      position: 101
      prefix: --nokollapse
  - id: no_strain
    type:
      - 'null'
      - boolean
    doc: disable strain level as the resolution limit for the robust 
      contamination removal algorithm; by default, strain level is now enabled
    inputBinding:
      position: 101
      prefix: --no-strain
  - id: nodes_path
    type:
      - 'null'
      - File
    doc: path for the nodes information files (nodes.dmp and names.dmp from 
      NCBI)
    inputBinding:
      position: 101
      prefix: --nodespath
  - id: pickle_data
    type:
      - 'null'
      - boolean
    doc: pickle (serialize) statistics and data results in pandas DataFrames 
      (format affected by selection of --extra); one additional flag and the 
      input samples will be serialized as a dict of sample names and TaxTree 
      objects
    inputBinding:
      position: 101
      prefix: --pickle
  - id: scoring
    type:
      - 'null'
      - string
    doc: type of scoring to be applied, and can be one of ['SHEL', 'LENGTH', 
      'LOGLENGTH', 'NORMA', 'LMAT', 'CLARK_C', 'CLARK_G', 'KRAKEN', 'GENERIC']
    inputBinding:
      position: 101
      prefix: --scoring
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: deactivate parallel processing
    inputBinding:
      position: 101
      prefix: --sequential
  - id: summary_behavior
    type:
      - 'null'
      - string
    doc: choice for summary behaviour, and can be one of ['ADD', 'ONLY', 
      'AVOID']
    inputBinding:
      position: 101
      prefix: --summary
  - id: take_out_root
    type:
      - 'null'
      - boolean
    doc: remove counts directly assigned to the "root" level
    inputBinding:
      position: 101
      prefix: --takeoutroot
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for parallel processing; 0 (default) means 
      legacy mode using min(cpu_count, samples)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: output prefix; if not given, it will be inferred from input files; an 
      HTML filename is still accepted for backwards compatibility with legacy 
      --outhtml option
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
