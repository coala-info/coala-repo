cwlVersion: v1.2
class: CommandLineTool
baseCommand: primerForge
label: primerforge_primerForge
doc: "Finds pairs of primers suitable for a group of input genomes\n\nTool homepage:
  https://github.com/dr-joe-wirth/primerForge"
inputs:
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: print advanced options
    inputBinding:
      position: 101
      prefix: --advanced
  - id: bad_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: a range of PCR product lengths that the outgroup cannot produce
    inputBinding:
      position: 101
      prefix: --bad_sizes
  - id: check_install
    type:
      - 'null'
      - boolean
    doc: check installation
    inputBinding:
      position: 101
      prefix: --check_install
  - id: debug
    type:
      - 'null'
      - boolean
    doc: run in debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: format
    type:
      - 'null'
      - string
    doc: file format of the ingroup and outgroup
    inputBinding:
      position: 101
      prefix: --format
  - id: gc_range
    type:
      - 'null'
      - type: array
        items: float
    doc: a min and max percent GC specified as a comma separated list
    inputBinding:
      position: 101
      prefix: --gc_range
  - id: ingroup
    type: File
    doc: ingroup filename or a file pattern inside double-quotes (eg. "*.gbff")
    inputBinding:
      position: 101
      prefix: --ingroup
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: num_threads
    type:
      - 'null'
      - int
    doc: the number of threads for parallel processing
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: outgroup
    type:
      - 'null'
      - File
    doc: outgroup filename or a file pattern inside double-quotes (eg. "*.gbff")
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: pcr_prod
    type:
      - 'null'
      - type: array
        items: int
    doc: a single PCR product length or a range specified as 'min,max'
    inputBinding:
      position: 101
      prefix: --pcr_prod
  - id: primer_len
    type:
      - 'null'
      - type: array
        items: int
    doc: a single primer length or a range specified as 'min,max'; (minimum 10)
    inputBinding:
      position: 101
      prefix: --primer_len
  - id: tm_diff
    type:
      - 'null'
      - float
    doc: the maximum allowable Tm difference °C between a pair of primers
    inputBinding:
      position: 101
      prefix: --tm_diff
  - id: tm_range
    type:
      - 'null'
      - type: array
        items: float
    doc: a min and max melting temp (°C) specified as a comma separated list
    inputBinding:
      position: 101
      prefix: --tm_range
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output filename for primer pair data
    outputBinding:
      glob: $(inputs.out)
  - id: bed_file
    type:
      - 'null'
      - File
    doc: output filename for primer data in BED file format
    outputBinding:
      glob: $(inputs.bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primerforge:1.5.3--pyhdfd78af_0
