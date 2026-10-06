cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - run
label: ariba_run
doc: "Runs the local assembly pipeline. Input is dir made by prepareref, and paired reads\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: prepareref_dir
    type: Directory
    doc: "Name of output directory when \"ariba prepareref\" was run"
    inputBinding:
      position: 10
  - id: reads_1
    type: File
    doc: "Name of fwd reads fastq file"
    inputBinding:
      position: 11
  - id: reads_2
    type: File
    doc: "Name of rev reads fastq file"
    inputBinding:
      position: 12
  - id: outdir
    type: string
    doc: "Output directory (must not already exist)"
    default: ariba_run_out
    inputBinding:
      position: 13
  - id: nucmer_min_id
    type:
      - 'null'
      - int
    doc: "Minimum alignment identity (delta-filter -i) [90]"
    inputBinding:
      position: 1
      prefix: --nucmer_min_id
  - id: nucmer_min_len
    type:
      - 'null'
      - int
    doc: "Minimum alignment length (delta-filter -i) [20]"
    inputBinding:
      position: 1
      prefix: --nucmer_min_len
  - id: nucmer_breaklen
    type:
      - 'null'
      - int
    doc: "Value to use for -breaklen when running nucmer [200]"
    inputBinding:
      position: 1
      prefix: --nucmer_breaklen
  - id: assembler
    type:
      - 'null'
      - string
    doc: "Assembler to use (fermilite or spades)"
    inputBinding:
      position: 1
      prefix: --assembler
  - id: assembly_cov
    type:
      - 'null'
      - int
    doc: "Target read coverage when sampling reads for assembly [50]"
    inputBinding:
      position: 1
      prefix: --assembly_cov
  - id: min_scaff_depth
    type:
      - 'null'
      - int
    doc: "Minimum number of read pairs needed as evidence for scaffold link between two contigs [10]"
    inputBinding:
      position: 1
      prefix: --min_scaff_depth
  - id: spades_mode
    type:
      - 'null'
      - string
    doc: "If using Spades assembler, either use default WGS mode, Single Cell mode or RNA mode (wgs, sc, rna)"
    inputBinding:
      position: 1
      prefix: --spades_mode
  - id: spades_options
    type:
      - 'null'
      - string
    doc: "Extra options to pass to Spades assembler. Anything set here will replace the defaults completely"
    inputBinding:
      position: 1
      prefix: --spades_options
  - id: threads
    type:
      - 'null'
      - int
    doc: "Experimental. Number of threads. Will run clusters in parallel, but not minimap (yet) [1]"
    inputBinding:
      position: 1
      prefix: --threads
  - id: assembled_threshold
    type:
      - 'null'
      - float
    doc: "If proportion of gene assembled (regardless of into how many contigs) is at least this value then the flag gene_assembled is set [0.95]"
    inputBinding:
      position: 1
      prefix: --assembled_threshold
  - id: gene_nt_extend
    type:
      - 'null'
      - int
    doc: "Max number of nucleotides to extend ends of gene matches to look for start/stop codons [30]"
    inputBinding:
      position: 1
      prefix: --gene_nt_extend
  - id: unique_threshold
    type:
      - 'null'
      - float
    doc: "If proportion of bases in gene assembled more than once is <= this value, then the flag unique_contig is set [0.03]"
    inputBinding:
      position: 1
      prefix: --unique_threshold
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite output directory, if it already exists"
    inputBinding:
      position: 1
      prefix: --force
  - id: noclean
    type:
      - 'null'
      - boolean
    doc: "Do not clean up intermediate files"
    inputBinding:
      position: 1
      prefix: --noclean
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Existing directory in which to create a temporary directory used for local assemblies"
    inputBinding:
      position: 1
      prefix: --tmp_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be verbose"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: report
    type: File
    doc: ARIBA report (report.tsv)
    outputBinding:
      glob: $(inputs.outdir)/report.tsv
  - id: assembled_genes
    type: File?
    doc: Assembled genes (assembled_genes.fa.gz)
    outputBinding:
      glob: $(inputs.outdir)/assembled_genes.fa.gz
  - id: assembled_seqs
    type: File?
    doc: Assembled sequences (assembled_seqs.fa.gz)
    outputBinding:
      glob: $(inputs.outdir)/assembled_seqs.fa.gz
  - id: out_dir
    type: Directory
    doc: Full ARIBA run output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
