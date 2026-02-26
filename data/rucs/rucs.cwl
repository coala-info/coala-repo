cwlVersion: v1.2
class: CommandLineTool
baseCommand: rucs
label: rucs
doc: "RUCS: Robust Universal primer and probe design for DNA sequencing\n\nTool homepage:
  https://bitbucket.org/genomicepidemiology/rucs/src/master/"
inputs:
  - id: entry_point
    type: string
    doc: entry_point
    inputBinding:
      position: 1
  - id: anneal_tm
    type:
      - 'null'
      - float
    doc: This will modify the appropriate values in the settings
    inputBinding:
      position: 102
      prefix: --anneal_tm
  - id: annotation_evalue
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --annotation_evalue
  - id: dna_conc
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --dna_conc
  - id: dna_conc_probe
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --dna_conc_probe
  - id: dntp_conc
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --dntp_conc
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --kmer_size
  - id: max_3end_gc
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --max_3end_gc
  - id: negatives
    type:
      - 'null'
      - type: array
        items: File
    doc: File paths for the nagetive dataset
    inputBinding:
      position: 102
      prefix: --negatives
  - id: pairs
    type:
      - 'null'
      - File
    doc: 'File containing pcr primer pair sets (1 pair per line, tab-separated sequences,
      format: forward, reverse, probe*) *optional'
    inputBinding:
      position: 102
      prefix: --pairs
  - id: pick_probe
    type:
      - 'null'
      - boolean
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --pick_probe
  - id: positives
    type:
      - 'null'
      - type: array
        items: File
    doc: File paths for the positive dataset
    inputBinding:
      position: 102
      prefix: --positives
  - id: primer_pair_max_diff_tm
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --primer_pair_max_diff_tm
  - id: product_size_max
    type:
      - 'null'
      - int
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --product_size_max
  - id: product_size_min
    type:
      - 'null'
      - int
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --product_size_min
  - id: read_length
    type:
      - 'null'
      - int
    doc: This option will modify min_seq_len_pos and min_seq_len_neg in the 
      settings file
    inputBinding:
      position: 102
      prefix: --read_length
  - id: reference
    type:
      - 'null'
      - File
    doc: The reference file to which the k-mers should be mapped.
    inputBinding:
      position: 102
      prefix: --reference
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: File paths for the references to be tested
    inputBinding:
      position: 102
      prefix: --references
  - id: salt_divalent_conc
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --salt_divalent_conc
  - id: salt_monovalent_conc
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --salt_monovalent_conc
  - id: settings_file
    type:
      - 'null'
      - File
    doc: File containing the default settings for this program
    inputBinding:
      position: 102
      prefix: --settings_file
  - id: template
    type:
      - 'null'
      - File
    doc: File path for the template file
    inputBinding:
      position: 102
      prefix: --template
  - id: tm_threshold
    type:
      - 'null'
      - float
    doc: This will overwrite the set value in the settings
    inputBinding:
      position: 102
      prefix: --tm_threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rucs:1.0.3--hdfd78af_0
stdout: rucs.out
