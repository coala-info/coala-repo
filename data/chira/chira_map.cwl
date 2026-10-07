cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chira_map.py
label: chira_map
doc: "Chimeric Read Annotator: map reads to the reference\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Alignment program to use, bwa or clan (default: bwa)"
    inputBinding:
      position: 1
      prefix: --aligner
  - id: query_fasta
    type: File
    doc: "Path to query fasta file"
    inputBinding:
      position: 1
      prefix: --query_fasta
  - id: outdir
    type: string
    doc: "Output directory path for the analysis"
    default: "chira_map_out"
    inputBinding:
      position: 1
      prefix: --outdir
  - id: index1
    type:
      - 'null'
      - File
    doc: "first priority index file"
    secondaryFiles:
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
    inputBinding:
      position: 1
      prefix: --index1
  - id: index2
    type:
      - 'null'
      - File
    doc: "second priority index file"
    secondaryFiles:
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
    inputBinding:
      position: 1
      prefix: --index2
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
  - id: build
    type:
      - 'null'
      - boolean
    doc: "Build indices from reference fasta files"
    inputBinding:
      position: 1
      prefix: --build
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use (default: 1)"
    inputBinding:
      position: 1
      prefix: --processes
  - id: stranded
    type:
      - 'null'
      - string
    doc: "Strand-specificity of input samples. fw = map to transcript strand; rc = map to reverse complement of transcript strand; both = try to map on both strands (default: fw)"
    inputBinding:
      position: 1
      prefix: --stranded
  - id: seed_length1
    type:
      - 'null'
      - int
    doc: "Seed length for 1st mapping iteration. bwa-mem parameter \"-k\" (default: 12)"
    inputBinding:
      position: 1
      prefix: --seed_length1
  - id: seed_length2
    type:
      - 'null'
      - int
    doc: "Seed length for 2nd mapping iteration. bwa-mem parameter \"-k\" (default: 16)"
    inputBinding:
      position: 1
      prefix: --seed_length2
  - id: align_score1
    type:
      - 'null'
      - int
    doc: "Minimum alignment score in 1st mapping iteration. bwa-mem parameter \"-T\" and clan_search parameter \"-l\" (default: 18)"
    inputBinding:
      position: 1
      prefix: --align_score1
  - id: align_score2
    type:
      - 'null'
      - int
    doc: "Minimum alignment score in 2nd mapping iteration. It must be smaller than --align_score1 (default: 16)"
    inputBinding:
      position: 1
      prefix: --align_score2
  - id: match1
    type:
      - 'null'
      - int
    doc: "Matching score for 1st mapping iteration. (default: 1)"
    inputBinding:
      position: 1
      prefix: --match1
  - id: mismatch1
    type:
      - 'null'
      - int
    doc: "Mismatch penalty for 1st mapping iteration. (default: 4)"
    inputBinding:
      position: 1
      prefix: --mismatch1
  - id: match2
    type:
      - 'null'
      - int
    doc: "Matching score for 2nd mapping iteration. (default: 1)"
    inputBinding:
      position: 1
      prefix: --match2
  - id: mismatch2
    type:
      - 'null'
      - int
    doc: "Mismatch penalty for 2nd mapping iteration. (default: 6)"
    inputBinding:
      position: 1
      prefix: --mismatch2
  - id: gapopen1
    type:
      - 'null'
      - int
    doc: "Gap opening penalty for 1st mapping iteration. (default: 6)"
    inputBinding:
      position: 1
      prefix: --gapopen1
  - id: gapext1
    type:
      - 'null'
      - int
    doc: "Gap extension penalty for 1st mapping iteration. (default: 1)"
    inputBinding:
      position: 1
      prefix: --gapext1
  - id: gapopen2
    type:
      - 'null'
      - int
    doc: "Gap opening penalty for 2nd mapping iteration. (default: 100)"
    inputBinding:
      position: 1
      prefix: --gapopen2
  - id: gapext2
    type:
      - 'null'
      - int
    doc: "Gap extension penalty for 2nd mapping iteration. (default: 100)"
    inputBinding:
      position: 1
      prefix: --gapext2
  - id: nhits1
    type:
      - 'null'
      - int
    doc: "Number of allowed multi hits per read (default: 50)"
    inputBinding:
      position: 1
      prefix: --nhits1
  - id: nhits2
    type:
      - 'null'
      - int
    doc: "Number of allowed multi hits per read in 2nd iteration (default: 100)"
    inputBinding:
      position: 1
      prefix: --nhits2
  - id: chimeric_overlap
    type:
      - 'null'
      - int
    doc: "Maximum number of bases allowed between the chimeric segments of a read (default: 2)"
    inputBinding:
      position: 1
      prefix: --chimeric_overlap
outputs:
  - id: mapped_bed
    type: File
    doc: "Sorted alignments in BED format (sorted.bed)"
    outputBinding:
      glob: $(inputs.outdir)/sorted.bed
  - id: unmapped_fasta
    type:
      - 'null'
      - File
    doc: "Reads that were not mapped (bwa only)"
    outputBinding:
      glob: $(inputs.outdir)/unmapped.fasta
  - id: output_dir
    type: Directory
    doc: "Mapping output directory"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.outdir, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
