cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genomad
  - summary
label: genomad_summary
doc: "Applies post-classification filters, generates classification reports for the sequences in the INPUT file (FASTA format), and writes them to the OUTPUT directory. This module requires that at least one of the base classification modules was executed previously (marker-classification, nn-classification).\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: input
    type: File
    doc: "Input FASTA file."
    inputBinding:
      position: 1
  - id: previous_dir
    type: Directory
    doc: "Output directory of previous geNomad runs on the same INPUT (marker-classification and/or nn-classification, optionally annotate and find-proviruses). It is copied to the OUTPUT directory (named by 'output') before this module runs, because this module reads the earlier results from there."
  - id: output
    type: string
    doc: "Output directory."
    inputBinding:
      position: 2
  - id: conservative
    type:
      - 'null'
      - boolean
    doc: "Use the conservative preset: post-classification filters are even more aggressive, so only sequences whose classification is strongly supported are kept. Cannot be used together with --min-score, --max-fdr, --min-number-genes, --min-plasmid-marker-enrichment, --min-virus-marker-enrichment, --min-plasmid-hallmarks, --min-plasmid-hallmarks-short-seqs, --min-virus-hallmarks, --min-virus-hallmarks-short-seqs, and --max-uscg."
    inputBinding:
      position: 103
      prefix: --conservative
  - id: max_fdr
    type:
      - 'null'
      - float
    doc: "Maximum accepted false discovery rate. This option will be ignored if the scores were not calibrated."
    inputBinding:
      position: 103
      prefix: --max-fdr
  - id: max_uscg
    type:
      - 'null'
      - int
    doc: "Maximum allowed number of universal single copy genes (USCGs) in a virus or a plasmid. Sequences with more than this number of USCGs will not be classified as viruses or plasmids, regardless of their score. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --max-uscg
  - id: min_number_genes
    type:
      - 'null'
      - int
    doc: "The minimum number of genes a sequence must encode to be considered for classification as a plasmid or virus."
    inputBinding:
      position: 103
      prefix: --min-number-genes
  - id: min_plasmid_hallmarks
    type:
      - 'null'
      - int
    doc: "Minimum number of plasmid hallmarks in the identified plasmids. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --min-plasmid-hallmarks
  - id: min_plasmid_hallmarks_short_seqs
    type:
      - 'null'
      - int
    doc: "Minimum number of plasmid hallmarks in plasmids shorter than 2,500 bp. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --min-plasmid-hallmarks-short-seqs
  - id: min_plasmid_marker_enrichment
    type:
      - 'null'
      - float
    doc: "Minimum allowed value for the plasmid marker enrichment score, which represents the total enrichment of plasmid markers in the sequence. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --min-plasmid-marker-enrichment
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Minimum score to flag a sequence as virus or plasmid."
    inputBinding:
      position: 103
      prefix: --min-score
  - id: min_virus_hallmarks
    type:
      - 'null'
      - int
    doc: "Minimum number of virus hallmarks in the identified viruses. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --min-virus-hallmarks
  - id: min_virus_hallmarks_short_seqs
    type:
      - 'null'
      - int
    doc: "Minimum number of virus hallmarks in viruses shorter than 2,500 bp. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --min-virus-hallmarks-short-seqs
  - id: min_virus_marker_enrichment
    type:
      - 'null'
      - float
    doc: "Minimum allowed value for the virus marker enrichment score, which represents the total enrichment of virus markers in the sequence. This option will be ignored if the annotation module was not executed."
    inputBinding:
      position: 103
      prefix: --min-virus-marker-enrichment
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --quiet
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: "Use the relaxed preset, which disables all post-classification filters. Same restrictions as --conservative."
    inputBinding:
      position: 103
      prefix: --relaxed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Display the execution log."
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_output
    type: Directory
    doc: "Output directory."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.previous_dir)
        entryname: $(inputs.output)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
