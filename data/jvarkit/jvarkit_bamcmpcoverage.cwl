cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bamcmpcoverage
label: jvarkit_bamcmpcoverage
doc: "Compare the coverage of two or more BAM files and draw it as an image.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM files (at least two)
    secondaryFiles:
      - .bai
    inputBinding:
      position: 100
  - id: bed
    type:
      - 'null'
      - File
    doc: restrict to region
    inputBinding:
      position: 1
      prefix: --bed
  - id: filter
    type:
      - 'null'
      - string
    doc: "A JEXL Expression that will be used to filter out some sam-records. An expression should return a boolean value (true=exclude, false=keep the read). An empty expression keeps everything. The variable 'record' is the current observed read, an instance of SAMRecord."
    inputBinding:
      position: 2
      prefix: --filter
  - id: groupby
    type:
      - 'null'
      - string
    doc: "Group Reads by. Data partitioning using the SAM Read Group. It can be any combination of sample, library.... One of readgroup, sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center, any (default: sample)"
    inputBinding:
      position: 3
      prefix: --groupby
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "max depth (default: 1000)"
    inputBinding:
      position: 4
      prefix: --maxDepth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "min depth (default: 0)"
    inputBinding:
      position: 5
      prefix: --minDepth
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 6
      prefix: --output
  - id: region
    type:
      - 'null'
      - string
    doc: restrict to region
    inputBinding:
      position: 7
      prefix: --region
  - id: width
    type:
      - 'null'
      - int
    doc: "image width (default: 1000)"
    inputBinding:
      position: 8
      prefix: --width
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bamcmpcoverage.out
