cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circle_map++
  - Realign
label: circle-map-cpp_Realign
doc: "Realign circular DNA read candidates\n\nTool homepage: https://github.com/BGI-Qingdao/Circle-Map-cpp"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_bam)
      - $(inputs.qbam)
      - $(inputs.sbam)
      - $(inputs.fasta)
inputs:
  - id: input_bam
    type: File
    secondaryFiles:
      - .bai
    doc: 'Input: bam file containing the reads extracted by ReadExtractor (coordinate
      sorted and indexed). The tool joins input paths to the working directory, so
      inputs are staged there and passed by name.'
    inputBinding:
      position: 101
      prefix: -i
      valueFrom: $(self.basename)
  - id: qbam
    type: File
    doc: 'Input: query name sorted bam file'
    inputBinding:
      position: 101
      prefix: -qbam
      valueFrom: $(self.basename)
  - id: sbam
    type: File
    secondaryFiles:
      - .bai
    doc: 'Input: coordinate sorted bam file'
    inputBinding:
      position: 101
      prefix: -sbam
      valueFrom: $(self.basename)
  - id: fasta
    type: File
    secondaryFiles:
      - .fai
    doc: 'Input: Reference genome fasta file'
    inputBinding:
      position: 101
      prefix: -fasta
      valueFrom: $(self.basename)
  - id: output
    type: string
    doc: Output filename (the tool requires the short -o form)
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default 1'
    inputBinding:
      position: 101
      prefix: --threads
  - id: directory
    type:
      - 'null'
      - string
    doc: 'Working directory, default will create a tmp_${pid} folder in the working directory and automatically delete it when exit'
    inputBinding:
      position: 101
      prefix: --directory
  - id: no_coverage
    type:
      - 'null'
      - boolean
    doc: 'Don''t compute coverage statistics'
    inputBinding:
      position: 101
      prefix: --no_coverage
  - id: clustering_dist
    type:
      - 'null'
      - int
    doc: 'Cluster reads that are K nucleotides appart in the same node. Default: 500'
    inputBinding:
      position: 101
      prefix: --clustering_dist
  - id: sample_size
    type:
      - 'null'
      - int
    doc: 'Number of concordant reads (R2F1) to use for estimating the insert size distribution. Default 100000'
    inputBinding:
      position: 101
      prefix: --sample_size
  - id: insert_mapq
    type:
      - 'null'
      - int
    doc: 'Mapq cutoff for estimating the insert size distribution. Default 60'
    inputBinding:
      position: 101
      prefix: --insert_mapq
  - id: mean_is_size
    type:
      - 'null'
      - float
    doc: 'mean value of insert size'
    inputBinding:
      position: 101
      prefix: --mean_is_size
  - id: sd_val_insert
    type:
      - 'null'
      - float
    doc: 'SD Value of insert size'
    inputBinding:
      position: 101
      prefix: --sd_val_insert
  - id: std_factor
    type:
      - 'null'
      - float
    doc: 'std_factor, extern realign interval by mIS+sIS*std_factor. (default 4)'
    inputBinding:
      position: 101
      prefix: --std_factor
  - id: mapping_qual
    type:
      - 'null'
      - int
    doc: 'minimum mapping quality (default 20)'
    inputBinding:
      position: 101
      prefix: --mapping_qual
  - id: min_interval_prob
    type:
      - 'null'
      - float
    doc: 'minimum interval probability (default 0.01)'
    inputBinding:
      position: 101
      prefix: --min_interval_prob
  - id: edit_dist_fraction
    type:
      - 'null'
      - float
    doc: 'edit distance fraction (default 0.05)'
    inputBinding:
      position: 101
      prefix: --edit_dist_fraction
  - id: min_softclip_len
    type:
      - 'null'
      - int
    doc: 'minimum softclip length (default 8)'
    inputBinding:
      position: 101
      prefix: --min_softclip_len
  - id: max_aln_num
    type:
      - 'null'
      - int
    doc: 'nhit, maximum alignment number (default 10)'
    inputBinding:
      position: 101
      prefix: --max_aln_num
  - id: penity_gap_open
    type:
      - 'null'
      - int
    doc: 'penity for gap open (default 5)'
    inputBinding:
      position: 101
      prefix: --penity_gap_open
  - id: penity_gap_extern
    type:
      - 'null'
      - int
    doc: 'penity for gap extern (default 1)'
    inputBinding:
      position: 101
      prefix: --penity_gap_extern
  - id: aln_prob
    type:
      - 'null'
      - float
    doc: 'alignment probability (default 0.99)'
    inputBinding:
      position: 101
      prefix: --aln_prob
  - id: merge_fraction
    type:
      - 'null'
      - float
    doc: 'Merge intervals reciprocally overlapping by a fraction. Default 0.99'
    inputBinding:
      position: 101
      prefix: --merge_fraction
  - id: allele_frequency
    type:
      - 'null'
      - float
    doc: 'Minimum allele frequency required to report the circle interval. Default (0.1)'
    inputBinding:
      position: 101
      prefix: --allele_frequency
  - id: number_of_discordants
    type:
      - 'null'
      - int
    doc: 'Number of required discordant reads for intervals with only discordants. Default: 3'
    inputBinding:
      position: 101
      prefix: --number_of_discordants
  - id: split
    type:
      - 'null'
      - int
    doc: 'Number of required split reads to output a eccDNA. Default: 0'
    inputBinding:
      position: 101
      prefix: --split
  - id: split_quality
    type:
      - 'null'
      - float
    doc: 'Minium split score to output an interval. Default (0.0)'
    inputBinding:
      position: 101
      prefix: --split_quality
  - id: bases
    type:
      - 'null'
      - int
    doc: 'Number of bases to extend for computing the coverage ratio. Default: 200'
    inputBinding:
      position: 101
      prefix: --bases
  - id: extension
    type:
      - 'null'
      - int
    doc: 'Number of bases inside the eccDNA breakpoint coordinates to compute the ratio. Default: 100'
    inputBinding:
      position: 101
      prefix: --extension
  - id: ratio
    type:
      - 'null'
      - float
    doc: 'Minimum in/out required coverage ratio. Default: 0.0'
    inputBinding:
      position: 101
      prefix: --ratio
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Circular DNA intervals (BED-like table)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
stdout: circle-map-cpp_Realign.out
