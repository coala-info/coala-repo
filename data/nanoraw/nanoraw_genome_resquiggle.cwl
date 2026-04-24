cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw genome_resquiggle
label: nanoraw_genome_resquiggle
doc: "Resquiggle raw signal data to a reference genome.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
inputs:
  - id: fast5_basedir
    type: Directory
    doc: Directory containing fast5 files.
    inputBinding:
      position: 1
  - id: genome_fasta
    type: File
    doc: Path to fasta file for mapping.
    inputBinding:
      position: 2
  - id: align_processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use for aligning and parsing original basecalls.
      Each process will independently load the genome into memory, so use caution
      with larger genomes (e.g. human). Default: 1'
    inputBinding:
      position: 103
      prefix: --align-processes
  - id: align_threads_per_process
    type:
      - 'null'
      - int
    doc: 'Number of threads to use per alignment process. This value is passed to
      the underlying mapper system calls. Default: [--processes] / (2 * [--align-processes)]'
    inputBinding:
      position: 103
      prefix: --align-threads-per-process
  - id: alignment_batch_size
    type:
      - 'null'
      - int
    doc: 'Batch size (number of reads) for each alignment call. Note that a new system
      call to the mapper is made for each batch (including loading of the genome),
      so it is advised to use larger values for larger genomes. Default: 500'
    inputBinding:
      position: 103
      prefix: --alignment-batch-size
  - id: basecall_group
    type:
      - 'null'
      - string
    doc: 'FAST5 group to use for obtaining original basecalls (under Analyses group).
      Default: Basecall_1D_000'
    inputBinding:
      position: 103
      prefix: --basecall-group
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: "FAST5 subgroup (under Analyses/[corrected-group]) where individual template
      and/or complement reads are stored. Default: ['BaseCalled_template']"
    inputBinding:
      position: 103
      prefix: --basecall-subgroups
  - id: bwa_mem_executable
    type:
      - 'null'
      - string
    doc: Relative or absolute path to built bwa-mem executable or command name 
      if globally installed.
    inputBinding:
      position: 103
      prefix: --bwa-mem-executable
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: 'FAST5 group to access/plot created by genome_resquiggle script. Default:
      RawGenomeCorrected_000'
    inputBinding:
      position: 103
      prefix: --corrected-group
  - id: cpts_limit
    type:
      - 'null'
      - int
    doc: Maximum number of changepoints to find within a single indel group. 
      (Not setting this option can cause a process to stall and cannot be 
      controlled by the timeout option).
    inputBinding:
      position: 103
      prefix: --cpts-limit
  - id: failed_reads_filename
    type:
      - 'null'
      - File
    doc: 'Output failed read filenames into a this file with assoicated error for
      each read. Default: Do not store failed reads.'
    inputBinding:
      position: 103
      prefix: --failed-reads-filename
  - id: fast5_pattern
    type:
      - 'null'
      - string
    doc: A pattern to search for a subset of files within fast5-basedir. Note 
      that on the unix command line patterns may be expanded so it is best 
      practice to quote patterns.
    inputBinding:
      position: 103
      prefix: --fast5-pattern
  - id: graphmap_executable
    type:
      - 'null'
      - string
    doc: Relative or absolute path to built graphmap executable or command name 
      if globally installed.
    inputBinding:
      position: 103
      prefix: --graphmap-executable
  - id: normalization_type
    type:
      - 'null'
      - string
    doc: Type of normalization to apply to raw signal when calculating 
      statistics based on new segmentation. Should be one of {"median", "pA", 
      "pA_raw", "none"}. "none" will provde the raw 16-bit DAQ values as the raw
      signal is stored. "pA_raw" will calculate the pA estimates as in the ONT 
      events (using offset, range and digitization parameters stored in the 
      FAST5 file). "pA" will first apply the "pA_raw" normalization followed by 
      kmer-based correction for pA drift as described in the nanopolish 
      methylation manuscript (this option requires the [--pore-model-filename] 
      option). "median" will shift by the median of each reads' raw signal and 
      scale by the MAD.
    inputBinding:
      position: 103
      prefix: --normalization-type
  - id: outlier_threshold
    type:
      - 'null'
      - float
    doc: Number of median absolute deviation (MAD) values at which to clip the 
      raw signal. This can help avoid strong re-segmentation artifacts from 
      spikes in signal. Set to negative value to disable outlier clipping.
    inputBinding:
      position: 103
      prefix: --outlier-threshold
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous corrected group in FAST5/HDF5 file. (Note this only 
      effects the group defined by --corrected-group).
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: pore_model_filename
    type:
      - 'null'
      - File
    doc: File containing kmer model parameters (level_mean and level_stdv) used 
      in order to compute kmer-based corrected pA values. E.g. 
      https://github.com/jts/nanopolish/blob/master/etc/r9-models/template_median68pA.5mers.model
    inputBinding:
      position: 103
      prefix: --pore-model-filename
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes. Default: 2'
    inputBinding:
      position: 103
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for FAST5 files within immediate sub- directories.Note that this
      only searches a single level of subdirectories and only for files ending 
      in .fast5. This is equivalent to specifying --fast5-pattern "*/*.fast5".
    inputBinding:
      position: 103
      prefix: --recursive
  - id: resquiggle_processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use for re-squiggling raw data. Default: [--processes]
      / 2'
    inputBinding:
      position: 103
      prefix: --resquiggle-processes
  - id: skip_event_stdev
    type:
      - 'null'
      - boolean
    doc: Skip computation of corrected event standard deviations to save 
      (potentially significant) time on computations.
    inputBinding:
      position: 103
      prefix: --skip-event-stdev
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds for the processing of a single read.
    inputBinding:
      position: 103
      prefix: --timeout
  - id: two_d
    type:
      - 'null'
      - boolean
    doc: Input contains 2D reads. Equivalent to `--basecall-subgroups 
      BaseCalled_template BaseCalled_complement`
    inputBinding:
      position: 103
      prefix: --2d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_genome_resquiggle.out
