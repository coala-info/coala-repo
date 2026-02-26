# jobtree CWL Generation Report

## jobtree_jobTreeStatus

### Tool Description
Prints the status of a job tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/jobtree:09.04.2017--py_2
- **Homepage**: https://github.com/benedictpaten/jobTree
- **Package**: https://anaconda.org/channels/bioconda/packages/jobtree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jobtree/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/benedictpaten/jobTree
- **Stars**: N/A
### Original Help Text
```text
Usage: jobTreeStatus [--jobTree] JOB_TREE_DIR [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --tempDirRoot=TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default uses the current working
                        directory as the base.
  --jobTree=JOBTREE     Directory containing the job tree. The jobTree
                        location can also be specified as the argument to the
                        script. default=./jobTree
  --verbose             Print loads of information, particularly all the log
                        files of jobs that failed. default=False
  --failIfNotComplete   Return exit value of 1 if job tree jobs not all
                        completed. default=False

  Logging options:
    Options that control logging

    --logOff            Turn off logging. (default is CRITICAL)
    --logInfo           Turn on logging at INFO level. (default is CRITICAL)
    --logDebug          Turn on logging at DEBUG level. (default is CRITICAL)
    --logLevel=LOGLEVEL
                        Log at level (may be either OFF/INFO/DEBUG/CRITICAL).
                        (default is CRITICAL)
    --logFile=LOGFILE   File to log in
    --rotatingLogging   Turn on rotating logging, which prevents log files
                        getting too big.
```


## jobtree_jobTreeRun

### Tool Description
Options

### Metadata
- **Docker Image**: quay.io/biocontainers/jobtree:09.04.2017--py_2
- **Homepage**: https://github.com/benedictpaten/jobTree
- **Package**: https://anaconda.org/channels/bioconda/packages/jobtree/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jobTreeRun [options]

Options:
  -h, --help            show this help message and exit

  Logging options:
    Options that control logging

    --logOff            Turn off logging. (default is CRITICAL)
    --logInfo           Turn on logging at INFO level. (default is CRITICAL)
    --logDebug          Turn on logging at DEBUG level. (default is CRITICAL)
    --logLevel=LOGLEVEL
                        Log at level (may be either OFF/INFO/DEBUG/CRITICAL).
                        (default is CRITICAL)
    --logFile=LOGFILE   File to log in
    --rotatingLogging   Turn on rotating logging, which prevents log files
                        getting too big.

  jobTree core options:
    Options to specify the location of the jobTree and turn on stats
    collation about the performance of jobs.

    --jobTree=JOBTREE   Directory in which to place job management files and
                        the global accessed temporary file directories(this
                        needs to be globally accessible by all machines
                        running jobs). If you pass an existing directory it
                        will check if it's a valid existing job tree, then try
                        and restart the jobs in it. The default=./jobTree
    --stats             Records statistics about the job-tree to be used by
                        jobTreeStats. default=False

  jobTree options for specifying the batch system:
    Allows the specification of the batch system, and arguments to the
    batch system/big batch system (see below).

    --batchSystem=BATCHSYSTEM
                        The type of batch system to run the job(s) with,
                        currently can be 'singleMachine'/'parasol'/'acidTest'/
                        'gridEngine'/'lsf'. default=singleMachine
    --maxThreads=MAXTHREADS
                        The maximum number of threads (technically processes
                        at this point) to use when running in single machine
                        mode. Increasing this will allow more jobs to run
                        concurrently when running on a single machine.
                        default=4
    --parasolCommand=PARASOLCOMMAND
                        The command to run the parasol program default=parasol

  jobTree options for cpu/memory requirements:
    The options to specify default cpu/memory requirements (if not
    specified by the jobs themselves), and to limit the total amount of
    memory/cpu requested from the batch system.

    --defaultMemory=DEFAULTMEMORY
                        The default amount of memory to request for a job (in
                        bytes), by default is 2^31 = 2 gigabytes,
                        default=2147483648
    --defaultCpu=DEFAULTCPU
                        The default the number of cpus to dedicate a job.
                        default=1
    --maxCpus=MAXCPUS   The maximum number of cpus to request from the batch
                        system at any one time. default=9223372036854775807
    --maxMemory=MAXMEMORY
                        The maximum amount of memory to request from the batch
                        system at any one time. default=9223372036854775807

  jobTree options for rescuing/killing/restarting jobs:
    The options for jobs that either run too long/fail or get lost (some
    batch systems have issues!)

    --retryCount=RETRYCOUNT
                        Number of times to retry a failing job before giving
                        up and labeling job failed. default=0
    --maxJobDuration=MAXJOBDURATION
                        Maximum runtime of a job (in seconds) before we kill
                        it (this is a lower bound, and the actual time before
                        killing the job may be longer).
                        default=9223372036854775807
    --rescueJobsFrequency=RESCUEJOBSFREQUENCY
                        Period of time to wait (in seconds) between checking
                        for missing/overlong jobs, that is jobs which get lost
                        by the batch system. Expert parameter. (default is set
                        by the batch system)

  jobTree big batch system options:
    jobTree can employ a secondary batch system for running large
    memory/cpu jobs using the following arguments:

    --bigBatchSystem=BIGBATCHSYSTEM
                        The batch system to run for jobs with larger
                        memory/cpus requests, currently can be
                        'singleMachine'/'parasol'/'acidTest'/'gridEngine'.
                        default=none
    --bigMemoryThreshold=BIGMEMORYTHRESHOLD
                        The memory threshold above which to submit to the big
                        queue. default=9223372036854775807
    --bigCpuThreshold=BIGCPUTHRESHOLD
                        The cpu threshold above which to submit to the big
                        queue. default=9223372036854775807
    --bigMaxCpus=BIGMAXCPUS
                        The maximum number of big batch system cpus to allow
                        at one time on the big queue.
                        default=9223372036854775807
    --bigMaxMemory=BIGMAXMEMORY
                        The maximum amount of memory to request from the big
                        batch system at any one time.
                        default=9223372036854775807

  jobTree miscellaneous options:
    Miscellaneous options

    --jobTime=JOBTIME   The approximate time (in seconds) that you'd like a
                        list of child jobs to be run serially before being
                        parallelized. This parameter allows one to avoid over
                        parallelizing tiny jobs, and therefore paying
                        significant scheduling overhead, by running tiny jobs
                        in series on a single node/core of the cluster.
                        default=30
    --maxLogFileSize=MAXLOGFILESIZE
                        The maximum size of a job log file to keep (in bytes),
                        log files larger than this will be truncated to the
                        last X bytes. Default is 50 kilobytes, default=50120
    --command=COMMAND   The command to run (which will generate subsequent
                        jobs). This is deprecated
