cwlVersion: v1.2
class: CommandLineTool
baseCommand: saccharis
label: saccharis
doc: "SACCHARIS 2 is a tool to analyze CAZyme families.\n\nTool homepage: https://github.com/saccharis/SACCHARIS_2"
inputs:
  - id: cazyme_mode
    type:
      - 'null'
      - string
    doc: 'This is the characterization level of cazymes you wish to query from the
      CAZy database. Allowable modes: characterized structure all_cazymes'
    inputBinding:
      position: 101
      prefix: --cazyme_mode
  - id: domain
    type:
      - 'null'
      - type: array
        items: string
    doc: "This is the domain of the organisms whose cazymes you wish to query from
      the CAZy database. Default mode is all domains. Allowable modes: archaea bacteria
      eukaryota viruses unclassified all You can specify as many of these domain options
      as you wish by separating them with a space. e.g. '-d archaea bacteria' is a
      valid domain argument which will include cazyme sequences from organisms in
      both the archaea and bacteria domains."
    inputBinding:
      position: 101
      prefix: --domain
  - id: explore
    type:
      - 'null'
      - boolean
    doc: This is a boolean flag which enables an exploratory mode to screen the 
      user sequence file for cayme families and then ask the user which of the 
      families in their sequence file to run the pipeline on.Cannot use with 
      --family/-f, --family_category, or --family_file.
    inputBinding:
      position: 101
      prefix: --explore
  - id: family
    type:
      - 'null'
      - string
    doc: This is a single family name. -> eg. "GH43". Cannot use with 
      --family_file, --family_category, or explore
    inputBinding:
      position: 101
      prefix: --family
  - id: family_category
    type:
      - 'null'
      - string
    doc: This accepts the name of a list of families contained in the 
      "family_categories.json" config file. Custom groupings can be added to 
      this file by the user via text editor, provided that you follow the same 
      formatting. The formatting is standard json format as used by the default 
      python json encoder for a dict of lists of strings. Cannot use with 
      --family/-f, --family_file, or explore.
    inputBinding:
      position: 101
      prefix: --family_category
  - id: family_file
    type:
      - 'null'
      - File
    doc: This is a file containing a list of families you would like to run the 
      pipeline on sequentially. Cannot use with --family/-f, --family_category, 
      or explore.
    inputBinding:
      position: 101
      prefix: --family_file
  - id: fragments
    type:
      - 'null'
      - boolean
    doc: This is a boolean value flag that by default is set to False, which 
      means fragments are left out by default. If you would like to include 
      fragment sequences from CAZY, include this flag in your call.
    inputBinding:
      position: 101
      prefix: --fragments
  - id: fresh
    type:
      - 'null'
      - boolean
    doc: This is a boolean value flag that by default is set to False, which 
      means existing data will be reused to speed up analysis. When included, 
      this options forces data to be redownloaded from CAZy and NCBI even if 
      present and all analyses to be performed again with fresh data. Saved data
      from previous runs with the same family, cazyme mode, and domain settings 
      will be deleted and overwritten.
    inputBinding:
      position: 101
      prefix: --fresh
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: You can set a predefined output directory with this flag, either a full
      path or a subfolder of the CWD. Default is <Current Working Directory 
      (CWD)>/output. If you specify an absolute file path the end directory will
      be used. If you specify a relative file path(e.g. just a folder name), it 
      will be a subdirectory of the CWD.
    inputBinding:
      position: 101
      prefix: --directory
  - id: rename_user
    type:
      - 'null'
      - boolean
    doc: This is a boolean value flag that by default is set to False, which 
      means the program will not automatically rename user sequence headers to 
      conform with the user sequence ID format. When this argument is included, 
      this will occur automatically, without prompting. When not included, the 
      program will prompt the user if they wish to prepend their FASTA headers 
      with the correct ID format.
    inputBinding:
      position: 101
      prefix: --rename_user
  - id: render
    type:
      - 'null'
      - boolean
    doc: This is a boolean flag that by default is set to False which when true 
      automatically tries to render phylogenetic trees using the rsaccharis R 
      library. The rsaccharis package must be installed and the rscript command 
      available on the PATH variable for this function to work, see 
      https://github.com/saccharis/rsaccharis for details.
    inputBinding:
      position: 101
      prefix: --render
  - id: seqfile
    type:
      - 'null'
      - type: array
        items: File
    doc: If you would like to add your own sequences to this run - this is your 
      chance. Sequences MUST be in FASTA FORMAT - if they are not the script 
      will fail. Make sure to include path with filename. Multiple FASTA files 
      are supported and will be merged together, with metadata of source files 
      saved for future use.
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: skip_prune
    type:
      - 'null'
      - boolean
    doc: This is a boolean value flag that by default is set to False, which 
      means the sequences will be pruned to CAZyme boundaries. If you wouldlike 
      to skip the pruning step and use full genbank entries for alignment and 
      tree building, include this flag in your call.
    inputBinding:
      position: 101
      prefix: --skip_prune
  - id: skip_user_ask
    type:
      - 'null'
      - boolean
    doc: This is a boolean flag that by default is set to False which when true 
      skips querying the user for input. If a question would be posed to the 
      user, the question will be skipped and a reasonable default action will 
      occur if possible or the program will exit if necessary. An example is 
      that normally when no NCBI API key is detected the program prompts the 
      user for their NCBI API key. If this setting is true, the program instead 
      continues without an API key, slowing down queries but otherwise 
      functioning. It is recommended to use this option when running SACCHARIS 
      on a cluster or in automated fashion to prevent failed runs in 
      environments where querying the user is not possible.
    inputBinding:
      position: 101
      prefix: --skip_user_ask
  - id: subfamily
    type:
      - 'null'
      - string
    doc: This is a subfamily number, which cazy represents as a number appended 
      to the family, e.g. "--family GH43 --subfamily 1" accesses the family 
      which the CAZy database identifies as GH43_1. Optional argument, can only 
      use with --family, not --family_file, --family_category, or --explore.
    inputBinding:
      position: 101
      prefix: --subfamily
  - id: threads
    type:
      - 'null'
      - int
    doc: Some tools(e.g. RAxML) allow the use of multi-core processing. Set a 
      number in here from 1 to <max_cores>. The default is set at 3/4 of the 
      number of logical cores reported by your operating system. This is to 
      prevent lockups if other programs are running.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - string
    doc: Choice of tree building program. FastTree is the default because it is 
      substantially faster than RAxML. RAxML may take days or even weeks to 
      build large trees, but sometimes builds slightly higher quality trees than
      FastTree. Both RAxML and RAxML-NG are supported.
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: This is a boolean value flag that by default is set to False, which 
      means verbose output is hidden. If you would like verbose output 
      (particularly useful to explore when certain sequences from CAZy are not 
      being included in an analysis), include this flag in your call.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saccharis:2.0.5--pyh7e72e81_0
stdout: saccharis.out
