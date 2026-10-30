cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - total
label: seismic-rna_seismic_sim_total
doc: 'Simulate FASTQ files from scratch.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: profile_name
    type:
      - 'null'
      - string
    doc: 'Give the simulated structure and parameters this profile name [default:
      simulated]'
    inputBinding:
      position: 100
      prefix: --profile-name
  - id: sample
    type:
      - 'null'
      - string
    doc: 'Give this name to the simulated sample [default: sim-sample]'
    inputBinding:
      position: 100
      prefix: --sample
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: 'Simulate paired-end or single-end reads [default: paired-end]'
    inputBinding:
      position: 100
      prefix: --paired-end
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: 'Simulate paired-end or single-end reads [default: paired-end]'
    inputBinding:
      position: 100
      prefix: --single-end
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Simulate reads with this many base calls [default: 151]'
    inputBinding:
      position: 100
      prefix: --read-length
  - id: reverse_fraction
    type:
      - 'null'
      - float
    doc: 'Simulate this fraction of reverse-oriented reads [default: 0.5]'
    inputBinding:
      position: 100
      prefix: --reverse-fraction
  - id: min_mut_gap
    type:
      - 'null'
      - int
    doc: 'Mask reads with two mutations separated by fewer than this many bases [default:
      4]'
    inputBinding:
      position: 100
      prefix: --min-mut-gap
  - id: fq_gzip
    type:
      - 'null'
      - boolean
    doc: 'Simulate FASTQ files with gzip compression or as plain text [default: fq-gzip]'
    inputBinding:
      position: 100
      prefix: --fq-gzip
  - id: fq_text
    type:
      - 'null'
      - boolean
    doc: 'Simulate FASTQ files with gzip compression or as plain text [default: fq-gzip]'
    inputBinding:
      position: 100
      prefix: --fq-text
  - id: num_reads
    type:
      - 'null'
      - int
    doc: 'Simulate this many reads [default: 65536]'
    inputBinding:
      position: 100
      prefix: --num-reads
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
  - id: sim_dir
    type: string
    default: sim
    doc: 'Write all simulated files to this directory [default: ./sim]'
    inputBinding:
      position: 100
      prefix: --sim-dir
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: fold_regions_file
    type:
      - 'null'
      - File
    doc: Fold regions of references from coordinates/primers in a CSV file
    inputBinding:
      position: 100
      prefix: --fold-regions-file
  - id: fold_coords
    type:
      - 'null'
      - type: array
        items: fold_coords_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its 5'' and 3'' end coordinates (give
      the option once per record)'
  - id: fold_primers
    type:
      - 'null'
      - type: array
        items: fold_primers_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its forward and reverse primers (give
      the option once per record)'
  - id: fold_constraint
    type:
      - 'null'
      - File
    doc: Force bases to be paired/unpaired from a file of constraints
    inputBinding:
      position: 100
      prefix: --fold-constraint
  - id: fold_temp
    type:
      - 'null'
      - float
    doc: 'Predict structures at this temperature (Kelvin) [default: 310.15]'
    inputBinding:
      position: 100
      prefix: --fold-temp
  - id: fold_md
    type:
      - 'null'
      - int
    doc: 'Limit base pair distances to this number of bases (0 for no limit) [default:
      0]'
    inputBinding:
      position: 100
      prefix: --fold-md
  - id: fold_mfe
    type:
      - 'null'
      - boolean
    doc: 'Predict only the minimum free energy (MFE) structure [default: fold-sub]'
    inputBinding:
      position: 100
      prefix: --fold-mfe
  - id: fold_sub
    type:
      - 'null'
      - boolean
    doc: 'Predict only the minimum free energy (MFE) structure [default: fold-sub]'
    inputBinding:
      position: 100
      prefix: --fold-sub
  - id: fold_max
    type:
      - 'null'
      - int
    doc: 'Output at most this many structures (overriden by --fold-mfe) [default:
      20]'
    inputBinding:
      position: 100
      prefix: --fold-max
  - id: fold_percent
    type:
      - 'null'
      - float
    doc: 'Stop outputting structures when the % difference in energy exceeds this
      value (overriden by --fold-mfe) [default: 20.0]'
    inputBinding:
      position: 100
      prefix: --fold-percent
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
  - id: clust_conc
    type:
      - 'null'
      - float
    doc: 'Set the concentration parameter for simulating cluster proportions [default:
      0.0]'
    inputBinding:
      position: 100
      prefix: --clust-conc
  - id: center_fmean
    type:
      - 'null'
      - float
    doc: 'Set the mean read center as a fraction of the region length [default: 0.5]'
    inputBinding:
      position: 100
      prefix: --center-fmean
  - id: center_fvar
    type:
      - 'null'
      - float
    doc: 'Set the variance of the read center as a fraction of its maximum [default:
      0.3333333333333333]'
    inputBinding:
      position: 100
      prefix: --center-fvar
  - id: length_fmean
    type:
      - 'null'
      - float
    doc: 'Set the mean read length as a fraction of the region length [default: 0.5]'
    inputBinding:
      position: 100
      prefix: --length-fmean
  - id: length_fvar
    type:
      - 'null'
      - float
    doc: 'Set the variance of the read length as a fraction of its maximum [default:
      0.012345679012345678]'
    inputBinding:
      position: 100
      prefix: --length-fvar
  - id: pmut_paired
    type:
      - 'null'
      - type: array
        items: pmut_paired_rec
        inputBinding:
          position: 100
    doc: ' Set the mean rate of each kind of mutation for paired bases (give the option
      once per record)'
  - id: pmut_unpaired
    type:
      - 'null'
      - type: array
        items: pmut_unpaired_rec
        inputBinding:
          position: 100
    doc: ' Set the mean rate of each kind of mutation for unpaired bases (give the
      option once per record)'
  - id: vmut_paired
    type:
      - 'null'
      - float
    doc: 'Set the relative variance of mutation rates of paired bases [default: 0.001]'
    inputBinding:
      position: 100
      prefix: --vmut-paired
  - id: vmut_unpaired
    type:
      - 'null'
      - float
    doc: 'Set the relative variance of mutation rates of unpaired bases [default:
      0.02]'
    inputBinding:
      position: 100
      prefix: --vmut-unpaired
  - id: refs
    type:
      - 'null'
      - string
    doc: 'Give this name to the file of simulated references [default: sim-refs]'
    inputBinding:
      position: 100
      prefix: --refs
  - id: ref
    type:
      - 'null'
      - string
    doc: 'Give this name to the simulated reference [default: sim-ref]'
    inputBinding:
      position: 100
      prefix: --ref
  - id: reflen
    type:
      - 'null'
      - int
    doc: 'Simulate a reference sequence with this many bases [default: 280]'
    inputBinding:
      position: 100
      prefix: --reflen
outputs:
  - id: sim_dir_result
    type: Directory
    doc: Simulation directory with all simulated files
    outputBinding:
      glob: $(inputs.sim_dir)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: fold_coords_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --fold-coords
          - name: end5
            type: int
            inputBinding:
              position: 2
          - name: end3
            type: int
            inputBinding:
              position: 3
      - name: fold_primers_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --fold-primers
          - name: forward_primer
            type: string
            inputBinding:
              position: 2
          - name: reverse_primer
            type: string
            inputBinding:
              position: 3
      - name: pmut_paired_rec
        type: record
        fields:
          - name: mutation_type
            type: string
            inputBinding:
              position: 1
              prefix: --pmut-paired
          - name: rate
            type: float
            inputBinding:
              position: 2
      - name: pmut_unpaired_rec
        type: record
        fields:
          - name: mutation_type
            type: string
            inputBinding:
              position: 1
              prefix: --pmut-unpaired
          - name: rate
            type: float
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
