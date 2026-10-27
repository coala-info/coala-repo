cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - matchcluster
label: vmatch_matchcluster
doc: "Cluster the matches of a Vmatch match file.

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.index_files ? inputs.index_files : [])'
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
    dockerOutputDirectory: /vmatch_work
inputs:
  - id: matchfile
    type: File
    doc: "Match file written by vmatch (it names the index it was computed with)"
    inputBinding:
      position: 200
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Index files written by mkvtree (staged in the working directory)"
  - id: erate
    type:
      - 'null'
      - float
    doc: "specify maximum error rate in range [0,100] for similarity clustering"
    inputBinding:
      position: 101
      prefix: -erate
  - id: gapsize
    type:
      - 'null'
      - int
    doc: "specify maximum gap size for gap clustering"
    inputBinding:
      position: 101
      prefix: -gapsize
  - id: overlap
    type:
      - 'null'
      - int
    doc: "specify minimum percentage of overlap for overlap clustering"
    inputBinding:
      position: 101
      prefix: -overlap
  - id: outprefix
    type: string
    doc: "specify prefix of files to output clusters (mandatory)"
    inputBinding:
      position: 101
      prefix: -outprefix
outputs:
  - id: cluster_files
    type:
      type: array
      items: File
    doc: Cluster files written with the given prefix
    outputBinding:
      glob: $(inputs.outprefix)*
  - id: stdout
    type: stdout
    doc: Standard output
stdout: vmatch_matchcluster.out
