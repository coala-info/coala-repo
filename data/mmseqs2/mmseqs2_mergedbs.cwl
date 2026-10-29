cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - mergedbs
label: mmseqs2_mergedbs
doc: 'Merge entries from multiple DBs.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: input_db
    type: Directory
    doc: Database that gives the keys of the merged database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.input_db_name)
  - id: input_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: merge_dbs
    type:
      type: array
      items: Directory
    doc: Databases whose entries are merged
    inputBinding:
      position: 3
      valueFrom: ${ var r = []; for (var i = 0; i < self.length; i++) { r.push(self[i].path
        + "/" + inputs.merge_dbs_names[i]); } return r; }
  - id: merge_dbs_names
    type:
      type: array
      items: string
    doc: Database names inside each directory of merge_dbs, in the same order
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: prefixes
    type:
      - 'null'
      - string
    doc: Comma separated list of prefixes for each entry
    inputBinding:
      position: 104
      prefix: --prefixes
  - id: merge_stop_empty
    type:
      - 'null'
      - int
    doc: Don't continue merging entries after an empty entry (0 or 1)
    inputBinding:
      position: 104
      prefix: --merge-stop-empty
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the merged database
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for l in out_db/*; do if [ -L "$l" ]; then t=`readlink -f "$l"`; rm "$l";
      cp -r "$t" "$l"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
