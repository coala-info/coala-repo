cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver_shiver_map_reads.sh
label: shiver_shiver_map_reads.sh
doc: "Maps reads to contigs, potentially using reference alignments.\n\nTool homepage:
  https://github.com/ChrisHIV/shiver"
inputs:
  - id: initialisation_directory
    type: Directory
    doc: The initialisation directory created using the shiver_init.sh command.
    inputBinding:
      position: 1
  - id: configuration_file
    type: File
    doc: The configuration file, containing all your parameter choices etc.
    inputBinding:
      position: 2
  - id: test_mode_type
    type: string
    doc: Either 'paired' or 'unpaired' to specify the read type for testing.
    inputBinding:
      position: 3
  - id: contigs_fasta
    type: File
    doc: A fasta file of contigs (output from processing the short reads with an
      assembly program).
    inputBinding:
      position: 4
  - id: sample_id
    type: string
    doc: A sample ID (SID) used for naming the output from this script (a 
      sensible choice might be the contig file name minus its path and 
      extension).
    inputBinding:
      position: 5
  - id: blast_file
    type: File
    doc: The blast file created by the shiver_align_contigs.sh command.
    inputBinding:
      position: 6
  - id: contig_alignment_or_reference_fasta
    type: File
    doc: Either the alignment of contigs to refs produced by the 
      shiver_align_contigs.sh command, or a fasta file containing a single 
      reference to be used for mapping.
    inputBinding:
      position: 7
  - id: forward_reads_or_single_reads
    type: File
    doc: The forward reads when mapping paired reads, or the single reads file 
      for unpaired.
    inputBinding:
      position: 8
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: The reverse reads for paired reads, or for unpaired reads omit this 
      argument.
    inputBinding:
      position: 9
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test configuration file validity and external program calls.
    inputBinding:
      position: 110
      prefix: --test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver_shiver_map_reads.sh.out
