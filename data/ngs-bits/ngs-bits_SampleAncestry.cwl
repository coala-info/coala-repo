cwlVersion: v1.2
class: CommandLineTool
baseCommand: SampleAncestry
label: ngs-bits_SampleAncestry
doc: "Estimates the ancestry of a sample based on variants.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: "Genome build used to generate the input.\n                        Valid:
      'hg19,hg38'"
    inputBinding:
      position: 101
      prefix: -build
  - id: input_filelist
    type:
      type: array
      items: File
    doc: Input variant list(s) in VCF or VCF.GZ format.
    inputBinding:
      position: 101
      prefix: -in
  - id: mad_dist
    type:
      - 'null'
      - float
    doc: Maximum number of median average diviations that are allowed from 
      median population score.
    inputBinding:
      position: 101
      prefix: -mad_dist
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of informative SNPs for population determination. If 
      less SNPs are found, 'NOT_ENOUGH_SNPS' is returned.
    inputBinding:
      position: 101
      prefix: -min_snps
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: Absolute score cutoff above which a sample is assigned to a population.
    inputBinding:
      position: 101
      prefix: -score_cutoff
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output TSV file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
