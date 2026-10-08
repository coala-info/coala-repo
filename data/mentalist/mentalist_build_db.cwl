cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - build_db
label: mentalist_build_db
doc: "Build a MentaLiST k-mer database from the FASTA files of an MLST scheme (one FASTA file per locus). The FASTA files are copied into db_dir/scheme_dir so that the output folder is a complete database for 'mentalist call'. The Julia environment variables let the image compile its package cache in a writable temporary folder (the image has no precompiled cache and its own folder is read-only).\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
arguments:
  - prefix: --db
    valueFrom: $(inputs.db_dir)/$(inputs.db_name)
    position: 101
  - prefix: --fasta_files
    valueFrom: '${ return inputs.fasta_files.map(function(f){ return inputs.db_dir + "/" + inputs.scheme_dir + "/" + f.basename; }); }'
    position: 102
inputs:
  - id: fasta_files
    type: File[]
    doc: "Fasta files with the MLST scheme (one file per locus)"
  - id: k
    type: int
    doc: "Kmer size"
    inputBinding:
      position: 102
      prefix: -k
  - id: profile
    type:
      - 'null'
      - File
    doc: "Profile file for known genotypes."
    inputBinding:
      position: 102
      prefix: --profile
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads used in parallel. (default: 2)"
    inputBinding:
      position: 102
      prefix: --threads
  - id: db_dir
    type: string
    default: "mentalist_db"
    doc: "Name of the output database folder; it holds the k-mer database file and the folder of scheme FASTA files that 'mentalist call' reads"
  - id: db_name
    type: string
    default: "mlst.db"
    doc: "File name of the k-mer database inside db_dir"
  - id: scheme_dir
    type: string
    default: "scheme"
    doc: "Name of the folder (inside db_dir) for the scheme FASTA files"
outputs:
  - id: database_dir
    type: Directory
    doc: "Database folder with the k-mer database, its profile and the scheme FASTA files"
    outputBinding:
      glob: $(inputs.db_dir)
  - id: database
    type: File
    doc: "k-mer database file"
    outputBinding:
      glob: $(inputs.db_dir)/$(inputs.db_name)
    secondaryFiles:
      - pattern: .profile
        required: false
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      JULIA_PKGDIR: $(runtime.tmpdir)/julia_pkg
      JULIA_LOAD_PATH: /usr/local/share/julia/site/v0.5
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.db_dir)
        writable: true
        entry: '${ return {"class": "Directory", "basename": inputs.db_dir, "listing": [{"class": "Directory", "basename": inputs.scheme_dir, "listing": inputs.fasta_files}]}; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
