cwlVersion: v1.2
class: CommandLineTool
baseCommand: busco
label: busco
doc: Benchmarking Universal Single-Copy Ortholog assessment tool
inputs:
  - id: in
    type:
      - 'null'
      - File
    doc: Input sequence file in FASTA format. Can be an assembled genome or 
      transcriptome (DNA), or protein sequences from an annotated gene set. Also
      possible to use a path to a directory containing multiple input files.
    inputBinding:
      position: 101
      prefix: --in
  - id: out
    type:
      - 'null'
      - string
    doc: Give your analysis run a recognisable short name. Output folders and 
      files will be labelled with this name. The path to the output folder is 
      set with --out_path.
    inputBinding:
      position: 101
      prefix: --out
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Specify which BUSCO analysis mode to run. Valid modes: geno or genome, tran
      or transcriptome, prot or proteins.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: lineage_dataset
    type:
      - 'null'
      - string
    doc: Specify the name of the BUSCO lineage to be used.
    inputBinding:
      position: 101
      prefix: --lineage_dataset
  - id: augustus
    type:
      - 'null'
      - boolean
    doc: Use augustus gene predictor for eukaryote runs
    inputBinding:
      position: 101
      prefix: --augustus
  - id: augustus_parameters
    type:
      - 'null'
      - string
    doc: Pass additional arguments to Augustus. All arguments should be 
      contained within a single string with no white space, with each argument 
      separated by a comma.
    inputBinding:
      position: 101
      prefix: --augustus_parameters
  - id: augustus_species
    type:
      - 'null'
      - string
    doc: Specify a species for Augustus training.
    inputBinding:
      position: 101
      prefix: --augustus_species
  - id: auto_lineage
    type:
      - 'null'
      - boolean
    doc: Run auto-lineage to find optimum lineage path
    inputBinding:
      position: 101
      prefix: --auto-lineage
  - id: auto_lineage_euk
    type:
      - 'null'
      - boolean
    doc: Run auto-placement just on eukaryote tree to find optimum lineage path
    inputBinding:
      position: 101
      prefix: --auto-lineage-euk
  - id: auto_lineage_prok
    type:
      - 'null'
      - boolean
    doc: Run auto-lineage just on non-eukaryote trees to find optimum lineage 
      path
    inputBinding:
      position: 101
      prefix: --auto-lineage-prok
  - id: cpu
    type:
      - 'null'
      - int
    doc: Specify the number (N=integer) of threads/cores to use.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: config
    type:
      - 'null'
      - File
    doc: Provide a config file
    inputBinding:
      position: 101
      prefix: --config
  - id: contig_break
    type:
      - 'null'
      - int
    doc: Number of contiguous Ns to signify a break between contigs. Default is 
      n=10.
    inputBinding:
      position: 101
      prefix: --contig_break
  - id: datasets_version
    type:
      - 'null'
      - string
    doc: Specify the version of BUSCO datasets, e.g. odb10, odb12 (default 
      odb12)
    inputBinding:
      position: 101
      prefix: --datasets_version
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: Download dataset. Possible values are a specific dataset name, "all", 
      "prokaryota", "eukaryota", or "virus". If used together with other command
      line arguments, make sure to place this last.
    inputBinding:
      position: 101
      prefix: --download
  - id: download_base_url
    type:
      - 'null'
      - string
    doc: Set the url to the remote BUSCO dataset location
    inputBinding:
      position: 101
      prefix: --download_base_url
  - id: download_path
    type:
      - 'null'
      - Directory
    doc: Specify local filepath for storing BUSCO dataset downloads
    inputBinding:
      position: 101
      prefix: --download_path
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'E-value cutoff for BLAST searches. Allowed formats, 0.001 or 1e-03 (Default:
      1e-03)'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force rewriting of existing files. Must be used when output files with 
      the provided name already exist.
    inputBinding:
      position: 101
      prefix: --force
  - id: limit
    type:
      - 'null'
      - int
    doc: 'How many candidate regions (contig or transcript) to consider per BUSCO
      (default: 3)'
    inputBinding:
      position: 101
      prefix: --limit
  - id: list_datasets
    type:
      - 'null'
      - string
    doc: Print the list of available BUSCO datasets
    inputBinding:
      position: 101
      prefix: --list-datasets
  - id: long
    type:
      - 'null'
      - boolean
    doc: 'Optimization Augustus self-training mode (Default: Off); adds considerably
      to the run time, but can improve results for some non-model organisms'
    inputBinding:
      position: 101
      prefix: --long
  - id: metaeuk
    type:
      - 'null'
      - boolean
    doc: Use Metaeuk gene predictor
    inputBinding:
      position: 101
      prefix: --metaeuk
  - id: metaeuk_parameters
    type:
      - 'null'
      - string
    doc: Pass additional arguments to Metaeuk for the first run. All arguments 
      should be contained within a single string with no white space, with each 
      argument separated by a comma.
    inputBinding:
      position: 101
      prefix: --metaeuk_parameters
  - id: metaeuk_rerun_parameters
    type:
      - 'null'
      - string
    doc: Pass additional arguments to Metaeuk for the second run. All arguments 
      should be contained within a single string with no white space, with each 
      argument separated by a comma.
    inputBinding:
      position: 101
      prefix: --metaeuk_rerun_parameters
  - id: miniprot
    type:
      - 'null'
      - boolean
    doc: Use Miniprot gene predictor
    inputBinding:
      position: 101
      prefix: --miniprot
  - id: skip_bbtools
    type:
      - 'null'
      - boolean
    doc: Skip BBTools for assembly statistics
    inputBinding:
      position: 101
      prefix: --skip_bbtools
  - id: offline
    type:
      - 'null'
      - boolean
    doc: To indicate that BUSCO cannot attempt to download files
    inputBinding:
      position: 101
      prefix: --offline
  - id: opt_out_run_stats
    type:
      - 'null'
      - boolean
    doc: Opt out of data collection. Information on the data collected is 
      available in the user guide.
    inputBinding:
      position: 101
      prefix: --opt-out-run-stats
  - id: out_path
    type:
      - 'null'
      - string
    doc: Optional location for results folder, excluding results folder name. 
      Default is current working directory.
    inputBinding:
      position: 101
      prefix: --out_path
  - id: plot
    type:
      - 'null'
      - Directory
    doc: Generate a BUSCO summary plot for all short summary files in the given 
      working directory.
    inputBinding:
      position: 101
      prefix: --plot
  - id: plot_percentages
    type:
      - 'null'
      - boolean
    doc: Plot the percentages of BUSCOs instead of the number of BUSCOs. To be 
      used as an option with --plot.
    inputBinding:
      position: 101
      prefix: --plot_percentages
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable the info logs, displays only errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Continue a run that had already partially completed.
    inputBinding:
      position: 101
      prefix: --restart
  - id: scaffold_composition
    type:
      - 'null'
      - boolean
    doc: Writes ACGTN content per scaffold to a file scaffold_composition.txt
    inputBinding:
      position: 101
      prefix: --scaffold_composition
  - id: tar
    type:
      - 'null'
      - boolean
    doc: Compress some subdirectories with many files to save space
    inputBinding:
      position: 101
      prefix: --tar
outputs:
  - id: output_out
    type:
      - 'null'
      - File[]
    doc: Give your analysis run a recognisable short name. Output folders and 
      files will be labelled with this name. The path to the output folder is 
      set with --out_path.
    outputBinding:
      glob: $(inputs.out)*
  - id: output_out_path
    type:
      - 'null'
      - Directory
    doc: Optional location for results folder, excluding results folder name. 
      Default is current working directory.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/busco:6.0.0--pyhdfd78af_2
s:url: https://busco.ezlab.org
$namespaces:
  s: https://schema.org/
