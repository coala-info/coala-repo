cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - list_pubmlst
label: mentalist_list_pubmlst
doc: "List the MLST schemes available on PubMLST (scheme ID and species). The Julia environment variables let the image compile its package cache in a writable temporary folder (the image has no precompiled cache and its own folder is read-only).\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Only list schemes where the species name starts with this prefix."
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: schemes
    type: stdout
    doc: "Table of scheme IDs and species"
stdout: mentalist_list_pubmlst.out
requirements:
  - class: EnvVarRequirement
    envDef:
      JULIA_PKGDIR: $(runtime.tmpdir)/julia_pkg
      JULIA_LOAD_PATH: /usr/local/share/julia/site/v0.5
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
