cwlVersion: v1.2
class: CommandLineTool
baseCommand: ResampleSeqFile
label: rdp-readseq_random-sample
doc: ResampleSeqFile
inputs:
  - id: infile_dir
    type: Directory
    doc: Input directory
    inputBinding:
      position: 1
  - id: num_selection
    type:
      - 'null'
      - int
    doc: number of sequence to select for each sample. Default is the smallest 
      sample size. Limit to the default value.
    inputBinding:
      position: 102
      prefix: --num-selection
  - id: subregion_length
    type:
      - 'null'
      - int
    doc: If specified, radomly choose a subregion with the required length from 
      the sequence. If a selected sequence is shorter than the specified length,
      that sequence will not be included in the output, which may result in not 
      equal number of sequences in some samples.
    inputBinding:
      position: 102
      prefix: --subregion_length
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
