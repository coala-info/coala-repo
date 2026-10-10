cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_data
label: mimsi_create_data
doc: "MiMSI Vector Generation Utility. Converts tumor/normal BAM pairs into the microsatellite\
  \ instance vectors used by MiMSI (single sample mode or batch mode with a case list).\n\
  \nTool homepage: https://github.com/mskcc/mimsi"
inputs:
  - id: tumor_bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: Tumor bam file for conversion
    inputBinding:
      position: 101
      prefix: --tumor-bam
  - id: normal_bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: Matched normal bam file for conversion
    inputBinding:
      position: 101
      prefix: --normal-bam
  - id: case_id
    type:
      - 'null'
      - string
    doc: Unique identifier for the single sample/case submitted. This will be the
      filename for any saved results (default TestCase)
    inputBinding:
      position: 101
      prefix: --case-id
  - id: norm_case_id
    type:
      - 'null'
      - string
    doc: Normal case name
    inputBinding:
      position: 101
      prefix: --norm-case-id
  - id: case_list
    type:
      - 'null'
      - File
    doc: Case List for generating sample vectors in bulk, if specified all other
      input file args will be ignored
    inputBinding:
      position: 101
      prefix: --case-list
  - id: case_list_files
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: BAM files (and their .bai indexes) named in the case list; staged in the
      working directory
  - id: name
    type:
      - 'null'
      - string
    doc: name of the run submitted using --case-list, this will be the filename
      for any saved results in the tsv format (default BATCH)
    inputBinding:
      position: 101
      prefix: --name
  - id: microsatellites_list
    type:
      - 'null'
      - File
    doc: The list of microsatellites to check in the tumor/normal pair
    inputBinding:
      position: 101
      prefix: --microsatellites-list
  - id: save_location
    type:
      - 'null'
      - string
    doc: 'The location on the filesystem to save the converted vectors (default:
      Current_working_directory/generated_samples/). WARNING: Existing files in this
      directory in the formats *_locations.npy and *_data.npy will be deleted!'
    inputBinding:
      position: 101
      prefix: --save-location
  - id: coverage
    type:
      - 'null'
      - int
    doc: Required coverage for both the tumor and the normal. Any coverage in excess
      of this limit will be randomly downsampled
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to utilize in parallel
    inputBinding:
      position: 101
      prefix: --cores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: vectors_dir
    type: Directory
    doc: Directory with the generated *_data.npy and *_locations.npy vectors
    outputBinding:
      glob: $(inputs.save_location || 'generated_samples')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.case_list_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi_create_data.out
