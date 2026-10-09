cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bamclip2insertion
label: jvarkit_bamclip2insertion
doc: "Convert the soft-clipped parts of reads into insertions in a BAM file.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    inputBinding:
      position: 100
  - id: bam_compression
    type:
      - 'null'
      - int
    doc: "Compression Level. 0: no compression. 9: max compression (default: 5)"
    inputBinding:
      position: 1
      prefix: --bamcompression
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 2
      prefix: --out
  - id: sam_output_format
    type:
      - 'null'
      - string
    doc: "Sam output format. One of BAM, SAM, CRAM (default: SAM)"
    inputBinding:
      position: 3
      prefix: --samoutputformat
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bamclip2insertion.out
