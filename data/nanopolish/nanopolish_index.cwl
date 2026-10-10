cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - index
label: nanopolish_index
doc: "Build an index mapping from basecalled reads to the signals measured by the
  sequencer\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: reads_fastq
    type: File
    doc: fastq file containing basecalled reads
    inputBinding:
      position: 1
  - id: raw_ont_signal_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: path to the directory containing the raw ONT signal files. The
      directories are staged in the working directory and given to the tool by
      name, so the index stores relative fast5 paths (later nanopolish steps
      need the same directory staged under the same name).
  - id: sequencing_summary
    type:
      - 'null'
      - File
    doc: the sequencing summary file from albacore, providing this option will 
      make indexing much faster
    inputBinding:
      position: 102
      prefix: --sequencing-summary
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: slow5 file
    inputBinding:
      position: 102
      prefix: --slow5
  - id: summary_fofn
    type:
      - 'null'
      - File
    doc: file containing the paths to the sequencing summary files (one per 
      line)
    inputBinding:
      position: 102
      prefix: --summary-fofn
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
arguments:
  - position: 102
    valueFrom: |
      ${
        var a = [];
        (inputs.raw_ont_signal_directory || []).forEach(function (d) {
          a.push('--directory');
          a.push(d.basename);
        });
        return a;
      }
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written beside the reads file (<reads>.index,
      <reads>.index.fai, <reads>.index.gzi, <reads>.index.readdb)
    outputBinding:
      glob: $(inputs.reads_fastq.basename).index*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reads_fastq)
        writable: true
      - entry: '$(inputs.raw_ont_signal_directory ? inputs.raw_ont_signal_directory : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_index.out
