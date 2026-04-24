cwlVersion: v1.2
class: CommandLineTool
baseCommand: fings
label: fings
doc: "Filters for Next Generation Sequencing\n\nTool homepage: https://github.com/cpwardell/FiNGS"
inputs:
  - id: filtering_parameters
    type:
      - 'null'
      - File
    doc: absolute path to filtering parameters
    inputBinding:
      position: 101
      prefix: -p
  - id: icgc_filters
    type:
      - 'null'
      - boolean
    doc: Use filters identical to those recommended by the ICGC (Alioto et al, 
      2015). Overrides '-p' flag
    inputBinding:
      position: 101
      prefix: --ICGC
  - id: logging
    type:
      - 'null'
      - string
    doc: Set logging level (default is INFO, can be DEBUG for more detail or 
      NOTSET for silent)
    inputBinding:
      position: 101
      prefix: --logging
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: maximum read depth to process
    inputBinding:
      position: 101
      prefix: -m
  - id: normal_bam
    type: File
    doc: absolute path to normal BAM
    inputBinding:
      position: 101
      prefix: -n
  - id: num_processors
    type:
      - 'null'
      - int
    doc: number of processors to use (default is -1, use all available 
      resources)
    inputBinding:
      position: 101
      prefix: -j
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: absolute path to output directory
    inputBinding:
      position: 101
      prefix: -d
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous results if they exist
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pass_only_in
    type:
      - 'null'
      - boolean
    doc: Only use variants with that the original caller PASSed?
    inputBinding:
      position: 101
      prefix: --PASSonlyin
  - id: pass_only_out
    type:
      - 'null'
      - boolean
    doc: Only write PASS variants to the output VCF
    inputBinding:
      position: 101
      prefix: --PASSonlyout
  - id: records_per_chunk
    type:
      - 'null'
      - int
    doc: number of records to process per chunk
    inputBinding:
      position: 101
      prefix: -c
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: absolute path to faidx indexed reference genome; required if using 
      'repeats' filter
    inputBinding:
      position: 101
      prefix: -r
  - id: tumor_bam
    type: File
    doc: absolute path to tumor BAM
    inputBinding:
      position: 101
      prefix: -t
  - id: vcf_file
    type: File
    doc: absolute path to VCF file
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fings:1.7.1--pyhb7b1952_0
stdout: fings.out
