cwlVersion: v1.2
class: CommandLineTool
baseCommand: makehub_bam2wig
label: makehub_bam2wig
doc: "Converts BAM files to WIG format for visualization.\n\nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: target_region
    type:
      - 'null'
      - string
    doc: Allows user to specify a target region, e.g. 'chr3L:10-250'. This 
      option can only be used if an index file exists.
    inputBinding:
      position: 101
      prefix: -r
  - id: track_name
    type:
      - 'null'
      - string
    doc: A string might be provided as track name
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
stdout: makehub_bam2wig.out
