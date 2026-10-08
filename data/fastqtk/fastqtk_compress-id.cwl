cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - compress-id
label: fastqtk_compress-id
doc: "It does lossy compression on the reads ids from a FASTQ file.\n\nTool homepage:
  https://github.com/ndaniel/fastqtk"
inputs:
  - id: id_settings
    type:
      - 'null'
      - string
    doc: "settings for generating reads ids: @ (not interleaved, no suffix, default),
      @@ (interleaved, no suffix), /1, /2, _1, _2 (not interleaved) or /12, _12
      (interleaved)"
    inputBinding:
      position: 1
  - id: read_count_info
    type:
      - 'null'
      - string
    doc: Number of reads in the input FASTQ file (or a much larger number; default
      500000), or the name of a counts file (it must contain a dot) that was made
      with 'fastqtk count'. A counts file must also be given in counts_file.
    inputBinding:
      position: 2
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 3
  - id: out_fq
    type: string
    doc: Name of the output FASTQ file
    inputBinding:
      position: 4
  - id: counts_file
    type:
      - 'null'
      - File
    doc: file that contains number of reads in the input FASTQ file <in.fq>, 
      that was generated using 'fastqtk count in.fq counts.txt' beforehand. It
      is staged in the working directory; give its file name in read_count_info.
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: $(inputs.out_fq)
requirements:
  - class: InitialWorkDirRequirement
    listing: "$(inputs.counts_file ? [inputs.counts_file] : [])"
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
