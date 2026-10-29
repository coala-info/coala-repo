cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - mergeclusters
label: mmseqs2_mergeclusters
doc: 'Merge multiple cascaded clustering steps.


  By Maria Hauser & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Input sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output cluster database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: cluster_dbs
    type:
      type: array
      items: Directory
    doc: Cluster databases of the cascaded clustering steps, first step first
    inputBinding:
      position: 3
      valueFrom: ${ var r = []; for (var i = 0; i < self.length; i++) { r.push(self[i].path
        + "/" + inputs.cluster_dbs_names[i]); } return r; }
  - id: cluster_dbs_names
    type:
      type: array
      items: string
    doc: Database names inside each directory of cluster_dbs, in the same order
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
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
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the merged cluster database
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
