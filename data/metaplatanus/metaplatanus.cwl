cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaplatanus
label: metaplatanus
doc: "metaplatanus version v1.3.1\n\nTool homepage: https://github.com/rkajitani/metaplatanus"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: lib_pair
        type: record
        fields:
          - name: lib_id
            type: int
          - name: forward
            type: File
          - name: reverse
            type: File
arguments:
  - position: 101
    valueFrom: |
      ${
        var out = [];
        var groups = [['-IP', inputs.inward_pair_files], ['-OP', inputs.outward_pair_files], ['-binning_IP', inputs.binning_inward_pair_files]];
        for (var g = 0; g < groups.length; g++) {
          var libs = groups[g][1] || [];
          for (var i = 0; i < libs.length; i++) {
            out.push(groups[g][0] + libs[i].lib_id);
            out.push(libs[i].forward.path);
            out.push(libs[i].reverse.path);
          }
        }
        return out;
      }
inputs:
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
        items: lib_pair
    doc: "inward-pair library for binning process (reads in 2 files, fasta or fastq; the data are usually from another sample). Each item gives the library id and the forward and reverse files; it is passed as -binning_IP<lib_id> FWD REV."
  - id: inward_pair_files
    type:
      - 'null'
      - type: array
        items: lib_pair
    doc: "inward-pair library (reads in 2 files, fasta or fastq; at least one library required). Each item gives the library id and the forward and reverse files; it is passed as -IP<lib_id> FWD REV."
  - id: memory_limit_gb
    type:
      - 'null'
      - int
    doc: memory limit for making kmer distribution (unit, GB; default, 64)
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
    type: string
    default: out
    doc: prefix of output files (default "out")
    inputBinding:
      position: 103
      prefix: -o
  - id: outward_pair_files
    type:
      - 'null'
      - type: array
        items: lib_pair
    doc: "outward-pair library (reads in 2 files, fasta or fastq; aka mate-pairs or jumping-library). Each item gives the library id and the forward and reverse files; it is passed as -OP<lib_id> FWD REV."
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
    inputBinding:
      position: 103
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: directory for temporary files (default, ".")
    inputBinding:
      position: 103
      prefix: -tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_dir
    type: Directory
    doc: Result folder (<prefix>_result) with the final assembly and bins
    outputBinding:
      glob: $(inputs.output_prefix + '_result')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplatanus:1.3.1--h6a68c12_1
stdout: metaplatanus.out