```


## jobtree_jobTreeStats

### Tool Description
Prints statistics about a jobTree.

### Metadata
- **Docker Image**: quay.io/biocontainers/jobtree:09.04.2017--py_2
- **Homepage**: https://github.com/benedictpaten/jobTree
- **Package**: https://anaconda.org/channels/bioconda/packages/jobtree/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: jobTreeStats [--jobTree] JOB_TREE_DIR [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --tempDirRoot=TEMPDIRROOT
                        Path to where temporary directory containing all temp
                        files are created, by default uses the current working
                        directory as the base.
  --jobTree=JOBTREE     Directory containing the job tree. Can also be
                        specified as the single argument to the script.
                        Default=./jobTree
  --outputFile=OUTPUTFILE
                        File in which to write results
  --raw                 output the raw xml data.
  --pretty, --human     if not raw, prettify the numbers to be human readable.
  --categories=CATEGORIES
                        comma separated list from [time, clock, wait, memory]
  --sortCategory=SORTCATEGORY
                        how to sort Target list. may be from [alpha, time,
                        clock, wait, memory, count]. default=%(default)s
  --sortField=SORTFIELD
                        how to sort Target list. may be from [min, med, ave,
                        max, total]. default=%(default)s
  --sortReverse, --reverseSort
                        reverse sort order.
  --cache               stores a cache to speed up data display.

  Logging options:
    Options that control logging

    --logOff            Turn off logging. (default is CRITICAL)
    --logInfo           Turn on logging at INFO level. (default is CRITICAL)
    --logDebug          Turn on logging at DEBUG level. (default is CRITICAL)
    --logLevel=LOGLEVEL
                        Log at level (may be either OFF/INFO/DEBUG/CRITICAL).
                        (default is CRITICAL)
    --logFile=LOGFILE   File to log in
    --rotatingLogging   Turn on rotating logging, which prevents log files
                        getting too big.
```

