cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster_makedb
label: cblaster_makedb
doc: "Generate local databases from genome files\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: paths
    type:
      type: array
      items: File
    doc: Path/s to genome files to use when building local databases (can be 
      gzipped). Alternatively, path to one .txt file with one genome file per 
      line.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - int
    doc: Number of genome files to parse before saving them in the local 
      database. Useful when encountering memory issues with large/many files. By
      default, all genome files will be parsed at once.
    inputBinding:
      position: 102
      prefix: --batch
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use when parsing genome files. By default, all 
      available cores will be used.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite pre-existing files, if any
    inputBinding:
      position: 102
      prefix: --force
  - id: name
    type: string
    doc: Name to use when building sqlite3/diamond databases (with extensions 
      .sqlite3 and .dmnd, respectively)
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
stdout: cblaster_makedb.out
