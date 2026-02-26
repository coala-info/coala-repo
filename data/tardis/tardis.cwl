cwlVersion: v1.2
class: CommandLineTool
baseCommand: tardis
label: tardis
doc: "Condition a command for execution on a cluster.\n\nTool homepage: https://github.com/AgResearch/tardis"
inputs:
  - id: command
    type: string
    doc: command to run
    inputBinding:
      position: 1
  - id: command_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: command arguments
    inputBinding:
      position: 2
  - id: batonfile
    type:
      - 'null'
      - File
    doc: if you supply a "baton file" FILE, tardis will write the process exit 
      code to this file after all processing has completed. This can be useful 
      to preserve synchronous execution of a workflow, even if tardis is started
      in the background - the workflow can test the existence of the batonfile -
      if it exists then the corresponding tardis processing step has completed 
      (i.e. another way of each step in a workflow "passing the baton" to the 
      next step)
    inputBinding:
      position: 103
      prefix: --batonfile
  - id: chunksize
    type:
      - 'null'
      - int
    doc: When conditioning the input file(s), split into files each containing N
      logical records. (A logical record for a sequence file is a complete 
      sequence. For a text file it is a line of text). (If the -s option is used
      to sample the inputs, the chunksize relates to the full un-sampled file . 
      so the same chunk-size can be used whether random sampling or not. For 
      example a chunksize of 1,000,000 is specified in combination with a 
      sampling rate of .0001, then each chunk would contain 100 sequences . i.e.
      you should not adjust the chunk-size, for the sampling rate. Note that to 
      avoid a race-condition that could be caused by a very small chunk-size 
      resulting in launching a very large number of jobs, tardis will throw an 
      exception if the chunk- size used would result in launching more than 
      MAX_DIMENSION jobs (currently 5000) )
    inputBinding:
      position: 103
      prefix: --chunksize
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: validate the run by doing a dry run. This means that the chunks, job 
      scripts and job files etc. are all generated but the jobs are not 
      launched. The user can start then kill (CTRL-C) the run, inspect the 
      script and job files that were generated to check that their command has 
      been conditioned as envisaged.
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: from_record
    type:
      - 'null'
      - int
    doc: When conditioning the input file(s), only use records from the input 
      file after or including N (where that is logical record number . e.g. in a
      fastq file, start from record number N means start from sequence N). By 
      combining this option with -to, you can process slices of a file. Note 
      that this option has no affect when processing a list-file.
    inputBinding:
      position: 103
      prefix: --from
  - id: hpctype
    type:
      - 'null'
      - string
    doc: 'indicate the hpc environment. Currently the only supported values are: condor
      which results in tardis attempting to set up and launch condor jobs; local which
      results in each job being launched by tardis itself on the local machine, using
      the native python sub-process API. The maximum number of processes it will run
      at a time is controlled by a global variable in the script MAX_PROCESSES, which
      is initially 10; slurm which results in tardis attempting to set up and launch
      slurm jobs.'
    inputBinding:
      position: 103
      prefix: --hpctype
  - id: in_workflow
    type:
      - 'null'
      - boolean
    doc: Run the command as part of a workflow. After launching all of the jobs,
      tardis waits for all outputs, which are then collated and merged into a 
      single output file, as specified by the output file path in the original 
      command; all of the temporary input files (for example chunks of 
      uncompressed fastq) are deleted provided all prior steps completed without
      error (if there was an error they are left there to assist with 
      debugging). Without this option, the program exits immediately after 
      launching all of the jobs, and output is left un-collated in the scratch 
      folder created by this script, and no cleanup is done.
    inputBinding:
      position: 103
      prefix: --in-workflow
  - id: job_file
    type:
      - 'null'
      - File
    doc: optionally supply a job template - tardis will read the contents of 
      FILE and use this as the job template.
    inputBinding:
      position: 103
      prefix: --job-file
  - id: job_template_name
    type:
      - 'null'
      - string
    doc: job template name, resolved in template directory
    inputBinding:
      position: 103
      prefix: --job-template-name
  - id: keep_conditioned_data
    type:
      - 'null'
      - boolean
    doc: keep the conditioned input and output - i.e. the input and output 
      fragments. Normally in workflow mode these are deleted after the output is
      successfully "unconditioned" - i.e. joined back together
    inputBinding:
      position: 103
      prefix: --keep-conditioned-data
  - id: no_sysconfig
    type:
      - 'null'
      - boolean
    doc: ignore the system configuration file
    inputBinding:
      position: 103
      prefix: --no-sysconfig
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: run quietly
    inputBinding:
      position: 103
      prefix: --quiet
  - id: rootdir
    type:
      - 'null'
      - Directory
    doc: create the tardis working folder under DIR. If no working root is 
      specified, a default location is used.
    inputBinding:
      position: 103
      prefix: --rootdir
  - id: runtimeconfigsourcefile
    type:
      - 'null'
      - File
    doc: shell script fragment included in jobs
    inputBinding:
      position: 103
      prefix: --runtimeconfigsourcefile
  - id: sample_rate
    type:
      - 'null'
      - float
    doc: Rather than process the entire input file(s), a random sample of the 
      records is processed. RATE is the probability that a given record will be 
      sampled. For example -s .001 will result in roughly 1 in every 1000 
      logical records being sampled. When the -s option is specified, tardis 
      does not clean up the conditioned input and output . e.g. all of the 
      uncompressed fastq sample fragments would be retained. These are retained 
      to assist with the Q/C work that is normally associated with a sampled 
      run. Paired fastq input files are sampled in lock-step, provided the 
      paired fastq conditioning directive is used for both files.
    inputBinding:
      position: 103
      prefix: -s
  - id: shell_include_file
    type:
      - 'null'
      - File
    doc: shell script fragment included in jobs
    inputBinding:
      position: 103
      prefix: --shell-include-file
  - id: templatedir
    type:
      - 'null'
      - Directory
    doc: template directory
    inputBinding:
      position: 103
      prefix: --templatedir
  - id: to_record
    type:
      - 'null'
      - int
    doc: When conditioning the input file(s), only use records up to and 
      including the record N (where that is logical record number . e.g. in a 
      fastq file, process up to record number N means process up to and 
      including sequence N). By combining this option with -from, you can 
      process slices of a file. Note that this option has no affect when 
      processing a list-file.
    inputBinding:
      position: 103
      prefix: --to
  - id: userconfig
    type:
      - 'null'
      - File
    doc: user configuration file
    inputBinding:
      position: 103
      prefix: --userconfig
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tardis:1.0.19--py27ha92aebf_0
stdout: tardis.out
