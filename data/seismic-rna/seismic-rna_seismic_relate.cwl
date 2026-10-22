cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - relate
label: seismic-rna_seismic_relate
doc: 'Compute relationships between references and aligned reads.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step. It is copied into the working directory
      as the output directory (named by --out-dir, default out)
  - id: fasta
    type: File
    doc: FASTA file of reference sequences
    inputBinding:
      position: 200
  - id: input_path
    type:
      - 'null'
      - type: array
        items: string
    default:
      - out
    doc: Files or directories inside the output directory to process (paths start
      with the output directory name)
    inputBinding:
      position: 201
  - id: sep_strands
    type:
      - 'null'
      - boolean
    doc: 'Separate each alignment map into forward- and reverse-strand reads [default:
      mix- strands]'
    inputBinding:
      position: 100
      prefix: --sep-strands
  - id: mix_strands
    type:
      - 'null'
      - boolean
    doc: 'Separate each alignment map into forward- and reverse-strand reads [default:
      mix- strands]'
    inputBinding:
      position: 100
      prefix: --mix-strands
  - id: rev_label
    type:
      - 'null'
      - string
    doc: 'With --sep-strands, add this label to each reverse-strand reference [default:
      -rev]'
    inputBinding:
      position: 100
      prefix: --rev-label
  - id: out_dir
    type: string
    default: out
    doc: 'Write all output files to this directory [default: ./out]'
    inputBinding:
      position: 100
      prefix: --out-dir
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Create a new branch of the workflow with this name [default: ""]'
    inputBinding:
      position: 100
      prefix: --branch
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Discard reads with mapping qualities below this threshold [default: 25]'
    inputBinding:
      position: 100
      prefix: --min-mapq
  - id: phred_enc
    type:
      - 'null'
      - int
    doc: 'Specify the Phred score encoding of FASTQ and SAM/BAM/CRAM files [default:
      33]'
    inputBinding:
      position: 100
      prefix: --phred-enc
  - id: min_phred
    type:
      - 'null'
      - int
    doc: 'Mark base calls with Phred scores lower than this threshold as ambiguous
      [default: 25]'
    inputBinding:
      position: 100
      prefix: --min-phred
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'Discard alignment maps with fewer than this many reads [default: 1000]'
    inputBinding:
      position: 100
      prefix: --min-reads
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Limit batches to at most this many reads [default: 65536]'
    inputBinding:
      position: 100
      prefix: --batch-size
  - id: insert3
    type:
      - 'null'
      - boolean
    doc: 'Mark each insertion on the base to its 3'' (True) or 5'' (False) side [default:
      insert3]'
    inputBinding:
      position: 100
      prefix: --insert3
  - id: insert5
    type:
      - 'null'
      - boolean
    doc: 'Mark each insertion on the base to its 3'' (True) or 5'' (False) side [default:
      insert3]'
    inputBinding:
      position: 100
      prefix: --insert5
  - id: ambindel
    type:
      - 'null'
      - boolean
    doc: 'Mark all ambiguous insertions and deletions (indels) [default: ambindel]'
    inputBinding:
      position: 100
      prefix: --ambindel
  - id: no_ambindel
    type:
      - 'null'
      - boolean
    doc: 'Mark all ambiguous insertions and deletions (indels) [default: ambindel]'
    inputBinding:
      position: 100
      prefix: --no-ambindel
  - id: overhangs
    type:
      - 'null'
      - boolean
    doc: 'Retain the overhangs of paired-end mates that dovetail [default: overhangs]'
    inputBinding:
      position: 100
      prefix: --overhangs
  - id: no_overhangs
    type:
      - 'null'
      - boolean
    doc: 'Retain the overhangs of paired-end mates that dovetail [default: overhangs]'
    inputBinding:
      position: 100
      prefix: --no-overhangs
  - id: clip_end5
    type:
      - 'null'
      - int
    doc: 'Clip this many bases from the 5'' end of each read [default: 4]'
    inputBinding:
      position: 100
      prefix: --clip-end5
  - id: clip_end3
    type:
      - 'null'
      - int
    doc: 'Clip this many bases from the 3'' end of each read [default: 4]'
    inputBinding:
      position: 100
      prefix: --clip-end3
  - id: brotli_level
    type:
      - 'null'
      - int
    doc: 'Compress pickle files with this level of Brotli (0 - 11) [default: 10]'
    inputBinding:
      position: 100
      prefix: --brotli-level
  - id: write_read_names
    type:
      - 'null'
      - boolean
    doc: ' Write the name of each read in a second set of batches (necessary for the
      options --mask-read or --mask-read-file) [default: no-write-read-names]'
    inputBinding:
      position: 100
      prefix: --write-read-names
  - id: no_write_read_names
    type:
      - 'null'
      - boolean
    doc: ' Write the name of each read in a second set of batches (necessary for the
      options --mask-read or --mask-read-file) [default: no-write-read-names]'
    inputBinding:
      position: 100
      prefix: --no-write-read-names
  - id: relate_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for relate data [default: relate-pos-table]'
    inputBinding:
      position: 100
      prefix: --relate-pos-table
  - id: no_relate_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for relate data [default: relate-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-relate-pos-table
  - id: relate_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for relate data [default: no-relate-read-table]'
    inputBinding:
      position: 100
      prefix: --relate-read-table
  - id: no_relate_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for relate data [default: no-relate-read-table]'
    inputBinding:
      position: 100
      prefix: --no-relate-read-table
  - id: relate_cx
    type:
      - 'null'
      - boolean
    doc: 'Use a fast (C extension module) version of the relate algorithm; the slow
      (Python) version is still avilable as a fallback if the C extension cannot be
      loaded, and for debugging/benchmarking [default: relate-cx]'
    inputBinding:
      position: 100
      prefix: --relate-cx
  - id: relate_py
    type:
      - 'null'
      - boolean
    doc: 'Use a fast (C extension module) version of the relate algorithm; the slow
      (Python) version is still avilable as a fallback if the C extension cannot be
      loaded, and for debugging/benchmarking [default: relate-cx]'
    inputBinding:
      position: 100
      prefix: --relate-py
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --keep-tmp
  - id: erase_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --erase-tmp
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: $(inputs.out_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
