cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam2
  - reconcile
label: leviosam2_reconcile
doc: "Reconcile alignments to select the one with higher confidence.\n\nTool homepage: https://github.com/milkschen/leviosam2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: SAM/BAM files to reconcile (one per label, in the same order as labels).
  - id: labels
    type:
      type: array
      items: string
    doc: Labels of the input files (one per file, in the same order as input_files); each is passed as -s label:file.
  - id: output_file
    type: string
    doc: Path to the output SAM/BAM file
    inputBinding:
      position: 102
      prefix: -o
  - id: perform_merging_in_pairs
    type:
      - 'null'
      - boolean
    doc: Set to perform merging in pairs [false]
    inputBinding:
      position: 101
      prefix: -m
  - id: conservative_mapq
    type:
      - 'null'
      - boolean
    doc: Set to use conservative MAPQ [false]
    inputBinding:
      position: 101
      prefix: -c
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed used by the program [0]
    inputBinding:
      position: 101
      prefix: -r
arguments:
  - position: 100
    valueFrom: |
      ${
        var out = [];
        for (var i = 0; i < inputs.input_files.length; i++) {
          out.push("-s");
          out.push(inputs.labels[i] + ":" + inputs.input_files[i].path);
        }
        return out;
      }
outputs:
  - id: output
    type: File
    doc: Path to the output SAM/BAM file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
