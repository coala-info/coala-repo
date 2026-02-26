cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_enrichalignment
doc: "MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and
  stop codons.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: enrichment_input_alignment
    type: File
    doc: The pre-existing nucleotide alignment to which sequences will be added.
    inputBinding:
      position: 1
  - id: sequences_to_add
    type:
      type: array
      items: File
    doc: One or more nucleotide sequence files to add to the alignment.
    inputBinding:
      position: 2
  - id: aa_alignment
    type:
      - 'null'
      - File
    doc: Amino acid alignment to guide the nucleotide alignment.
    inputBinding:
      position: 103
      prefix: --aa-alignment
  - id: codon_table
    type:
      - 'null'
      - string
    doc: Specify a custom codon table (e.g., '1', '2', '3', '4', '5', '6', '9', 
      '10', '11', '12', '13', '14', '15', '16', '21', '22', '23').
    inputBinding:
      position: 103
      prefix: --codon-table
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode.
    inputBinding:
      position: 103
      prefix: -debug
  - id: force_original_aa_alignment
    type:
      - 'null'
      - boolean
    doc: Force the use of the original amino acid alignment, even if it's not 
      optimal.
    inputBinding:
      position: 103
      prefix: --force-original-aa-alignment
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: Specify the genetic code to use for translation.
    inputBinding:
      position: 103
      prefix: --genetic-code
  - id: max_aa_length_diff
    type:
      - 'null'
      - int
    doc: Maximum allowed difference in amino acid length between sequences.
    inputBinding:
      position: 103
      prefix: --max-aa-length-diff
  - id: max_gaps_in_aa
    type:
      - 'null'
      - int
    doc: Maximum number of gaps allowed in the amino acid alignment.
    inputBinding:
      position: 103
      prefix: --max-gaps-in-aa
  - id: max_gaps_in_nt
    type:
      - 'null'
      - int
    doc: Maximum number of gaps allowed in the nucleotide alignment.
    inputBinding:
      position: 103
      prefix: --max-gaps-in-nt
  - id: min_aa_identity
    type:
      - 'null'
      - float
    doc: Minimum amino acid identity required for alignment.
    inputBinding:
      position: 103
      prefix: --min-aa-identity
  - id: no_frame_shift
    type:
      - 'null'
      - boolean
    doc: Disable frame shift detection and correction.
    inputBinding:
      position: 103
      prefix: --no-frame-shift
  - id: no_stop_codon
    type:
      - 'null'
      - boolean
    doc: Disable stop codon detection and correction.
    inputBinding:
      position: 103
      prefix: --no-stop-codon
  - id: program_name
    type:
      - 'null'
      - string
    doc: "Specify the MACSE program to run. Available programs: 'alignSequences',
      'alignTwoProfiles', 'enrichAlignment', 'exportAlignment', 'mergeTwoMasks', 'multiPrograms',
      'refineAlignment', 'reportGapsAA2NT', 'reportMaskAA2NT', 'splitAlignment', 'translateNT2AA',
      'trimAlignment', 'trimNonHomologousFragments', 'trimSequences'."
    inputBinding:
      position: 103
      prefix: -prog
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress verbose output.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_alignment
    type:
      - 'null'
      - File
    doc: Output file name for the enriched alignment in FASTA format.
    outputBinding:
      glob: $(inputs.output_alignment)
  - id: output_mask
    type:
      - 'null'
      - File
    doc: Output file name for the mask of the enriched alignment.
    outputBinding:
      glob: $(inputs.output_mask)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
