cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circle_map++
  - ReadExtractor
label: circle-map-cpp_ReadExtractor
doc: "Extracts circular DNA read candidates\n\nTool homepage: https://github.com/BGI-Qingdao/Circle-Map-cpp"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_bam)
inputs:
  - id: input_bam
    type: File
    doc: 'Input: query name sorted bam file. The tool joins input paths to the
      working directory, so the file is staged there and passed by name.'
    inputBinding:
      position: 101
      prefix: -i
      valueFrom: $(self.basename)
  - id: output
    type: string
    doc: 'Ouput: Reads indicating circular DNA structural variants'
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: directory
    type:
      - 'null'
      - string
    doc: Working directory, default is the working directory
    inputBinding:
      position: 101
      prefix: --directory
  - id: quality
    type:
      - 'null'
      - int
    doc: bwa-mem mapping quality cutoff. Default value 10
    inputBinding:
      position: 101
      prefix: --quality
  - id: nodiscordant
    type:
      - 'null'
      - boolean
    doc: Turn off discordant (R2F1 oriented) read extraction
    inputBinding:
      position: 101
      prefix: --nodiscordant
  - id: nosoftclipped
    type:
      - 'null'
      - boolean
    doc: Turn off soft-clipped read extraction
    inputBinding:
      position: 101
      prefix: --nosoftclipped
  - id: nohardclipped
    type:
      - 'null'
      - boolean
    doc: Turn off hard-clipped read extraction
    inputBinding:
      position: 101
      prefix: --nohardclipped
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbose level, 1=error,2=warning, 3=message
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_bam
    type: File
    doc: Reads indicating circular DNA structural variants
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
stdout: circle-map-cpp_ReadExtractor.out
