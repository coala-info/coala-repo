cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - rmdup
label: sga_rmdup
doc: 'Remove duplicate reads from the data set.


  Tool homepage: https://github.com/jts/sga'
inputs:
  - id: readfile
    type: File
    doc: Input read file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
    secondaryFiles:
      - ^.bwt
      - ^.rbwt
      - ^.sai
      - ^.rsai
  - id: error_rate
    type:
      - 'null'
      - float
    doc: the maximum error rate allowed to consider two sequences identical
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: prefix
    type:
      - 'null'
      - string
    doc: use PREFIX instead of the prefix of the reads filename for the input/output files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: sample the symbol counts every N symbols in the FM-index. Higher values use significantly less memory at the cost of higher runtime. This value must be a power of 2
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: threads
    type:
      - 'null'
      - int
    doc: use N threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: 'write the output to FILE (default: READFILE.rmdup.fa)'
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: output_file
    type: File
    doc: Reads with duplicates removed.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: duplicates
    type:
      - 'null'
      - File
    doc: Duplicate reads that were removed.
    outputBinding:
      glob: $(inputs.output_file_path.replace(/\.[^.]*$/, "")).dups.fa
  - id: bwt
    type:
      - 'null'
      - File
    doc: Forward BWT of the output reads (rebuilt by the tool).
    outputBinding:
      glob: $(inputs.output_file_path.replace(/\.[^.]*$/, "")).bwt
  - id: rbwt
    type:
      - 'null'
      - File
    doc: Reverse BWT of the output reads.
    outputBinding:
      glob: $(inputs.output_file_path.replace(/\.[^.]*$/, "")).rbwt
  - id: sai
    type:
      - 'null'
      - File
    doc: Sampled suffix array of the output reads.
    outputBinding:
      glob: $(inputs.output_file_path.replace(/\.[^.]*$/, "")).sai
  - id: rsai
    type:
      - 'null'
      - File
    doc: Reverse sampled suffix array of the output reads.
    outputBinding:
      glob: $(inputs.output_file_path.replace(/\.[^.]*$/, "")).rsai
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.readfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
