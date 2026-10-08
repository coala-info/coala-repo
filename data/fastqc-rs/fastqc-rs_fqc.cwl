cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqc
label: fastqc-rs_fqc
doc: "A FASTQ quality control tool inspired by fastQC\n\nTool homepage: https://github.com/fxwiegand/fastqc-rs"
inputs:
  - id: fastq
    type: File
    doc: The input FASTQ file to use.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: kmer
    type:
      - 'null'
      - int
    doc: The length k of k-mers for k-mer counting.
    inputBinding:
      position: 101
      prefix: --kmer
  - id: summary_path
    type: string?
    doc: Creates an output file for usage with MultiQC under the given path.
    inputBinding:
      position: 102
      prefix: --summary
outputs:
  - id: stdout
    type: stdout
    doc: JSON report with the quality statistics printed by the tool
  - id: summary
    type:
      - 'null'
      - File
    doc: MultiQC summary file (fastqc_data.txt) written inside the summary directory.
    outputBinding:
      glob: $(inputs.summary_path + '/fastqc_data.txt')
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |
      ${
        if (inputs.summary_path) {
          return [{entryname: inputs.summary_path, entry: {class: 'Directory', basename: inputs.summary_path, listing: []}, writable: true}];
        }
        return [];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqc-rs:0.3.4--hd2a40b3_1
stdout: fastqc-rs_fqc.out
