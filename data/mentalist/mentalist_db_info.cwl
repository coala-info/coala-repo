cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - db_info
label: mentalist_db_info
doc: "Print information about a MentaLiST k-mer database (MentaLiST version, k-mer size, number of loci, profile). The Julia environment variables let the image compile its package cache in a writable temporary folder (the image has no precompiled cache and its own folder is read-only).\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: db
    type: File
    doc: "MentaLiST kmer database"
    secondaryFiles:
      - pattern: .profile
        required: false
    inputBinding:
      position: 102
      prefix: --db
outputs:
  - id: info
    type: stdout
    doc: "Database information"
stdout: mentalist_db_info.out
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      JULIA_PKGDIR: $(runtime.tmpdir)/julia_pkg
      JULIA_LOAD_PATH: /usr/local/share/julia/site/v0.5
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
