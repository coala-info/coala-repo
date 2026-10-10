cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - build
label: metabuli_build
doc: "Build a Metabuli database from a list of FASTA files.\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{entryname: inputs.database_directory, entry: {class: 'Directory', listing: []}, writable: true}];
        (inputs.fasta_files || []).forEach(function (f) { l.push({entryname: f.basename, entry: f}); });
        return l;
      }
inputs:
  - id: database_directory
    type: string
    doc: "Database directory to create (a taxonomy folder inside it is used when taxonomy_path is not given)"
    inputBinding:
      position: 1
  - id: fasta_list
    type: File
    doc: "FASTA list: text file with one FASTA file path per line"
    inputBinding:
      position: 2
  - id: accession2taxid
    type: File
    doc: "Accession to taxonomy ID mapping (NCBI format)"
    inputBinding:
      position: 3
  - id: fasta_files
    type:
      type: array
      items: File
    doc: "FASTA files named in the FASTA list, staged in the working directory so the paths in the list resolve"
  - id: taxonomy_path
    type: 
      - 'null'
      - Directory
    doc: "Directory where the taxonomy dump files are stored"
    inputBinding:
      position: 100
      prefix: --taxonomy-path
  - id: split_num
    type: 
      - 'null'
      - int
    doc: "A database is divided to N splits (offsets); unnecessary splits are skipped during classification [4096]"
    inputBinding:
      position: 11
      prefix: --split-num
  - id: accession_level
    type: 
      - 'null'
      - int
    doc: "Build or search a database for accession-level classification [0]"
    inputBinding:
      position: 12
      prefix: --accession-level
  - id: db_name
    type: 
      - 'null'
      - string
    doc: "Name of the database"
    inputBinding:
      position: 13
      prefix: --db-name
  - id: db_date
    type: 
      - 'null'
      - string
    doc: "Date of the database creation"
    inputBinding:
      position: 14
      prefix: --db-date
  - id: cds_info
    type: 
      - 'null'
      - File
    doc: "List of CDS files"
    inputBinding:
      position: 15
      prefix: --cds-info
  - id: max_ram
    type: 
      - 'null'
      - int
    doc: "RAM usage in GiB [128]"
    inputBinding:
      position: 100
      prefix: --max-ram
  - id: make_library
    type: 
      - 'null'
      - int
    doc: "Make library [0]"
    inputBinding:
      position: 17
      prefix: --make-library
  - id: gtdb
    type: 
      - 'null'
      - int
    doc: "GTDB-based database creation [0]"
    inputBinding:
      position: 18
      prefix: --gtdb
  - id: validate_input
    type: 
      - 'null'
      - int
    doc: "Validate format of input FASTA/FASTQ file(s) [0]"
    inputBinding:
      position: 19
      prefix: --validate-input
  - id: validate_db
    type: 
      - 'null'
      - int
    doc: "Validate the database after the build [0]"
    inputBinding:
      position: 20
      prefix: --validate-db
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Number of CPU-cores used (all by default) [20]"
    inputBinding:
      position: 100
      prefix: --threads
outputs:
  - id: database
    type: Directory
    doc: "The built database directory"
    outputBinding:
      glob: $(inputs.database_directory)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_build.out
