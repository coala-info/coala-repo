cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - addlinearindextobed
label: jvarkit_addlinearindextobed
doc: "Add a linear index to a BED file.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bed_files
    type:
      type: array
      items: File
    doc: Input BED files
    inputBinding:
      position: 100
  - id: reference
    type: File
    doc: "A SAM Sequence dictionary source: it can be a *.dict file, a fasta file indexed with 'picard CreateSequenceDictionary' or 'samtools dict', or any hts file containing a dictionary (VCF, BAM, CRAM, intervals...). The option is also named --dict."
    inputBinding:
      position: 1
      prefix: --reference
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 2
      prefix: --out
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
stdout: jvarkit_addlinearindextobed.out
