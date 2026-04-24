cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - motifscan
  - genome
label: motifscan_genome
doc: "Genome assembly commands.\nThis subcommand controls the genome assemblies used
  by MotifScan. MotifScan requires a sequences FASTA file and a gene annotation file
  (if available) for each genome assembly, users can either download them from a remote
  database or install directly with local prepared files.\n\nTool homepage: https://github.com/shao-lab/MotifScan"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Local gene annotation (refGene.txt) file.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Clean the download directory after installation.
    inputBinding:
      position: 101
      prefix: --clean
  - id: database
    type:
      - 'null'
      - string
    doc: Which remote database is used to list/install/search genome assemblies.
    inputBinding:
      position: 101
      prefix: --database
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Local genome sequences file(s) in FASTA format.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: install
    type:
      - 'null'
      - boolean
    doc: Install a new genome assembly.
    inputBinding:
      position: 101
      prefix: --install
  - id: list
    type:
      - 'null'
      - boolean
    doc: Display installed genome assemblies.
    inputBinding:
      position: 101
      prefix: --list
  - id: list_remote
    type:
      - 'null'
      - boolean
    doc: Display available remote genome assemblies.
    inputBinding:
      position: 101
      prefix: --list-remote
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the genome assembly to be installed.
    inputBinding:
      position: 101
      prefix: --name
  - id: remote_genome
    type:
      - 'null'
      - string
    doc: Download required data files from a remote assembly.
    inputBinding:
      position: 101
      prefix: --remote
  - id: search_keyword
    type:
      - 'null'
      - string
    doc: Search for genome assemblies in a remote database.
    inputBinding:
      position: 101
      prefix: --search
  - id: uninstall_name
    type:
      - 'null'
      - string
    doc: Uninstall a genome assembly.
    inputBinding:
      position: 101
      prefix: --uninstall
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose log messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Write to a given directory instead of the default directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
