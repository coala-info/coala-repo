cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - random-sample
label: rdp-readseq_random-sample
doc: "Randomly select a subset or subregion of sequences from each sample file (ResampleSeqFile).

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: infile
    type:
      - File
      - Directory
    doc: "Input sequence file or a directory of sample files"
    inputBinding:
      position: 3
  - id: outdir
    type: string
    doc: "Output directory (created by the tool)"
    inputBinding:
      position: 4
  - id: num_selection
    type:
      - 'null'
      - int
    doc: "Number of sequences to select for each sample. Default is the smallest sample size. Limit to the default value."
    inputBinding:
      position: 1
      prefix: --num-selection
  - id: subregion_length
    type:
      - 'null'
      - int
    doc: "If specified, randomly choose a subregion with the required length from the sequence. A selected sequence shorter than this length is not included in the output, which may give unequal numbers of sequences in some samples."
    inputBinding:
      position: 2
      prefix: --subregion_length
outputs:
  - id: out_directory
    type: Directory
    doc: "Directory with the sampled sequence files"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
