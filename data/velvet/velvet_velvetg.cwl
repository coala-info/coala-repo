cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvetg
label: velvet_velvetg
doc: "de Bruijn graph construction, error removal and repeat resolution\n\nTool homepage:
  https://github.com/dzerbino/velvet"
inputs:
  - id: directory
    type: Directory
    doc: working directory name
    inputBinding:
      position: 1
  - id: alignments
    type:
      - 'null'
      - string
    doc: export a summary of contig alignment to the reference sequences
    inputBinding:
      position: 102
      prefix: -alignments
  - id: amos_file
    type:
      - 'null'
      - string
    doc: export assembly to AMOS file
    inputBinding:
      position: 102
      prefix: -amos_file
  - id: clean
    type:
      - 'null'
      - string
    doc: remove all the intermediary files which are useless for recalculation
    inputBinding:
      position: 102
      prefix: -clean
  - id: conserveLong
    type:
      - 'null'
      - string
    doc: preserve sequences with long reads in them
    inputBinding:
      position: 102
      prefix: -conserveLong
  - id: cov_cutoff
    type:
      - 'null'
      - float
    doc: removal of low coverage nodes AFTER tour bus or allow the system to 
      infer it
    inputBinding:
      position: 102
      prefix: -cov_cutoff
  - id: coverage_mask
    type:
      - 'null'
      - int
    doc: minimum coverage required for confident regions of contigs
    inputBinding:
      position: 102
      prefix: -coverage_mask
  - id: exp_cov
    type:
      - 'null'
      - float
    doc: expected coverage of unique regions or allow the system to infer it
    inputBinding:
      position: 102
      prefix: -exp_cov
  - id: exportFiltered
    type:
      - 'null'
      - string
    doc: export the long nodes which were eliminated by the coverage filters
    inputBinding:
      position: 102
      prefix: -exportFiltered
  - id: ins_length
    type:
      - 'null'
      - int
    doc: expected distance between two paired end reads
    inputBinding:
      position: 102
      prefix: -ins_length
  - id: ins_length_long
    type:
      - 'null'
      - int
    doc: expected distance between two long paired-end reads
    inputBinding:
      position: 102
      prefix: -ins_length_long
  - id: ins_length_star
    type:
      - 'null'
      - int
    doc: expected distance between two paired-end reads in the respective 
      short-read dataset
    inputBinding:
      position: 102
      prefix: -ins_length*
  - id: ins_length_star_sd
    type:
      - 'null'
      - int
    doc: est. standard deviation of respective dataset
    inputBinding:
      position: 102
      prefix: -ins_length*_sd
  - id: long_cov_cutoff
    type:
      - 'null'
      - float
    doc: removal of nodes with low long-read coverage AFTER tour bus
    inputBinding:
      position: 102
      prefix: -long_cov_cutoff
  - id: long_mult_cutoff
    type:
      - 'null'
      - int
    doc: minimum number of long reads required to merge contigs
    inputBinding:
      position: 102
      prefix: -long_mult_cutoff
  - id: max_branch_length
    type:
      - 'null'
      - int
    doc: maximum length in base pair of bubble
    inputBinding:
      position: 102
      prefix: -max_branch_length
  - id: max_coverage
    type:
      - 'null'
      - float
    doc: removal of high coverage nodes AFTER tour bus
    inputBinding:
      position: 102
      prefix: -max_coverage
  - id: max_divergence
    type:
      - 'null'
      - float
    doc: maximum divergence rate between two branches in a bubble
    inputBinding:
      position: 102
      prefix: -max_divergence
  - id: max_gap_count
    type:
      - 'null'
      - int
    doc: maximum number of gaps allowed in the alignment of the two branches of 
      a bubble
    inputBinding:
      position: 102
      prefix: -max_gap_count
  - id: min_contig_lgth
    type:
      - 'null'
      - int
    doc: minimum contig length exported to contigs.fa file
    inputBinding:
      position: 102
      prefix: -min_contig_lgth
  - id: min_pair_count
    type:
      - 'null'
      - int
    doc: minimum number of paired end connections to justify the scaffolding of 
      two long contigs
    inputBinding:
      position: 102
      prefix: -min_pair_count
  - id: paired_exp_fraction
    type:
      - 'null'
      - float
    doc: remove all the paired end connections which less than the specified 
      fraction of the expected count
    inputBinding:
      position: 102
      prefix: -paired_exp_fraction
  - id: read_trkg
    type:
      - 'null'
      - string
    doc: tracking of short read positions in assembly
    inputBinding:
      position: 102
      prefix: -read_trkg
  - id: scaffolding
    type:
      - 'null'
      - string
    doc: scaffolding of contigs used paired end information
    inputBinding:
      position: 102
      prefix: -scaffolding
  - id: shortMatePaired_star
    type:
      - 'null'
      - string
    doc: for mate-pair libraries, indicate that the library might be 
      contaminated with paired-end reads
    inputBinding:
      position: 102
      prefix: -shortMatePaired*
  - id: unused_reads
    type:
      - 'null'
      - string
    doc: export unused reads in UnusedReads.fa file
    inputBinding:
      position: 102
      prefix: -unused_reads
  - id: very_clean
    type:
      - 'null'
      - string
    doc: remove all the intermediary files (no recalculation possible)
    inputBinding:
      position: 102
      prefix: -very_clean
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velvet:1.2.10--h577a1d6_9
stdout: velvet_velvetg.out
