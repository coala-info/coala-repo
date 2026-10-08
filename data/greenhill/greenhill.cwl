cwlVersion: v1.2
class: CommandLineTool
baseCommand: greenhill
label: greenhill
doc: "greenhill version: 1.1.0\n\nTool homepage: https://github.com/ShunOuchi/GreenHill"
inputs:
  - id: avg_insert_size_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -a option (default 1)
  - id: avg_insert_size
    type:
      - 'null'
      - int
    doc: lib_id average_insert_size
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.avg_insert_size_lib_id || 1; return ["-a" + l, String(self)]; }
  - id: bubble_seq_file
    type:
      - 'null'
      - type: array
        items: File
    doc: bubble_seq_file (fasta format; for Haplotype-aware style input)
    inputBinding:
      position: 101
      prefix: -b
  - id: contig_file_haplotype
    type:
      - 'null'
      - type: array
        items: File
    doc: contig_file (fasta format; for Haplotype-aware style input)
    inputBinding:
      position: 101
      prefix: -c
  - id: contig_file_pseudo_haplotype
    type:
      - 'null'
      - type: array
        items: File
    doc: contig_file (fasta format; for Pseudo-haplotype or Mixed-haplotype 
      style input; only effective without -c, -b option)
    inputBinding:
      position: 101
      prefix: -cph
  - id: coverage_depth
    type:
      - 'null'
      - float
    doc: coverage depth of homozygous region (default auto)
    inputBinding:
      position: 101
      prefix: -e
  - id: hic_pair_files_paired
    type:
      - 'null'
      - type: array
        items: File
    doc: HiC_pair_files (reads in 2 files, fasta or fastq)
    inputBinding:
      position: 101
      prefix: -HIC
  - id: hic_pair_files_single
    type:
      - 'null'
      - type: array
        items: File
    doc: HiC_pair_files (reads in 1 file, fasta or fastq)
    inputBinding:
      position: 101
      prefix: -hic
  - id: inward_pair_file_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -ip option (default 1)
  - id: inward_pair_file
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id inward_pair_file (reads in 1 file, fasta or fastq)
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.inward_pair_file_lib_id || 1; return ["-ip" + l].concat(self.map(function (f) { return f.path; })); }
  - id: inward_pair_files_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -IP option (default 1)
  - id: inward_pair_files
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id inward_pair_files (reads in 2 files, fasta or fastq)
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.inward_pair_files_lib_id || 1; return ["-IP" + l].concat(self.map(function (f) { return f.path; })); }
  - id: long_read_file
    type:
      - 'null'
      - type: array
        items: File
    doc: long-read file (PacBio, Nanopore) (reads in 1 file, fasta or fastq)
    inputBinding:
      position: 101
      prefix: -p
  - id: mapper_executable
    type:
      - 'null'
      - File
    doc: path of mapper executable file (default, minimap2; only effective with 
      -p option)
    inputBinding:
      position: 101
      prefix: -mapper
  - id: mapping_seed_length
    type:
      - 'null'
      - type: array
        items: int
    doc: mapping seed length for short reads (default 32 64 96)
    inputBinding:
      position: 101
      prefix: -s
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: maximum fragment length of tag (10x Genomics) (default 200000)
    inputBinding:
      position: 101
      prefix: -L
  - id: min_insert_size_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -n option (default 1)
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: lib_id minimum_insert_size
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.min_insert_size_lib_id || 1; return ["-n" + l, String(self)]; }
  - id: min_links_phase
    type:
      - 'null'
      - int
    doc: minimum number of links to phase variants (default 1)
    inputBinding:
      position: 101
      prefix: -k
  - id: min_links_scaffold
    type:
      - 'null'
      - int
    doc: minimum number of links to scaffold (default 3)
    inputBinding:
      position: 101
      prefix: -l
  - id: minimap2_sensitive
    type:
      - 'null'
      - boolean
    doc: sensitive mode for minimap2 (default, off; only effective with -p 
      option)
    inputBinding:
      position: 101
      prefix: -minimap2_sensitive
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output file (default out, length <= 200)
    inputBinding:
      position: 101
      prefix: -o
  - id: outward_pair_file_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -op option (default 1)
  - id: outward_pair_file
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id outward_pair_file (reads in 1 file, fasta or fastq)
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.outward_pair_file_lib_id || 1; return ["-op" + l].concat(self.map(function (f) { return f.path; })); }
  - id: outward_pair_files_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -OP option (default 1)
  - id: outward_pair_files
    type:
      - 'null'
      - type: array
        items: File
    doc: lib_id outward_pair_files (reads in 2 files, fasta or fastq)
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.outward_pair_files_lib_id || 1; return ["-OP" + l].concat(self.map(function (f) { return f.path; })); }
  - id: reduce_redundancy
    type:
      - 'null'
      - boolean
    doc: reduce redundant sequences that exactly matche others (default, off)
    inputBinding:
      position: 101
      prefix: -reduce_redundancy
  - id: sd_insert_size_lib_id
    type:
      - 'null'
      - int
    doc: library number glued to the -d option (default 1)
  - id: sd_insert_size
    type:
      - 'null'
      - int
    doc: lib_id SD_insert_size
    inputBinding:
      position: 101
      valueFrom: |-
        ${ if (self === null) { return null; } var l = inputs.sd_insert_size_lib_id || 1; return ["-d" + l, String(self)]; }
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (<= 1, default 1)
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: directory for temporary files (default .)
    inputBinding:
      position: 101
      prefix: -tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/greenhill:1.1.0--h663a4a6_3
stdout: greenhill.out
