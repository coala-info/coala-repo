cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chira_extract.py
label: chira_extract
doc: "Chimeric Read Annotator: extract chimeras\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs:
  - id: loci
    type: File
    doc: "Input loci file (loci.counts from chira_quantify.py)"
    inputBinding:
      position: 1
      prefix: --loci
  - id: out
    type: string
    doc: "Path to output directory"
    default: "chira_extract_out"
    inputBinding:
      position: 1
      prefix: --out
  - id: gtf
    type:
      - 'null'
      - File
    doc: "Annotation GTF file"
    inputBinding:
      position: 1
      prefix: --gtf
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use (default: 1)"
    inputBinding:
      position: 1
      prefix: --processes
  - id: tpm_cutoff
    type:
      - 'null'
      - float
    doc: "Transcripts with less than this percentile TPMs will be discarded in the final output. [0-1.0] (default: 0)"
    inputBinding:
      position: 1
      prefix: --tpm_cutoff
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: "Hybrids with less than this score will be discarded in the final output. [0-1.0] (default: 0.0)"
    inputBinding:
      position: 1
      prefix: --score_cutoff
  - id: chimeric_overlap
    type:
      - 'null'
      - int
    doc: "Maximum number of bases allowed between the chimeric segments of a read (default: 2)"
    inputBinding:
      position: 1
      prefix: --chimeric_overlap
  - id: hybridize
    type:
      - 'null'
      - boolean
    doc: "Hybridize the predicted chimeras"
    inputBinding:
      position: 1
      prefix: --hybridize
  - id: no_seed
    type:
      - 'null'
      - boolean
    doc: "Do not enforce seed interactions"
    inputBinding:
      position: 1
      prefix: --no_seed
  - id: accessibility
    type:
      - 'null'
      - string
    doc: "IntaRNA accessibility: C (compute) or N (not) (default: N)"
    inputBinding:
      position: 1
      prefix: --accessibility
  - id: intarna_mode
    type:
      - 'null'
      - string
    doc: "IntaRNA mode: H (heuristic), M (exact), S (seed-only) (default: H)"
    inputBinding:
      position: 1
      prefix: --intarna_mode
  - id: temperature
    type:
      - 'null'
      - float
    doc: "IntaRNA temperature parameter in Celsius to setup the VRNA energy parameters (default: 37)"
    inputBinding:
      position: 1
      prefix: --temperature
  - id: seed_bp
    type:
      - 'null'
      - int
    doc: "IntaRNA --seedBP parameter: number of inter-molecular base pairs within the seed region (default: 5)"
    inputBinding:
      position: 1
      prefix: --seed_bp
  - id: seed_min_pu
    type:
      - 'null'
      - float
    doc: "IntaRNA --seedMinPu parameter: minimal unpaired probability (per sequence) a seed region may have (default: 0)"
    inputBinding:
      position: 1
      prefix: --seed_min_pu
  - id: acc_width
    type:
      - 'null'
      - int
    doc: "IntaRNA --accW parameter: sliding window size for accessibility computation (default: 150)"
    inputBinding:
      position: 1
      prefix: --acc_width
  - id: ref_fasta1
    type:
      - 'null'
      - File
    doc: "First priority fasta file"
    inputBinding:
      position: 1
      prefix: --ref_fasta1
  - id: ref_fasta2
    type:
      - 'null'
      - File
    doc: "Second priority fasta file"
    inputBinding:
      position: 1
      prefix: --ref_fasta2
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference (genomic) fasta file"
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --ref
  - id: summerize
    type:
      - 'null'
      - boolean
    doc: "Summarize interactions at loci level"
    inputBinding:
      position: 1
      prefix: --summerize
outputs:
  - id: chimeras
    type: File
    doc: "Chimeric reads table (chimeras)"
    outputBinding:
      glob: $(inputs.out)/chimeras
  - id: interactions
    type:
      - 'null'
      - File
    doc: "Interaction summary at loci level (with --summerize)"
    outputBinding:
      glob: $(inputs.out)/interactions
  - id: singletons
    type:
      - 'null'
      - File
    doc: "Non-chimeric (singleton) reads"
    outputBinding:
      glob: $(inputs.out)/singletons
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.out, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
