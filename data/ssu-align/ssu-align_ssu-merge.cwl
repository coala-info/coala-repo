cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-merge
label: ssu-align_ssu-merge
doc: "Merge SSU rRNA alignments: the results of the parallel jobs made by ssu-prep, or a list of alignments to the same model.

Tool homepage: http://eddylab.org/software/ssu-align/"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force; allow file clobbering"
    inputBinding:
      position: 101
      prefix: -f
  - id: rfonly
    type:
      - 'null'
      - boolean
    doc: "when merging alignments, only keep consensus (non-gap RF) columns"
    inputBinding:
      position: 101
      prefix: --rfonly
  - id: keep
    type:
      - 'null'
      - boolean
    doc: "don't remove original files after they have been merged"
    inputBinding:
      position: 101
      prefix: --keep
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: "input alignments are interleaved Stockholm format (not 1 line/seq); only works with --list"
    inputBinding:
      position: 101
      prefix: -i
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "output alignments as DNA, default is RNA (even if input is DNA); only works with --list"
    inputBinding:
      position: 101
      prefix: --dna
  - id: list_file
    type:
      - 'null'
      - File
    doc: "file listing n>1 alignments to merge (--list)"
    inputBinding:
      position: 102
      prefix: --list
      valueFrom: '$(self.basename)'
  - id: list_alignments
    type:
      - 'null'
      - File[]
    doc: "alignment files named in the list file; they are staged in the working directory so the names resolve"
  - id: merged_name
    type:
      - 'null'
      - string
    doc: "name for merged alignment (with --list)"
    inputBinding:
      position: 201
  - id: prep_dir
    type:
      - 'null'
      - Directory
    doc: "output dir created by ssu-prep (merges the results of its jobs)"
    inputBinding:
      position: 202
      valueFrom: '$(self.basename)'
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: ssu-prep directory with the merged results
    outputBinding:
      glob: '${ return inputs.prep_dir ? inputs.prep_dir.basename : []; }'
  - id: merged_files
    type:
      type: array
      items: File
    doc: Merged alignment and log files (with --list)
    outputBinding:
      glob: '${ return inputs.merged_name ? [inputs.merged_name, inputs.merged_name + ".ssu-merge.log", inputs.merged_name + ".ssu-merge.sum"] : []; }'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.prep_dir) { l.push({"entry": inputs.prep_dir, "writable": true}); }
        if (inputs.list_file) { l.push({"entry": inputs.list_file, "writable": true}); }
        if (inputs.list_alignments) { for (var i = 0; i < inputs.list_alignments.length; i++) { l.push({"entry": inputs.list_alignments[i], "writable": true}); } }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-merge.out
