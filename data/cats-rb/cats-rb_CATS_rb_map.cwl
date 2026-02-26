cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats_rb_map
label: cats-rb_CATS_rb_map
doc: "transcriptome assembly mapping script\n\nTool homepage: https://github.com/bodulic/CATS-rb"
inputs:
  - id: genome_index_dir
    type: Directory
    doc: Genome index directory
    inputBinding:
      position: 1
  - id: transcriptome
    type: File
    doc: Transcriptome file
    inputBinding:
      position: 2
  - id: coding_potential_score_contribution
    type:
      - 'null'
      - int
    doc: Relative contribution of coding potential to mapping score
    default: 1
    inputBinding:
      position: 103
      prefix: -P
  - id: max_mappings_per_transcript
    type:
      - 'null'
      - int
    doc: Maximum number of mappings per transcript
    default: 5
    inputBinding:
      position: 103
      prefix: -N
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: Minimum intron length (in bp)
    default: 20
    inputBinding:
      position: 103
      prefix: -i
  - id: overwrite_output_dir
    type:
      - 'null'
      - boolean
    doc: Overwrite the mapping output directory
    default: false
    inputBinding:
      position: 103
      prefix: -O
  - id: species_preset
    type:
      - 'null'
      - string
    doc: Species-specific preset (from path_to_spaln_dir/table/)
    inputBinding:
      position: 103
      prefix: -p
  - id: splice_site_characterization
    type:
      - 'null'
      - int
    doc: Splice site characterization option (0-3, refer to documentation)
    default: 2
    inputBinding:
      position: 103
      prefix: -s
  - id: stranded_mapping
    type:
      - 'null'
      - boolean
    doc: Enable stranded mapping
    default: false
    inputBinding:
      position: 103
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    default: 10
    inputBinding:
      position: 103
      prefix: -t
  - id: translation_initiation_signal_score_contribution
    type:
      - 'null'
      - int
    doc: Relative contribution of translation initiation signal to mapping score
    default: 1
    inputBinding:
      position: 103
      prefix: -T
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Mapping output directory name
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
