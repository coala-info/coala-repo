cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastmlst
label: fastmlst
doc: "FastMLST: A multi-core tool for multilocus sequence typing of draft genome assemblies.\n\nTool homepage: https://github.com/EnzoAndree/FastMLST"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 20)
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbose output level choices: [0, 1, 2]"
    inputBinding:
      position: 2
      prefix: --verbose
  - id: separator
    type:
      - 'null'
      - string
    doc: Choose a character to use as a separator (default ",")
    inputBinding:
      position: 3
      prefix: --separator
  - id: scheme
    type:
      - 'null'
      - string
    doc: Set a scheme target (I am not dumb, let me choose a scheme by myself!)
    inputBinding:
      position: 4
      prefix: --scheme
  - id: scheme_list
    type:
      - 'null'
      - boolean
    doc: Show all schemes supported
    inputBinding:
      position: 5
      prefix: --scheme-list
  - id: fastaoutput
    type:
      - 'null'
      - string
    doc: File name of the concatenated alleles output (default "")
    inputBinding:
      position: 6
      prefix: --fastaoutput
  - id: tableoutput
    type:
      - 'null'
      - string
    doc: File name of the MLST table output (default STDOUT)
    inputBinding:
      position: 7
      prefix: --tableoutput
  - id: coverage
    type:
      - 'null'
      - float
    doc: DNA %Cov to report high quality partial allele [?] (default 99%)
    inputBinding:
      position: 8
      prefix: --coverage
  - id: identity
    type:
      - 'null'
      - float
    doc: DNA %Identity of full allelle to consider 'similar' [~] (default 95%)
    inputBinding:
      position: 9
      prefix: --identity
  - id: update_mlst
    type:
      - 'null'
      - boolean
    doc: Perform an update of the PubMLST database
    inputBinding:
      position: 10
      prefix: --update-mlst
  - id: splited_output
    type:
      - 'null'
      - string
    doc: Directory output for splited alleles (default "")
    inputBinding:
      position: 11
      prefix: --splited-output
  - id: fasta2line
    type:
      - 'null'
      - boolean
    doc: The fasta files will be in fasta2line format
    inputBinding:
      position: 12
      prefix: --fasta2line
  - id: longheader
    type:
      - 'null'
      - boolean
    doc: If --longheader is invoked, the header of FASTA file contain a long description
    inputBinding:
      position: 13
      prefix: --longheader
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: If --legacy is invoked, the csv reported contain the gene name and the allele id in the row [adk(1),atpA(4),dxr(7),glyA(1),recA(1),sodA(3),tpi(3)]. This option is only available when the --scheme is defined
    inputBinding:
      position: 14
      prefix: --legacy
  - id: novel
    type:
      - 'null'
      - string
    doc: File name of the novel alleles
    inputBinding:
      position: 15
      prefix: --novel
  - id: db_path
    type:
      - 'null'
      - string
    doc: "Custom directory for MLST database (default: ~/.cache/fastmlst/pubmlst)"
    inputBinding:
      position: 16
      prefix: --db_path
  - id: database_home
    type:
      - 'null'
      - Directory
    doc: Folder used as HOME; it must hold the PubMLST database in .cache/fastmlst/pubmlst (made by --update-mlst). The tool looks for the database there, because --db_path is not used when typing genomes. Without it the tool tries to download the database from PubMLST.
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome assemblies in FASTA format.
    inputBinding:
      position: 100
outputs:
  - id: table_output
    type:
      - 'null'
      - File
    doc: MLST table output file.
    outputBinding:
      glob: $(inputs.tableoutput)
  - id: fasta_output
    type:
      - 'null'
      - File
    doc: Concatenated alleles output file.
    outputBinding:
      glob: $(inputs.fastaoutput)
  - id: novel_output
    type:
      - 'null'
      - File
    doc: Novel alleles output file.
    outputBinding:
      glob: $(inputs.novel)
  - id: splited_output_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the splited alleles.
    outputBinding:
      glob: $(inputs.splited_output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: HOME
        envValue: '$(inputs.database_home ? inputs.database_home.path : runtime.outdir)'
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastmlst:0.0.19--pyhdfd78af_0
stdout: fastmlst.out
