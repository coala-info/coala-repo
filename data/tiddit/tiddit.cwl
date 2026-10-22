cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tiddit
  - --sv
label: tiddit
doc: "TIDDIT structural variant caller: call structural variation from a coordinate sorted BAM file.\n\nTool homepage: https://github.com/SciLifeLab/TIDDIT"
inputs:
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "force the analysis and overwrite any data in the output folder"
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: "coordinate sorted bam file(required)"
    inputBinding:
      position: 101
      prefix: --bam
  - id: ref
    type: File
    secondaryFiles:
      - pattern: .fai
        required: true
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
    doc: "reference fasta"
    inputBinding:
      position: 101
      prefix: --ref
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "output prefix(default=output)"
    inputBinding:
      position: 101
      prefix: -o
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: "paired reads maximum allowed insert size. Pairs aligning on the same chr at a distance higher than this are considered candidates for SV (default= 99.9th percentile of insert size)"
    inputBinding:
      position: 101
      prefix: -i
  - id: orientation
    type:
      - 'null'
      - string
    doc: "expected reads orientations, possible values \"innie\" (-> <-) or \"outtie\" (<- ->). Default: major orientation within the dataset"
    inputBinding:
      position: 101
      prefix: -d
  - id: min_pairs
    type:
      - 'null'
      - int
    doc: "Minimum number of supporting pairs in order to call a variant (default 3)"
    inputBinding:
      position: 101
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default=1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: min_split_reads
    type:
      - 'null'
      - int
    doc: "Minimum number of supporting split reads to call a variant (default 3)"
    inputBinding:
      position: 101
      prefix: -r
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality to consider an alignment (default 5)"
    inputBinding:
      position: 101
      prefix: -q
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "the ploidy of the organism,(default = 2)"
    inputBinding:
      position: 101
      prefix: -n
  - id: cluster_distance
    type:
      - 'null'
      - int
    doc: "clustering distance parameter, discordant pairs closer than this distance are considered to belong to the same variant(default = sqrt(insert-size*2)*12)"
    inputBinding:
      position: 101
      prefix: -e
  - id: average_coverage
    type:
      - 'null'
      - float
    doc: "average coverage, overwrites the estimated average coverage (useful for exome or panel data)"
    inputBinding:
      position: 101
      prefix: -c
  - id: min_pts
    type:
      - 'null'
      - int
    doc: "min-pts parameter (default=3),must be set >= 2"
    inputBinding:
      position: 101
      prefix: -l
  - id: sample_reads
    type:
      - 'null'
      - int
    doc: "Number of reads to sample when computing library statistics(default=25000000)"
    inputBinding:
      position: 101
      prefix: -s
  - id: force_ploidy
    type:
      - 'null'
      - boolean
    doc: "force the ploidy to be set to -n across the entire genome (i.e skip coverage normalisation of chromosomes)"
    inputBinding:
      position: 101
      prefix: --force_ploidy
  - id: n_mask
    type:
      - 'null'
      - float
    doc: "exclude regions from coverage calculation if they contain more than this fraction of N (default = 0.5)"
    inputBinding:
      position: 101
      prefix: --n_mask
  - id: p_ratio
    type:
      - 'null'
      - float
    doc: "minimum discordant pair/normal pair ratio at the breakpoint junction(default=0.1)"
    inputBinding:
      position: 101
      prefix: --p_ratio
  - id: r_ratio
    type:
      - 'null'
      - float
    doc: "minimum split read/coverage ratio at the breakpoint junction(default=0.1)"
    inputBinding:
      position: 101
      prefix: --r_ratio
  - id: max_coverage
    type:
      - 'null'
      - float
    doc: "filter call if X times higher than chromosome average coverage (default=4)"
    inputBinding:
      position: 101
      prefix: --max_coverage
  - id: min_contig
    type:
      - 'null'
      - int
    doc: "Skip calling on small contigs (default < 10000 bp)"
    inputBinding:
      position: 101
      prefix: --min_contig
  - id: min_variant_size
    type:
      - 'null'
      - int
    doc: "minimum variant size (default=50), variants smaller than this will not be printed ( z < 10 is not recomended)"
    inputBinding:
      position: 101
      prefix: -z
  - id: skip_assembly
    type:
      - 'null'
      - boolean
    doc: "Skip running local assembly, tiddit will perform worse, but wont require bwa and bwa indexed ref, and will complete quicker"
    inputBinding:
      position: 101
      prefix: --skip_assembly
  - id: bwa
    type:
      - 'null'
      - string
    doc: "path to bwa executable file(default=bwa)"
    inputBinding:
      position: 101
      prefix: --bwa
  - id: min_clip
    type:
      - 'null'
      - int
    doc: "Minimum clip reads to initiate local assembly of a region(default=4)"
    inputBinding:
      position: 101
      prefix: --min_clip
  - id: padding
    type:
      - 'null'
      - int
    doc: "Extend the local assembly by this number of bases (default=100bp)"
    inputBinding:
      position: 101
      prefix: --padding
  - id: min_pts_clips
    type:
      - 'null'
      - int
    doc: "min-pts parameter for the clustering of candidates for local assembly (default=3)"
    inputBinding:
      position: 101
      prefix: --min_pts_clips
  - id: max_assembly_reads
    type:
      - 'null'
      - int
    doc: "Skip assembly of regions containing too many reads (default=100000 reads)"
    inputBinding:
      position: 101
      prefix: --max_assembly_reads
  - id: max_local_assembly_region
    type:
      - 'null'
      - int
    doc: "maximum size of the clip read cluster for being considered a local assembly candidate (default=2000 bp)"
    inputBinding:
      position: 101
      prefix: --max_local_assembly_region
  - id: min_anchor_len
    type:
      - 'null'
      - int
    doc: "minimum mapped bases to be considered a clip read (default=60 bp)"
    inputBinding:
      position: 101
      prefix: --min_anchor_len
  - id: min_clip_len
    type:
      - 'null'
      - int
    doc: "minimum clipped bases to be considered a clip read (default=25 bp)"
    inputBinding:
      position: 101
      prefix: --min_clip_len
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: "minimum contig length for SV analysis (default=200 bp)"
    inputBinding:
      position: 101
      prefix: --min_contig_len
  - id: kmer
    type:
      - 'null'
      - int
    doc: "kmer lenght used by the local assembler (default=91 bp)"
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: vcf
    type: File
    doc: "Structural variants in VCF format"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'output')).vcf"
  - id: ploidies
    type:
      - 'null'
      - File
    doc: "Estimated ploidy per contig"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'output')).ploidies.tab"
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: "Intermediate files (signal and assembly folders)"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'output'))_tiddit"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0
