cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-velvetg
label: metavelvet_meta-velvetg
doc: "meta-velvetg - contiging and scaffolding program for metagenomics NGS data. It
  splits the de Bruijn graph built by velveth and velvetg into per-species sub-graphs.\n\nTool
  homepage: https://metavelvet.dna.bio.keio.ac.jp/"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.directory.basename)
        entry: $(inputs.directory)
        writable: true
inputs:
  - id: directory
    type: Directory
    doc: "Directory made by velveth and velvetg (holds Roadmaps, Sequences, Graph2 and
      LastGraph). meta-velvetg writes its results into it."
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: discard_chimera
    type: ['null', string]
    doc: "discard chimera sub-graph, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -discard_chimera
  - id: max_chimera_rate
    type: ['null', double]
    doc: "maximum allowable chimera rate (default: 0.0)"
    inputBinding:
      position: 101
      prefix: -max_chimera_rate
  - id: repeat_cov_sd
    type: ['null', double]
    doc: "standard deviation of repeat node coverages (default: 0.1)"
    inputBinding:
      position: 101
      prefix: -repeat_cov_sd
  - id: min_split_length
    type: ['null', int]
    doc: "minimum node length required for repeat resolution (default: 0)"
    inputBinding:
      position: 101
      prefix: -min_split_length
  - id: valid_connections
    type: ['null', int]
    doc: "minimum allowable number of consistent paired-end connections (default: 1)"
    inputBinding:
      position: 101
      prefix: -valid_connections
  - id: noise_connections
    type: ['null', int]
    doc: "maximum allowable number of inconsistent paired-end connections (default: 0)"
    inputBinding:
      position: 101
      prefix: -noise_connections
  - id: use_connections
    type: ['null', string]
    doc: "use paired-end connections for graph splitting, yes or no (default: yes)"
    inputBinding:
      position: 101
      prefix: -use_connections
  - id: report_split_detail
    type: ['null', string]
    doc: "report sequences around repeat nodes, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -report_split_detail
  - id: report_subgraph
    type: ['null', string]
    doc: "report node sequences for each subgraph, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -report_subgraph
  - id: exp_covs
    type: ['null', string]
    doc: "expected coverages for each species in the microbiome, sorted in descending order, joined by _ (default: auto)"
    inputBinding:
      position: 101
      prefix: -exp_covs
  - id: min_peak_cov
    type: ['null', double]
    doc: "minimum peak coverage (default: 0)"
    inputBinding:
      position: 101
      prefix: -min_peak_cov
  - id: max_peak_cov
    type: ['null', double]
    doc: "maximum peak coverage (default: 500)"
    inputBinding:
      position: 101
      prefix: -max_peak_cov
  - id: histo_bin_width
    type: ['null', double]
    doc: "bin width of peak coverage histogram (default: 1)"
    inputBinding:
      position: 101
      prefix: -histo_bin_width
  - id: histo_sn_ratio
    type: ['null', double]
    doc: "signal-noise ratio to remove peak noises (default: 10)"
    inputBinding:
      position: 101
      prefix: -histo_sn_ratio
  - id: cov_cutoff
    type: ['null', string]
    doc: "removal of low coverage nodes AFTER tour bus, a number or auto (default: auto)"
    inputBinding:
      position: 101
      prefix: -cov_cutoff
  - id: max_coverage
    type: ['null', double]
    doc: "removal of high coverage nodes AFTER tour bus (default: no removal)"
    inputBinding:
      position: 101
      prefix: -max_coverage
  - id: long_cov_cutoff
    type: ['null', double]
    doc: "removal of nodes with low long-read coverage AFTER tour bus (default: no removal)"
    inputBinding:
      position: 101
      prefix: -long_cov_cutoff
  - id: max_branch_length
    type: ['null', int]
    doc: "maximum length in base pair of bubble (default: 100)"
    inputBinding:
      position: 101
      prefix: -max_branch_length
  - id: max_divergence
    type: ['null', double]
    doc: "maximum divergence rate between two branches in a bubble (default: 0.2)"
    inputBinding:
      position: 101
      prefix: -max_divergence
  - id: max_gap_count
    type: ['null', int]
    doc: "maximum number of gaps allowed in the alignment of the two branches of a bubble (default: 3)"
    inputBinding:
      position: 101
      prefix: -max_gap_count
  - id: min_contig_lgth
    type: ['null', int]
    doc: "minimum contig length exported to contigs.fa file (default: hash length * 2)"
    inputBinding:
      position: 101
      prefix: -min_contig_lgth
  - id: scaffolding
    type: ['null', string]
    doc: "scaffolding of contigs using paired end information, yes or no (default: on)"
    inputBinding:
      position: 101
      prefix: -scaffolding
  - id: exp_cov
    type: ['null', string]
    doc: "expected coverage of unique regions, a number or auto (default: auto)"
    inputBinding:
      position: 101
      prefix: -exp_cov
  - id: ins_length
    type: ['null', double]
    doc: "expected distance between two paired end reads for the category (default: no read pairing)"
    inputBinding:
      position: 101
      prefix: -ins_length
  - id: ins_length_sd
    type: ['null', double]
    doc: "standard deviation of insert length for the category (default: insert length / 10)"
    inputBinding:
      position: 101
      prefix: -ins_length_sd
  - id: ins_length2
    type: ['null', double]
    doc: "expected distance between two paired end reads for the second category (default: no read pairing)"
    inputBinding:
      position: 101
      prefix: -ins_length2
  - id: ins_length2_sd
    type: ['null', double]
    doc: "standard deviation of insert length for the second category (default: insert length / 10)"
    inputBinding:
      position: 101
      prefix: -ins_length2_sd
  - id: ins_length_long
    type: ['null', double]
    doc: "expected distance between two long paired-end reads (default: no read pairing)"
    inputBinding:
      position: 101
      prefix: -ins_length_long
  - id: ins_length_long_sd
    type: ['null', double]
    doc: "standard deviation of insert length for the long paired-end category"
    inputBinding:
      position: 101
      prefix: -ins_length_long_sd
  - id: min_pair_count
    type: ['null', int]
    doc: "minimum number of paired end connections to justify the scaffolding of two long contigs (default: 5)"
    inputBinding:
      position: 101
      prefix: -min_pair_count
  - id: long_mult_cutoff
    type: ['null', int]
    doc: "minimum number of long reads required to merge contigs (default: 2)"
    inputBinding:
      position: 101
      prefix: -long_mult_cutoff
  - id: short_mate_paired
    type: ['null', string]
    doc: "for mate-pair libraries, indicate that the library might be contaminated with paired-end reads, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -shortMatePaired
  - id: amos_file
    type: ['null', string]
    doc: "export assembly to AMOS file, yes or no (default: no export)"
    inputBinding:
      position: 101
      prefix: -amos_file
  - id: coverage_mask
    type: ['null', int]
    doc: "minimum coverage required for confident regions of contigs (default: 1)"
    inputBinding:
      position: 101
      prefix: -coverage_mask
  - id: unused_reads
    type: ['null', string]
    doc: "export unused reads in UnusedReads.fa file, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -unused_reads
  - id: alignments
    type: ['null', string]
    doc: "export a summary of contig alignment to the reference sequences, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -alignments
  - id: export_filtered
    type: ['null', string]
    doc: "export the long nodes eliminated by the coverage filters, yes or no (default: no)"
    inputBinding:
      position: 101
      prefix: -exportFiltered
  - id: paired_exp_fraction
    type: ['null', double]
    doc: "remove all paired end connections below this fraction of the expected count (default: 0.1)"
    inputBinding:
      position: 101
      prefix: -paired_exp_fraction
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the meta-velvetg results (meta-velvetg.contigs.fa, meta-velvetg.LastGraph, stats files)
    outputBinding:
      glob: $(inputs.directory.basename)
  - id: contigs
    type: File
    doc: FASTA file of contigs
    outputBinding:
      glob: $(inputs.directory.basename)/meta-velvetg.contigs.fa
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet:1.2.02--1
stdout: metavelvet_meta-velvetg.out
