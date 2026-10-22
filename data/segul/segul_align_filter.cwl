cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, align, filter]
label: segul_align_filter
doc: "Filter alignments\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: dir
    type: ['null', Directory]
    doc: "Input a directory"
    inputBinding:
      position: 1
      prefix: "--dir"
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input path(s) (wildcards are expanded by the tool, so give files)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: input_format
    type: ['null', string]
    doc: "Input format: auto, fasta, nexus, phylip (default auto)"
    inputBinding:
      position: 1
      prefix: "--input-format"
  - id: datatype
    type: ['null', string]
    doc: "Sequence datatype: dna, aa, ignore (default dna)"
    inputBinding:
      position: 1
      prefix: "--datatype"
  - id: output_format
    type: ['null', string]
    doc: "Output format: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int (default nexus)"
    inputBinding:
      position: 1
      prefix: "--output-format"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: partition_format
    type: ['null', string]
    doc: "Partition output format: charset, nexus, raxml (default nexus)"
    inputBinding:
      position: 1
      prefix: "--partition-format"
  - id: codon
    type: ['null', boolean]
    doc: "Set as a codon model partition format"
    inputBinding:
      position: 1
      prefix: "--codon"
  - id: prefix
    type: ['null', string]
    doc: "Prefix for output files"
    inputBinding:
      position: 1
      prefix: "--prefix"
  - id: output
    type: string
    default: "Align-Filter"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: concat
    type: ['null', boolean]
    doc: "Concat filtered alignments"
    inputBinding:
      position: 1
      prefix: "--concat"
  - id: min_len
    type: ['null', int]
    doc: "Filter by minimum sequence length"
    inputBinding:
      position: 1
      prefix: "--min-len"
  - id: max_len
    type: ['null', int]
    doc: "Filter by maximum sequence length"
    inputBinding:
      position: 1
      prefix: "--max-len"
  - id: missing_data
    type: ['null', float]
    doc: "Filter by proportion of missing data"
    inputBinding:
      position: 1
      prefix: "--missing-data"
  - id: npercent
    type: ['null', float]
    doc: "Filter by multiple minimal taxon percentage"
    inputBinding:
      position: 1
      prefix: "--npercent"
  - id: min_ntax
    type: ['null', int]
    doc: "Filter by minimal taxon number"
    inputBinding:
      position: 1
      prefix: "--min-ntax"
  - id: percent
    type: ['null', float]
    doc: "Filter by minimal taxon percentage"
    inputBinding:
      position: 1
      prefix: "--percent"
  - id: percent_inf
    type: ['null', float]
    doc: "Filter by minimal parsimony informative percentage"
    inputBinding:
      position: 1
      prefix: "--percent-inf"
  - id: min_pinf
    type: ['null', int]
    doc: "Filter by minimal parsimony informative sites"
    inputBinding:
      position: 1
      prefix: "--min-pinf"
  - id: max_pinf
    type: ['null', int]
    doc: "Filter by maximum parsimony informative sites"
    inputBinding:
      position: 1
      prefix: "--max-pinf"
  - id: taxon_id
    type: ['null', string]
    doc: "Filter by taxon ID"
    inputBinding:
      position: 1
      prefix: "--taxon-id"
outputs:
  - id: output_path
    type:
      type: array
      items: [File, Directory]
    doc: Output directory; segul appends the filter setting to the name (for example filt_out_1250bp)
    outputBinding:
      glob: $(inputs.output)*
  - id: log_file
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_align_filter.out
