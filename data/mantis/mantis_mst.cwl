cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - mst
label: mantis_mst
doc: 'Re-encode the color classes of a mantis index as a minimum spanning tree (MST);
  the index directory is updated.


  Tool homepage: https://github.com/splatlab/mantis'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index_prefix)
        writable: true
inputs:
  - id: index_prefix
    type: Directory
    doc: The directory where the index is stored; staged writable and updated
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: $(self.basename)/
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 2
      prefix: -t
  - id: keep_rrr
    type:
      - 'null'
      - boolean
    doc: Keep the previous color class RRR representation (use this or delete_rrr).
    inputBinding:
      position: 3
      prefix: -k
  - id: delete_rrr
    type:
      - 'null'
      - boolean
    doc: Remove the previous color class RRR representation (use this or keep_rrr).
    inputBinding:
      position: 3
      prefix: -d
outputs:
  - id: index_dir
    type: Directory
    doc: Updated mantis index directory
    outputBinding:
      glob: $(inputs.index_prefix.basename)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_mst.out
