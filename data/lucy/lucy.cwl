cwlVersion: v1.2
class: CommandLineTool
baseCommand: lucy
label: lucy
doc: "Less Useful Chunks Yank (lucy): cleans raw DNA sequence reads (quality trimming, splice site and vector removal, optional poly-A/T trimming) for sequence assembly.\n\nTool homepage: https://lucy.sourceforge.net/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sequence_file
    type: File
    doc: Sequence file (FASTA)
    inputBinding:
      position: 200
  - id: quality_file
    type: File
    doc: Quality file (FASTA-style quality values)
    inputBinding:
      position: 201
  - id: second_sequence_file
    type:
      - 'null'
      - File
    doc: Optional second sequence file (from a different base caller), used to extend good quality regions
    inputBinding:
      position: 202
  - id: pass_along
    type:
      - 'null'
      - type: array
        items: int
    doc: Three clone length values (min_value max_value med_value) copied into the output headers
    inputBinding:
      position: 100
      prefix: -pass_along
  - id: range
    type:
      - 'null'
      - type: array
        items: int
    doc: Three splice site checking areas (area1 area2 area3), default 40 60 100
    inputBinding:
      position: 100
      prefix: -range
  - id: alignment
    type:
      - 'null'
      - type: array
        items: int
    doc: Three alignment strengths for the checking areas (area1 area2 area3), default 8 12 16
    inputBinding:
      position: 100
      prefix: -alignment
  - id: vector_sequence_file
    type:
      - 'null'
      - File
    doc: Complete vector sequence file; give together with splice_site_file
    inputBinding:
      position: 100
      prefix: -vector
  - id: splice_site_file
    type:
      - 'null'
      - File
    doc: Partial splice site sequence file; give together with vector_sequence_file
    inputBinding:
      position: 101
  - id: cdna
    type:
      - 'null'
      - boolean
    doc: Trim poly-A/T tails and heads (cDNA mode)
    inputBinding:
      position: 102
      prefix: -cdna
  - id: cdna_parameters
    type:
      - 'null'
      - type: array
        items: int
    doc: With cdna, all three values minimum_span maximum_error initial_search_range (defaults 10 3 50)
    inputBinding:
      position: 103
  - id: keep
    type:
      - 'null'
      - boolean
    doc: With cdna, keep the poly-A/T tails and heads
    inputBinding:
      position: 104
      prefix: -keep
  - id: size
    type:
      - 'null'
      - int
    doc: Size of fragments for vector checking, 8 to 16 (default 10)
    inputBinding:
      position: 104
      prefix: -size
  - id: threshold
    type:
      - 'null'
      - float
    doc: Vector similarity cutoff for discarding a sequence as a vector insert (default 0.2)
    inputBinding:
      position: 104
      prefix: -threshold
  - id: minimum
    type:
      - 'null'
      - int
    doc: Minimum good sequence length (default 100)
    inputBinding:
      position: 104
      prefix: -minimum
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Write a sequence cleavage information file (default name lucy.debug)
    inputBinding:
      position: 105
      prefix: -debug
  - id: debug_file
    type:
      - 'null'
      - string
    doc: Name of the cleavage information file written with debug
    inputBinding:
      position: 106
  - id: output_sequence
    type:
      - 'null'
      - string
    doc: Output sequence file name (default lucy.seq); give together with output_quality
    inputBinding:
      position: 107
      prefix: -output
  - id: output_quality
    type:
      - 'null'
      - string
    doc: Output quality file name (default lucy.qul); give together with output_sequence
    inputBinding:
      position: 108
  - id: error
    type:
      - 'null'
      - type: array
        items: float
    doc: Two values, max_avg_error and max_error_at_ends (defaults 0.025 0.02)
    inputBinding:
      position: 109
      prefix: -error
  - id: window
    type:
      - 'null'
      - type: array
        items: float
    doc: Pairs of window_size max_avg_error in decreasing window size, up to 20 windows (defaults 50 0.08 10 0.3)
    inputBinding:
      position: 110
      prefix: -window
  - id: bracket
    type:
      - 'null'
      - type: array
        items: float
    doc: Two values, window_size and max_avg_error (defaults 10 0.02)
    inputBinding:
      position: 111
      prefix: -bracket
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only report serious errors
    inputBinding:
      position: 112
      prefix: -quiet
  - id: inform_me
    type:
      - 'null'
      - boolean
    doc: Report sequences thrown out for low quality or salvaged by the second sequence file
    inputBinding:
      position: 113
      prefix: -inform_me
  - id: xtra
    type:
      - 'null'
      - int
    doc: Number of CPU threads (maximum 32)
    inputBinding:
      position: 114
      prefix: -xtra
outputs:
  - id: cleaned_sequences
    type: File
    doc: Cleaned sequence file with good-region markers
    outputBinding:
      glob: "$(inputs.output_sequence ? inputs.output_sequence : 'lucy.seq')"
  - id: cleaned_qualities
    type: File
    doc: Companion quality file
    outputBinding:
      glob: "$(inputs.output_quality ? inputs.output_quality : 'lucy.qul')"
  - id: cleavage_info
    type:
      - 'null'
      - File
    doc: Cleavage information file (written with debug)
    outputBinding:
      glob: "$(inputs.debug_file ? inputs.debug_file : 'lucy.debug')"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lucy:v1.20-1-deb_cv1
stdout: lucy.out
