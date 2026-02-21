cwlVersion: v1.2
class: CommandLineTool
baseCommand: aragorn
label: aragorn
doc: "Detects tRNA, mtRNA, and tmRNA genes in nucleotide sequences.\n\nTool homepage:
  http://www.ansikte.se/ARAGORN/"
inputs:
  - id: filename
    type: File
    doc: Input file containing one or more sequences in FASTA or GENBANK format.
    inputBinding:
      position: 1
  - id: batch_mode
    type:
      - 'null'
      - boolean
    doc: Print out in batch mode.
    inputBinding:
      position: 102
      prefix: -w
  - id: c_loop_7
    type:
      - 'null'
      - boolean
    doc: Search for tRNA genes with 7 base C-loops only.
    inputBinding:
      position: 102
      prefix: -c7
  - id: circular_topology
    type:
      - 'null'
      - boolean
    doc: Assume that each sequence has a circular topology. Search wraps around each
      end. Default setting.
    inputBinding:
      position: 102
      prefix: -c
  - id: display_4_base_3prime
    type:
      - 'null'
      - boolean
    doc: Display 4-base sequence on 3' end of astem regardless of predicted amino-acyl
      acceptor length.
    inputBinding:
      position: 102
      prefix: -j
  - id: double_strand
    type:
      - 'null'
      - boolean
    doc: Search both strands of each sequence. Default setting.
    inputBinding:
      position: 102
      prefix: -d
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: Print out primary sequence in fasta format.
    inputBinding:
      position: 102
      prefix: -fasta
  - id: fasta_only
    type:
      - 'null'
      - boolean
    doc: Print out primary sequence in fasta format only (no secondary structure).
    inputBinding:
      position: 102
      prefix: -fo
  - id: flag_pseudogenes
    type:
      - 'null'
      - int
    doc: Flag possible pseudogenes and optionally change score threshold to <num>
      percent.
    inputBinding:
      position: 102
      prefix: -rp
  - id: gc_metazoan
    type:
      - 'null'
      - boolean
    doc: Use composite Metazoan mitochondrial genetic code.
    inputBinding:
      position: 102
      prefix: -gcmet
  - id: gc_standard
    type:
      - 'null'
      - boolean
    doc: Use standard genetic code.
    inputBinding:
      position: 102
      prefix: -gcstd
  - id: gc_vertebrate
    type:
      - 'null'
      - boolean
    doc: Use Vertebrate mitochondrial genetic code.
    inputBinding:
      position: 102
      prefix: -gcvert
  - id: generate_svg
    type:
      - 'null'
      - boolean
    doc: Generate SVG image file code for secondary structure.
    inputBinding:
      position: 102
      prefix: -svg
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: Use the GenBank transl_table = <num> genetic code.
    inputBinding:
      position: 102
      prefix: -gc
  - id: introns
    type:
      - 'null'
      - string
    doc: Search for tRNA genes with introns. Can specify <max> or <min>,<max>.
    inputBinding:
      position: 102
      prefix: -i
  - id: introns_fixed
    type:
      - 'null'
      - boolean
    doc: Fix intron between positions 37 and 38 on C-loop.
    inputBinding:
      position: 102
      prefix: -if
  - id: introns_fixed_overlap
    type:
      - 'null'
      - boolean
    doc: Same as -if and -io combined.
    inputBinding:
      position: 102
      prefix: -ifo
  - id: introns_overlap
    type:
      - 'null'
      - boolean
    doc: Allow tRNA genes with long introns to overlap shorter tRNA genes.
    inputBinding:
      position: 102
      prefix: -io
  - id: linear_topology
    type:
      - 'null'
      - boolean
    doc: Assume that each sequence has a linear topology. Search does not wrap.
    inputBinding:
      position: 102
      prefix: -l
  - id: lower_thresholds
    type:
      - 'null'
      - int
    doc: Lower scoring thresholds to specified percent of default levels (default
      95%).
    inputBinding:
      position: 102
      prefix: -ps
  - id: mammalian_mitochondrial
    type:
      - 'null'
      - boolean
    doc: Search for Mammalian mitochondrial tRNA genes.
    inputBinding:
      position: 102
      prefix: -mtmam
  - id: metazoan_mitochondrial
    type:
      - 'null'
      - boolean
    doc: Search for Metazoan mitochondrial tRNA genes.
    inputBinding:
      position: 102
      prefix: -mt
  - id: metazoan_mitochondrial_no_low_score
    type:
      - 'null'
      - boolean
    doc: Same as -mt but low scoring tRNA genes are not reported.
    inputBinding:
      position: 102
      prefix: -mtx
  - id: metazoan_mitochondrial_overlapping
    type:
      - 'null'
      - boolean
    doc: Overlapping metazoan mitochondrial tRNA genes on opposite strands are reported.
    inputBinding:
      position: 102
      prefix: -mtd
  - id: no_tv_loop
    type:
      - 'null'
      - boolean
    doc: Do not search for mitochondrial TV replacement loop tRNA genes. Only relevant
      if -mt used.
    inputBinding:
      position: 102
      prefix: -tv
  - id: print_score
    type:
      - 'null'
      - boolean
    doc: Print out score for each reported gene.
    inputBinding:
      position: 102
      prefix: -e
  - id: print_sequence
    type:
      - 'null'
      - boolean
    doc: Print out primary sequence.
    inputBinding:
      position: 102
      prefix: -seq
  - id: print_tmrna_domain
    type:
      - 'null'
      - boolean
    doc: Print out tRNA domain for tmRNA genes.
    inputBinding:
      position: 102
      prefix: -a
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Dont print configuration line.
    inputBinding:
      position: 102
      prefix: -q
  - id: repeat_name
    type:
      - 'null'
      - boolean
    doc: Repeat sequence name before summary information.
    inputBinding:
      position: 102
      prefix: -rn
  - id: search_tmrna
    type:
      - 'null'
      - boolean
    doc: Search for tmRNA genes.
    inputBinding:
      position: 102
      prefix: -m
  - id: search_trna
    type:
      - 'null'
      - boolean
    doc: Search for tRNA genes.
    inputBinding:
      position: 102
      prefix: -t
  - id: show_secondary_structure
    type:
      - 'null'
      - boolean
    doc: Show secondary structure using round brackets.
    inputBinding:
      position: 102
      prefix: -br
  - id: single_complementary_strand
    type:
      - 'null'
      - boolean
    doc: Single complementary. Do not search the sense strand of each sequence.
    inputBinding:
      position: 102
      prefix: -sc
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Single. Do not search the complementary (antisense) strand of each sequence.
    inputBinding:
      position: 102
      prefix: -s
  - id: strict_spacers
    type:
      - 'null'
      - boolean
    doc: Use the stricter canonical 1-2 bp spacer1 and 1 bp spacer2.
    inputBinding:
      position: 102
      prefix: -ss
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose. Prints out information during search to STDERR.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Print output to <outfile>.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aragorn:1.2.41--h7b50bb2_5
