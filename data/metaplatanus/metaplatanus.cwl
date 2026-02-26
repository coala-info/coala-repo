cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaplatanus
label: metaplatanus
doc: "metaplatanus version v1.3.1\n\nTool homepage: https://github.com/rkajitani/metaplatanus"
inputs:
  - id: short_reads_1
    type: File
    doc: short_1.fastq(a)
    inputBinding:
      position: 1
  - id: short_reads_2
    type: File
    doc: short_2.fastq(a)
    inputBinding:
      position: 2
  - id: barcoded_pair_files_interleaved
    type:
      - 'null'
      - type: array
        items: File
    doc: barcoded_pair_files (10x Genomics) (reads in 1 file, interleaved, fasta
      or fastq)
    inputBinding:
      position: 103
      prefix: -x
  - id: barcoded_pair_files_separate
    type:
      - 'null'
      - type: array
        items: File
    doc: barcoded_pair_files (10x Genomics) (reads in 2 files, fasta or fastq)
    inputBinding:
      position: 103
      prefix: -X
  - id: binning_inward_pair_files
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id inward_pair_files for binning process. (reads in 2 files, fasta 
      or fastq; the data are usually from another sample)
    inputBinding:
      position: 103
      prefix: -binning_IP
  - id: inward_pair_files
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id inward_pair_files (reads in 2 files, fasta or fastq; at least 
      one library required)
    inputBinding:
      position: 103
      prefix: -IP
  - id: memory_limit_gb
    type:
      - 'null'
      - int
    doc: memory limit for making kmer distribution (unit, GB; default, 64)
    default: 64
    inputBinding:
      position: 103
      prefix: -m
  - id: min_cov_contig
    type:
      - 'null'
      - int
    doc: k-mer coverage cutoff for contig-assembly of MetaPlatanus (default, 4 
      with MEGAHIT, 2 otherwise)
    inputBinding:
      position: 103
      prefix: -min_cov_contig
  - id: min_map_identity_binning
    type:
      - 'null'
      - float
    doc: minimum identity (%) in read mapping for binning (default, 97)
    default: 97
    inputBinding:
      position: 103
      prefix: -min_map_idt_binning
  - id: no_binning
    type:
      - 'null'
      - boolean
    doc: do not perfom binning (default, off)
    inputBinding:
      position: 103
      prefix: -no_binning
  - id: no_megahit
    type:
      - 'null'
      - boolean
    doc: do not perfom MEGAHIT assembly (default, off)
    inputBinding:
      position: 103
      prefix: -no_megahit
  - id: no_nextpolish
    type:
      - 'null'
      - boolean
    doc: do not use NextPolish (default, off)
    inputBinding:
      position: 103
      prefix: -no_nextpolish
  - id: no_re_scaffold
    type:
      - 'null'
      - boolean
    doc: do not perfom re-scaffolding (default, off)
    inputBinding:
      position: 103
      prefix: -no_re_scaffold
  - id: no_tgsgapcloser
    type:
      - 'null'
      - boolean
    doc: do not use TGS-GapCloser and NextPolish (default, off)
    inputBinding:
      position: 103
      prefix: -no_tgsgapcloser
  - id: ont_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Oxford Nanopore long-read file (fasta or fastq)
    inputBinding:
      position: 103
      prefix: -ont
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output files (default "out")
    default: out
    inputBinding:
      position: 103
      prefix: -o
  - id: outward_pair_files
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id outward_pair_files (reads in 2 files, fasta or fastq; aka 
      mate-pairs or jumping-library)
    inputBinding:
      position: 103
      prefix: -OP
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite the previous results, not re-start (default, off)
    inputBinding:
      position: 103
      prefix: -overwrite
  - id: pacbio_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio long-read file (fasta or fastq)
    inputBinding:
      position: 103
      prefix: -p
  - id: sub_bin_dir
    type:
      - 'null'
      - Directory
    doc: directory for sub-executables, such as mata_plantaus and minimap2 
      (default, directory-of-this-script/sub_bin)
    inputBinding:
      position: 103
      prefix: -sub_bin
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (<= 1; default, 1)
    default: 1
    inputBinding:
      position: 103
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files (default, ".")
    default: .
    inputBinding:
      position: 103
      prefix: -tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplatanus:1.3.1--h6a68c12_1
stdout: metaplatanus.out
