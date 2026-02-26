cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pynteny
  - download
label: pynteny_download
doc: "Download HMM database from NCBI.\n\nTool homepage: http://github.com/robaina/Pynteny"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: force-download database again if already downloaded
    inputBinding:
      position: 101
      prefix: --force
  - id: log_file
    type:
      - 'null'
      - File
    doc: path to log file. Log not written by default.
    inputBinding:
      position: 101
      prefix: --log
  - id: outdir
    type: Directory
    doc: "path to directory where to download HMM database. Note, if database is relocated
      after download, Pynteny won't be able to find it automatically, You can either:
      delete and download again in the new location or manually indicate database
      and meta file location in Pynteny search."
    inputBinding:
      position: 101
      prefix: --outdir
  - id: unpack
    type:
      - 'null'
      - boolean
    doc: unpack originally compressed database files
    inputBinding:
      position: 101
      prefix: --unpack
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
stdout: pynteny_download.out
