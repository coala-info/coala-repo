cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hictk
  - rename-chromosomes
label: hictk_rename-chromosomes
doc: 'Rename chromosomes found in Cooler files.


  Tool homepage: https://github.com/paulsengroup/hictk'
inputs:
  - id: uri
    type: File
    doc: The .cool or .mcool file. The file is staged writable and renamed in place.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: name_mappings
    type:
      - 'null'
      - File
    doc: Two column TSV with pairs of chromosomes to be renamed. The first column
      holds the original chromosome name, the second the destination name.
    inputBinding:
      position: 2
      prefix: --name-mappings
  - id: add_chr_prefix
    type:
      - 'null'
      - boolean
    doc: Prefix chromosome names with "chr".
    inputBinding:
      position: 2
      prefix: --add-chr-prefix
  - id: remove_chr_prefix
    type:
      - 'null'
      - boolean
    doc: Remove prefix "chr" from chromosome names.
    inputBinding:
      position: 2
      prefix: --remove-chr-prefix
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Set verbosity of output to the console. [default: 3]'
    inputBinding:
      position: 2
      prefix: --verbosity
outputs:
  - id: renamed_file
    type: File
    doc: The file with renamed chromosomes.
    outputBinding:
      glob: $(inputs.uri.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.uri)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
