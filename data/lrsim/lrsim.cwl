cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/lrsim/simulateLinkedReads.pl
label: lrsim
doc: "Simulate linked reads based on reference genome and variants.\n\nTool homepage:
  https://github.com/aquaskyline/LRSIM"
inputs:
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference genome (FASTA). Either this or the haploid FASTAs are required.
    inputBinding:
      position: 1
      prefix: -r
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 2
      prefix: -p
  - id: barcodes_list
    type:
      - 'null'
      - File
    doc: Barcodes list
    inputBinding:
      position: 103
      prefix: -b
  - id: continue_from_step
    type:
      - 'null'
      - int
    doc: Continue from a step (1. Variant simulation, 2. Build fasta index, 3. 
      DWGSIM, 4. Simulate reads, 5. Sort reads extraction manifest, 6. Extract 
      reads)
    inputBinding:
      position: 103
      prefix: -u
  - id: disable_parameter_checking
    type:
      - 'null'
      - boolean
    doc: Disable parameter checking
    inputBinding:
      position: 103
      prefix: -o
  - id: distance_std_dev
    type:
      - 'null'
      - int
    doc: Standard deviation of the distance for pairs
    inputBinding:
      position: 103
      prefix: -s
  - id: dwgsim_threads
    type:
      - 'null'
      - int
    doc: '# of threads to run DWGSIM'
    inputBinding:
      position: 103
      prefix: -z
  - id: fragment_sizes_list
    type:
      - 'null'
      - File
    doc: Input a list of fragment sizes
    inputBinding:
      position: 103
      prefix: -c
  - id: haploid_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Haploid FASTAs separated by comma. Overrides -r and -d.
    inputBinding:
      position: 103
      prefix: -g
      itemSeparator: ','
  - id: haplotypes_to_simulate
    type:
      - 'null'
      - int
    doc: Haplotypes to simulate
    inputBinding:
      position: 103
      prefix: -d
  - id: max_dup_inv_length
    type:
      - 'null'
      - int
    doc: Maximum length of Duplications and Inversions
    inputBinding:
      position: 103
      prefix: '-6'
  - id: max_indel_length
    type:
      - 'null'
      - int
    doc: Maximum length of Indels
    inputBinding:
      position: 103
      prefix: '-3'
  - id: max_translocation_length
    type:
      - 'null'
      - int
    doc: Maximum length of Translocations
    inputBinding:
      position: 103
      prefix: '-9'
  - id: mean_molecule_length_kbp
    type:
      - 'null'
      - int
    doc: Mean molecule length in kbp
    inputBinding:
      position: 103
      prefix: -f
  - id: min_dup_inv_length
    type:
      - 'null'
      - int
    doc: Minimum length of Duplications and Inversions
    inputBinding:
      position: 103
      prefix: '-5'
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: Minimum length of Indels
    inputBinding:
      position: 103
      prefix: '-2'
  - id: min_translocation_length
    type:
      - 'null'
      - int
    doc: Minimum length of Translocations
    inputBinding:
      position: 103
      prefix: '-8'
  - id: molecules_per_partition
    type:
      - 'null'
      - int
    doc: 'Average # of molecules per partition'
    inputBinding:
      position: 103
      prefix: -m
  - id: num_dups_inversions
    type:
      - 'null'
      - int
    doc: '# of Duplications and # of Inversions'
    inputBinding:
      position: 103
      prefix: '-7'
  - id: num_indels
    type:
      - 'null'
      - int
    doc: '# of Indels'
    inputBinding:
      position: 103
      prefix: '-4'
  - id: num_translocations
    type:
      - 'null'
      - int
    doc: '# of Translocations'
    inputBinding:
      position: 103
      prefix: '-0'
  - id: outer_distance
    type:
      - 'null'
      - int
    doc: Outer distance between the two ends for pairs
    inputBinding:
      position: 103
      prefix: -i
  - id: partitions_to_generate
    type:
      - 'null'
      - int
    doc: n*1000 partitions to generate
    inputBinding:
      position: 103
      prefix: -t
  - id: read1_error_rate
    type:
      - 'null'
      - string
    doc: Per base error rate of the first read
    inputBinding:
      position: 103
      prefix: -e
  - id: read2_error_rate
    type:
      - 'null'
      - string
    doc: Per base error rate of the second read
    inputBinding:
      position: 103
      prefix: -E
  - id: snp_per_base_pairs
    type:
      - 'null'
      - int
    doc: 1 SNP per INT base pairs
    inputBinding:
      position: 103
      prefix: '-1'
  - id: total_read_pairs_millions
    type:
      - 'null'
      - int
    doc: '# million reads pairs in total to simulated'
    inputBinding:
      position: 103
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: reads
    type:
      type: array
      items: File
    doc: Simulated linked reads (barcoded FASTQ, one R1/R2 pair per haplotype)
    outputBinding:
      glob: $(inputs.output_prefix)_S1_L00*_R*_001.fastq.gz
  - id: status_log
    type:
      - 'null'
      - File
    doc: Progress log of the simulation
    outputBinding:
      glob: $(inputs.output_prefix).status
  - id: variant_files
    type:
      type: array
      items: File
    doc: Simulated variant files (BED and SURVIVOR parameter file), written when haplotypes are simulated from a reference
    outputBinding:
      glob: [$(inputs.output_prefix).hap.parameter, $(inputs.output_prefix).hap.*.bed]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrsim:1.0--pl5321hbcd995c_0
stdout: lrsim.out
