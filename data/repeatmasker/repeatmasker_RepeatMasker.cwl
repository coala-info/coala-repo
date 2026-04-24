cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepeatMasker
label: repeatmasker_RepeatMasker
doc: "RepeatMasker is a program that screens DNA sequences for interspersed repeats
  and low complexity DNA sequences. The output of the program is a detailed annotation
  of the repeats that are present in the query sequence as well as a modified version
  of the query sequence in which all the annotated repeats have been masked (default:
  replaced by Ns). Sequence comparisons in RepeatMasker are performed by the program
  cross_match, an efficient implementation of the Smith-Waterman-Gotoh algorithm developed
  by Phil Green, or by WU-Blast developed by Warren Gish.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs:
  - id: input_sequences
    type:
      type: array
      items: File
    doc: FASTA format sequences or raw sequence files to be masked.
    inputBinding:
      position: 1
  - id: ace
    type:
      - 'null'
      - boolean
    doc: Creates an additional output file in ACeDB format.
    inputBinding:
      position: 102
      prefix: -ace
  - id: alignments
    type:
      - 'null'
      - boolean
    doc: Shows the alignments in a .align output file.
    inputBinding:
      position: 102
      prefix: -ali
  - id: alu
    type:
      - 'null'
      - boolean
    doc: Only masks Alus (and 7SLRNA, SVA and LTR5) (only for primate DNA).
    inputBinding:
      position: 102
      prefix: -alu
  - id: crossmatch_output
    type:
      - 'null'
      - boolean
    doc: Creates an additional output file in cross_match format (for parsing).
    inputBinding:
      position: 102
      prefix: -xm
  - id: custom_library
    type:
      - 'null'
      - File
    doc: Allows the use of a custom library of sequences to be masked in the 
      query. The library file needs to contain sequences in FASTA format.
    inputBinding:
      position: 102
      prefix: -lib
  - id: cut
    type:
      - 'null'
      - boolean
    doc: Saves a sequence (in file.cut) from which full-length repeats are 
      excised (temporarily disfunctional).
    inputBinding:
      position: 102
      prefix: -cut
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Sets cutoff score for masking repeats when using -lib. Lowering it 
      below 200 will usually start to give you significant numbers of false 
      matches, raising it to 250 will guarantee that all matches are real.
    inputBinding:
      position: 102
      prefix: -cutoff
  - id: div
    type:
      - 'null'
      - int
    doc: Masks only those repeats that are less than [number] percent diverged 
      from the consensus sequence.
    inputBinding:
      position: 102
      prefix: -div
  - id: engine
    type:
      - 'null'
      - string
    doc: 'Select a non-default search engine to use. Options: crossmatch, wublast,
      decypher.'
    inputBinding:
      position: 102
      prefix: -engine
  - id: excln
    type:
      - 'null'
      - boolean
    doc: Calculates repeat densities (in .tbl) excluding runs of >25 Ns in 
      query.
    inputBinding:
      position: 102
      prefix: -e
  - id: fixed_width_output
    type:
      - 'null'
      - boolean
    doc: Creates an (old style) annotation file with fixed width columns.
    inputBinding:
      position: 102
      prefix: -fixed
  - id: frag
    type:
      - 'null'
      - int
    doc: Maximum sequence length masked without fragmenting.
    inputBinding:
      position: 102
      prefix: -frag
  - id: gc
    type:
      - 'null'
      - int
    doc: Use matrices calculated for 'number' percentage background GC level.
    inputBinding:
      position: 102
      prefix: -gc
  - id: gccalc
    type:
      - 'null'
      - boolean
    doc: Program calculates the GC content even for batch files/small sequences.
    inputBinding:
      position: 102
      prefix: -gccalc
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Creates an additional General Feature Finding format output.
    inputBinding:
      position: 102
      prefix: -gff
  - id: int
    type:
      - 'null'
      - boolean
    doc: Only masks low complex/simple repeats (no interspersed repeats).
    inputBinding:
      position: 102
      prefix: -int
  - id: invert_orientation
    type:
      - 'null'
      - boolean
    doc: Alignments are presented in the orientation of the repeat (with option 
      -a).
    inputBinding:
      position: 102
      prefix: -inv
  - id: is_clip
    type:
      - 'null'
      - boolean
    doc: 'Clips IS elements before analysis (default: IS only reported).'
    inputBinding:
      position: 102
      prefix: -is_clip
  - id: is_only
    type:
      - 'null'
      - boolean
    doc: Only clips E coli insertion elements out of FASTA and .qual files.
    inputBinding:
      position: 102
      prefix: -is_only
  - id: low
    type:
      - 'null'
      - boolean
    doc: Same as nolow (historical). Only interspersed repeats are masked.
    inputBinding:
      position: 102
      prefix: -l
  - id: no_id
    type:
      - 'null'
      - boolean
    doc: Leaves out final column with unique ID for each element.
    inputBinding:
      position: 102
      prefix: -no_id
  - id: no_is
    type:
      - 'null'
      - boolean
    doc: Skips bacterial insertion element check.
    inputBinding:
      position: 102
      prefix: -no_is
  - id: nocut
    type:
      - 'null'
      - boolean
    doc: Skips the steps in which repeats are excised.
    inputBinding:
      position: 102
      prefix: -nocut
  - id: noint
    type:
      - 'null'
      - boolean
    doc: Skips steps specific to interspersed repeats, saving lots of time. Only
      low complexity DNA and simple repeats will be masked.
    inputBinding:
      position: 102
      prefix: -noint
  - id: noisy
    type:
      - 'null'
      - boolean
    doc: Prints cross_match progress report to screen (defaults to .stderr 
      file).
    inputBinding:
      position: 102
      prefix: -noisy
  - id: nolow
    type:
      - 'null'
      - boolean
    doc: Does not mask low complexity DNA or simple repeats. Only interspersed 
      repeats are masked.
    inputBinding:
      position: 102
      prefix: -nolow
  - id: norna
    type:
      - 'null'
      - boolean
    doc: Leaves small pol III transcribed RNAs (mostly tRNAs and snRNAs) 
      unmasked, while still masking SINEs.
    inputBinding:
      position: 102
      prefix: -norna
  - id: parallel
    type:
      - 'null'
      - int
    doc: Number of processors to use in parallel (only works for batch files or 
      sequences larger than 50 kb).
    inputBinding:
      position: 102
      prefix: -pa
  - id: poly
    type:
      - 'null'
      - boolean
    doc: Reports simple repeats that may be polymorphic (in file.poly).
    inputBinding:
      position: 102
      prefix: -poly
  - id: primspec
    type:
      - 'null'
      - boolean
    doc: Only checks for primate specific repeats (no RepeatMasker run).
    inputBinding:
      position: 102
      prefix: -primspec
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Quick search; 5-10% less sensitive, 3-4 times faster than default.
    inputBinding:
      position: 102
      prefix: -q
  - id: rodspec
    type:
      - 'null'
      - boolean
    doc: Only checks for rodent specific repeats (no RepeatMasker run).
    inputBinding:
      position: 102
      prefix: -rodspec
  - id: rush
    type:
      - 'null'
      - boolean
    doc: Rush job; about 10% less sensitive.
    inputBinding:
      position: 102
      prefix: -qq
  - id: slow
    type:
      - 'null'
      - boolean
    doc: Slow search; 0-5% more sensitive, 2.5 times slower than default.
    inputBinding:
      position: 102
      prefix: -s
  - id: small
    type:
      - 'null'
      - boolean
    doc: Returns complete .masked sequence in lower case.
    inputBinding:
      position: 102
      prefix: -small
  - id: species
    type:
      - 'null'
      - string
    doc: Indicate source species of query DNA. Capitalization is ignored, 
      multiple words need to be bound by apostrophes.
    inputBinding:
      position: 102
      prefix: -species
  - id: unprocessed_output
    type:
      - 'null'
      - boolean
    doc: Creates an untouched annotation file besides the manipulated file.
    inputBinding:
      position: 102
      prefix: -u
  - id: wublast
    type:
      - 'null'
      - boolean
    doc: Use WU-blast, rather than cross_match as engine. DEPRECATED. Use 
      -engine [crossmatch|wublast|decypher] now.
    inputBinding:
      position: 102
      prefix: -w
  - id: x
    type:
      - 'null'
      - boolean
    doc: Returns repetitive regions masked with Xs instead of Ns.
    inputBinding:
      position: 102
      prefix: -x
  - id: xsmall
    type:
      - 'null'
      - boolean
    doc: Returns repetitive regions in lowercase rather than masked.
    inputBinding:
      position: 102
      prefix: -xsmall
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmasker:4.2.2--pl5321hdfd78af_0
stdout: repeatmasker_RepeatMasker.out
