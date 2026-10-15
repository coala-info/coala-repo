cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_remove_duplicate_hits_from_probes_using_lastz
label: phyluce_phyluce_probe_remove_duplicate_hits_from_probes_using_lastz
doc: "Remove duplicate loci from a fasta given self-to-self lastz\n\nTool homepage:\
  \ https://github.com/faircloth-lab/phyluce"
inputs:
  - id: fasta
    type: File
    doc: The fasta file to screen
    inputBinding:
      prefix: --fasta
      valueFrom: $(self.basename)
  - id: lastz
    type: File
    doc: The lastz file to use
    inputBinding:
      prefix: --lastz
  - id: probe_prefix
    type: string
    doc: The prefix (e.g. "uce-") added to all probes designed
    inputBinding:
      prefix: --probe-prefix
  - id: probe_regex
    type:
      - 'null'
      - string
    doc: The regular expression to use for matching probes
    inputBinding:
      prefix: --probe-regex
  - id: probe_bed
    type:
      - 'null'
      - File
    doc: The path to a file contaning the probe coordinates in BED format
    inputBinding:
      prefix: --probe-bed
      valueFrom: $(self.basename)
  - id: locus_bed
    type:
      - 'null'
      - File
    doc: The path to a file contaning the locus coordinates in BED format
    inputBinding:
      prefix: --locus-bed
      valueFrom: $(self.basename)
  - id: long
    type:
      - 'null'
      - boolean
    doc: If the lastz output is the longfield format
    inputBinding:
      prefix: --long
outputs:
  - id: screened_fasta
    type: File
    doc: The screened FASTA file (input name plus -DUPE-SCREENED).
    outputBinding:
      glob: $(inputs.fasta.nameroot)-DUPE-SCREENED$(inputs.fasta.nameext)
  - id: screened_probe_bed
    type:
      - 'null'
      - File
    doc: The screened probe BED file.
    outputBinding:
      glob: '$(inputs.probe_bed ? [inputs.probe_bed.nameroot + "-DUPE-SCREENED" +
        inputs.probe_bed.nameext] : [])'
  - id: screened_locus_bed
    type:
      - 'null'
      - File
    doc: The screened locus BED file.
    outputBinding:
      glob: '$(inputs.locus_bed ? [inputs.locus_bed.nameroot + "-DUPE-SCREENED" +
        inputs.locus_bed.nameext] : [])'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
      - entry: $(inputs.probe_bed)
      - entry: $(inputs.locus_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
