cwlVersion: v1.2
class: CommandLineTool
baseCommand: minority_freq
label: smallgenomeutilities_minority_freq
doc: "Script to extract minority alleles per samples\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: BAM file(s)
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Report minority aminoacids - a .config file specifying reading frames 
      expected
    inputBinding:
      position: 102
      prefix: --config
  - id: end_position
    type:
      - 'null'
      - int
    doc: Ending position of the region of interest, 0-based indexing. Note a 
      half-open interval is used, i.e, [start:end)
    inputBinding:
      position: 102
      prefix: --end
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth for reporting variants per locus and sample
    inputBinding:
      position: 102
      prefix: -c
  - id: reference
    type: File
    doc: Either a fasta file containing a reference sequence or the reference 
      name of the region/chromosome of interest. The latter is expected if a 
      region is specified
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample_identifiers
    type:
      - 'null'
      - string
    doc: Patient/sample identifiers as comma separated strings
    inputBinding:
      position: 102
      prefix: -N
  - id: start_position
    type:
      - 'null'
      - int
    doc: Starting position of the region of interest, 0-based indexing
    inputBinding:
      position: 102
      prefix: --start
  - id: store_all_frequencies
    type:
      - 'null'
      - boolean
    doc: Indicates whether or not all frequencies should be stored
    inputBinding:
      position: 102
      prefix: --freqs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: write_coverage_per_locus
    type:
      - 'null'
      - boolean
    doc: Indicates whether coverage per locus should be written to output file
    inputBinding:
      position: 102
      prefix: -d
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
