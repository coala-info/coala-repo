cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimmomatic
label: trimmomatic
doc: "A flexible read trimming tool for Illumina NGS data.\n\nPE mode takes input_r1 and
  input_r2 and writes output_r1, output_r1_unpaired, output_r2 and output_r2_unpaired.
  SE mode takes input_r1 and writes output_r1. For ILLUMINACLIP, give adapter_file, or
  name one of the adapter files bundled with Trimmomatic (NexteraPE-PE.fa, TruSeq2-PE.fa,
  TruSeq2-SE.fa, TruSeq3-PE.fa, TruSeq3-PE-2.fa, TruSeq3-PE-2-GGGGG.fa, TruSeq3-SE.fa);
  the path in the step is replaced accordingly.\n\nTool homepage: https://www.plabipd.de/trimmomatic_main.html"
inputs:
  - id: mode
    type: string
    doc: 'Trimming mode: PE (paired end) or SE (single end)'
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 2
      prefix: -threads
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: Use Phred-33 quality scores
    inputBinding:
      position: 2
      prefix: -phred33
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Use Phred-64 quality scores
    inputBinding:
      position: 2
      prefix: -phred64
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error messages
    inputBinding:
      position: 2
      prefix: -quiet
  - id: validate_pairs
    type:
      - 'null'
      - boolean
    doc: Validate that the input files contain matching pairs (PE only)
    inputBinding:
      position: 2
      prefix: -validatePairs
  - id: summary_path
    type:
      - 'null'
      - string
    doc: Name of the statistics summary file to write; any directory part is dropped
    inputBinding:
      position: 3
      prefix: -summary
      valueFrom: $(self.split('/').pop())
  - id: trimlog_path
    type:
      - 'null'
      - string
    doc: Name of the per-read trimming log to write; any directory part is dropped
    inputBinding:
      position: 3
      prefix: -trimlog
      valueFrom: $(self.split('/').pop())
  - id: adapter_file
    type:
      - 'null'
      - File
    doc: Adapter FASTA for ILLUMINACLIP; when given, it replaces the file named in the
      ILLUMINACLIP step
  - id: input_r1
    type: File
    doc: 'Input reads: R1 in PE mode, the only input in SE mode'
    inputBinding:
      position: 10
  - id: input_r2
    type:
      - 'null'
      - File
    doc: Input R2 reads (PE only)
    inputBinding:
      position: 11
  - id: output_r1
    type: string
    doc: 'Name of the output file: R1 paired output in PE mode, the only output in SE
      mode; any directory part is dropped'
    inputBinding:
      position: 12
      valueFrom: $(self.split('/').pop())
  - id: output_r1_unpaired
    type:
      - 'null'
      - string
    doc: Name of the R1 unpaired output (PE only); any directory part is dropped
    inputBinding:
      position: 13
      valueFrom: $(self.split('/').pop())
  - id: output_r2
    type:
      - 'null'
      - string
    doc: Name of the R2 paired output (PE only); any directory part is dropped
    inputBinding:
      position: 14
      valueFrom: $(self.split('/').pop())
  - id: output_r2_unpaired
    type:
      - 'null'
      - string
    doc: Name of the R2 unpaired output (PE only); any directory part is dropped
    inputBinding:
      position: 15
      valueFrom: $(self.split('/').pop())
  - id: steps
    type:
      type: array
      items: string
    doc: Trimming steps in order, for example ILLUMINACLIP:TruSeq3-PE.fa:2:30:10,
      SLIDINGWINDOW:4:15, LEADING:3, TRAILING:3, MINLEN:36
    inputBinding:
      position: 20
      valueFrom: |-
        ${
          var bundled = ['NexteraPE-PE.fa', 'TruSeq2-PE.fa', 'TruSeq2-SE.fa', 'TruSeq3-PE.fa',
                         'TruSeq3-PE-2.fa', 'TruSeq3-PE-2-GGGGG.fa', 'TruSeq3-SE.fa'];
          return self.map(function (step) {
            var m = /^ILLUMINACLIP:([^:]+):(.*)$/.exec(step);
            if (!m) { return step; }
            var file = m[1];
            if (inputs.adapter_file) {
              file = inputs.adapter_file.path;
            } else {
              var name = file.split('/').pop();
              if (bundled.indexOf(name) >= 0) { file = '/usr/local/share/trimmomatic/adapters/' + name; }
            }
            return 'ILLUMINACLIP:' + file + ':' + m[2];
          });
        }
outputs:
  - id: out_r1
    type: File
    doc: 'Trimmed reads: R1 paired in PE mode, the only output in SE mode'
    outputBinding:
      glob: $(inputs.output_r1.split('/').pop())
  - id: out_r1_unpaired
    type:
      - 'null'
      - File
    doc: R1 reads whose mate was dropped (PE only)
    outputBinding:
      glob: "$(inputs.output_r1_unpaired ? inputs.output_r1_unpaired.split('/').pop() : [])"
  - id: out_r2
    type:
      - 'null'
      - File
    doc: Trimmed R2 paired reads (PE only)
    outputBinding:
      glob: "$(inputs.output_r2 ? inputs.output_r2.split('/').pop() : [])"
  - id: out_r2_unpaired
    type:
      - 'null'
      - File
    doc: R2 reads whose mate was dropped (PE only)
    outputBinding:
      glob: "$(inputs.output_r2_unpaired ? inputs.output_r2_unpaired.split('/').pop() : [])"
  - id: summary
    type:
      - 'null'
      - File
    doc: Statistics summary
    outputBinding:
      glob: "$(inputs.summary_path ? inputs.summary_path.split('/').pop() : [])"
  - id: trimlog
    type:
      - 'null'
      - File
    doc: Per-read trimming log
    outputBinding:
      glob: "$(inputs.trimlog_path ? inputs.trimlog_path.split('/').pop() : [])"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimmomatic:0.40--hdfd78af_0
