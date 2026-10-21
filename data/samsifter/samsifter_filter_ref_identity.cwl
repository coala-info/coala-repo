cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_ref_identity
label: samsifter_filter_ref_identity
doc: "Filters reference accessions with too few/many reads of high/low percent identity in MALT'ed SAM files\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM file to be analysed; it is read from standard input, because the -i option of this tool crashes"
  - id: discard
    type:
      - 'null'
      - int
    doc: "keep or discard entries passing the filter criteria? (0 = discard, 1 = keep)"
    inputBinding:
      position: 2
      prefix: --discard
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print additional information to STDERR"
    inputBinding:
      position: 3
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print debug messages to STDERR"
    inputBinding:
      position: 4
      prefix: -d
  - id: modify
    type:
      - 'null'
      - boolean
    doc: "modify header by adding PG record"
    inputBinding:
      position: 5
      prefix: -m
  - id: min_reads
    type:
      - 'null'
      - float
    doc: "minimum percentage of reads with insufficient identity [50.0]"
    inputBinding:
      position: 6
      prefix: --min_reads
  - id: max_reads
    type:
      - 'null'
      - float
    doc: "maximum percentage of reads with insufficient identity [100.0]"
    inputBinding:
      position: 7
      prefix: --max_reads
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "minimum percent identity [90.0]"
    inputBinding:
      position: 8
      prefix: --min_identity
  - id: max_identity
    type:
      - 'null'
      - float
    doc: "maximum percent identity [100.0]"
    inputBinding:
      position: 9
      prefix: --max_identity
  - id: no_deamination
    type:
      - 'null'
      - boolean
    doc: "do not treat possibly deaminated T>C and A>G pairs as mismatches in calculation of percent identity"
    inputBinding:
      position: 10
      prefix: --no_deamination
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: "do not treat insertions and deletions in alignment as mismatches in calculation of percent identity"
    inputBinding:
      position: 11
      prefix: --no_indels
  - id: no_unknown
    type:
      - 'null'
      - boolean
    doc: "do not treat Ns in alignment as mismatch in calculation of percent identity"
    inputBinding:
      position: 12
      prefix: --no_unknown
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the processed SAM)
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_filter_ref_identity.out
stderr: samsifter_filter_ref_identity.err
stdin: $(inputs.input_sam.path)
