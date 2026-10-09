cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - chunk
label: hicberg_chunk
doc: 'Chunk provided inputs in a desired number of pieces.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: input1
    type: File
    doc: Forward alignment file (BAM, sorted by read name), for example group1.1.bam.
    inputBinding:
      position: 1
  - id: input2
    type: File
    doc: Reverse alignment file (BAM, sorted by read name), for example group1.2.bam.
    inputBinding:
      position: 2
  - id: chunks
    type:
      - 'null'
      - int
    doc: Number of chunks to generate.
    inputBinding:
      position: 103
      prefix: --chunks
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Result folder (from hicberg create-folder) in which the chunks sub-folder
      is created, as needed by hicberg benchmark. It is staged writable. If not set,
      the chunks sub-folder is created in the current directory.
    inputBinding:
      position: 104
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
outputs:
  - id: chunks_folder
    type: Directory
    doc: Folder with the forward and reverse chunk BAM files.
    outputBinding:
      glob: '${ return inputs.output_folder ? inputs.output_folder.basename + ''/chunks''
        : ''chunks''; }'
  - id: output_folder_out
    type:
      - 'null'
      - Directory
    doc: The result folder with the chunks sub-folder added (only when output_folder
      is set).
    outputBinding:
      glob: '${ return inputs.output_folder ? inputs.output_folder.basename : [];
        }'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
