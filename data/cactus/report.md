# cactus CWL Generation Report

## cactus

### Tool Description
A pipeline for whole-genome alignment and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus:2019.03.01--py27hdbcaa40_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cactus/overview
- **Total Downloads**: 23.3K
- **Last updated**: 2025-10-19
- **GitHub**: https://github.com/ComparativeGenomicsToolkit/cactus
- **Stars**: N/A
### Original Help Text
```text
usage: cactus [-h] [--logOff] [--logCritical] [--logError] [--logWarning]
              [--logInfo] [--logDebug] [--logLevel LOGLEVEL]
              [--logFile LOGFILE] [--rotatingLogging] [--workDir WORKDIR]
              [--stats] [--clean {always,onError,never,onSuccess}]
              [--cleanWorkDir {always,never,onSuccess,onError}] [--restart]
              [--batchSystem BATCHSYSTEM] [--scale SCALE]
              [--mesosMaster MESOSMASTERADDRESS]
              [--parasolCommand PARASOLCOMMAND]
              [--parasolMaxBatches PARASOLMAXBATCHES]
              [--provisioner {cgcloud}] [--nodeType TYPE]
              [--nodeOptions OPTIONS] [--minNodes NUM] [--maxNodes NUM]
              [--preemptableNodeType TYPE] [--preemptableNodeOptions OPTIONS]
              [--minPreemptableNodes NUM] [--maxPreemptableNodes NUM]
              [--alphaPacking ALPHAPACKING] [--betaInertia BETAINERTIA]
              [--scaleInterval SCALEINTERVAL] [--defaultMemory INT]
              [--defaultCores FLOAT] [--defaultDisk INT]
              [--readGlobalFileMutableByDefault] [--maxCores INT]
              [--maxMemory INT] [--maxDisk INT] [--retryCount RETRYCOUNT]
              [--maxJobDuration MAXJOBDURATION]
              [--rescueJobsFrequency RESCUEJOBSFREQUENCY]
              [--maxLogFileSize MAXLOGFILESIZE] [--realTimeLogging]
              [--sseKey SSEKEY] [--cseKey CSEKEY]
              [--setEnv NAME=VALUE or NAME]
              [--servicePollingInterval SERVICEPOLLINGINTERVAL]
              [--badWorker BADWORKER]
              [--badWorkerFailInterval BADWORKERFAILINTERVAL]
              [--experiment EXPERIMENTFILE] [--buildAvgs] [--buildReference]
              [--buildHal] [--buildFasta]
              [--intermediateResultsUrl INTERMEDIATERESULTSURL]
              [--database DATABASE] [--configFile CONFIGFILE] [--root ROOT]
              [--latest] [--containerImage CONTAINERIMAGE]
              [--binariesMode {docker,local,singularity}]
              jobStore seqFile outputHal

positional arguments:
  seqFile               Seq file
  outputHal             Output HAL file

optional arguments:
  -h, --help            show this help message and exit
  --experiment EXPERIMENTFILE
                        The file containing a link to the experiment
                        parameters
  --buildAvgs           Build trees
  --buildReference      Creates a reference ordering for the flowers
  --buildHal            Build a hal file
  --buildFasta          Build a fasta file of the input sequences (and
                        reference sequence, used with hal output)
  --intermediateResultsUrl INTERMEDIATERESULTSURL
                        URL prefix to save intermediate results like DB dumps
                        to (e.g. prefix-dump-caf, prefix-dump-avg, etc.)
  --database DATABASE   Database type: tokyo_cabinet or kyoto_tycoon [default:
                        kyoto_tycoon]
  --configFile CONFIGFILE
                        Specify cactus configuration file
  --root ROOT           Name of ancestral node (which must appear in NEWICK
                        tree in <seqfile>) to use as a root for the alignment.
                        Any genomes not below this node in the tree may be
                        used as outgroups but will never appear in the output.
                        If no root is specifed then the root of the tree is
                        used.
  --latest              Use the latest version of the docker container rather
                        than pulling one matching this version of cactus
  --containerImage CONTAINERIMAGE
                        Use the the specified pre-built containter image
                        rather than pulling one from quay.io
  --binariesMode {docker,local,singularity}
                        The way to run the Cactus binaries

Logging Options:
  Options that control logging

  --logOff              Same as --logCritical
  --logCritical         Turn on logging at level CRITICAL and above. (default
                        is INFO)
  --logError            Turn on logging at level ERROR and above. (default is
                        INFO)
  --logWarning          Turn on logging at level WARNING and above. (default
                        is INFO)
  --logInfo             Turn on logging at level INFO and above. (default is
                        INFO)
  --logDebug            Turn on logging at level DEBUG and above. (default is
                        INFO)
  --logLevel LOGLEVEL   Log at given level (may be either OFF (or CRITICAL),
                        ERROR, WARN (or WARNING), INFO or DEBUG). (default is
                        INFO)
  --logFile LOGFILE     File to log in
  --rotatingLogging     Turn on rotating logging, which prevents log files
                        getting too big.

toil core options:
  Options to specify the location of the toil workflow and turn on stats
  collation about the performance of jobs.

  jobStore              Store in which to place job management files and the
                        global accessed temporary files. Job store locator
                        strings should be formatted as follows aws:<AWS
                        region>:<name prefix> azure:<account>:<name prefix>'
                        google:<project id>:<name prefix> file:<file path>
                        Note that for backwards compatibility ./foo is
                        equivalent to file:/foo and /bar is equivalent to
                        file:/bar. (If this is a file path this needs to be
                        globally accessible by all machines running jobs). If
                        the store already exists and restart is false a
                        JobStoreCreationException exception will be thrown.
  --workDir WORKDIR     Absolute path to directory where temporary files
                        generated during the Toil run should be placed. Temp
                        files and folders will be placed in a directory
                        toil-<workflowID> within workDir (The workflowID is
                        generated by Toil and will be reported in the workflow
                        logs. Default is determined by the user-defined
                        environmental variable TOIL_TEMPDIR, or the
                        environment variables (TMPDIR, TEMP, TMP) via mkdtemp.
                        This directory needs to exist on all machines running
                        jobs.
  --stats               Records statistics about the toil workflow to be used
                        by 'toil stats'.
  --clean {always,onError,never,onSuccess}
                        Determines the deletion of the jobStore upon
                        completion of the program. Choices: 'always',
                        'onError','never', 'onSuccess'. The --stats option
                        requires information from the jobStore upon completion
                        so the jobStore will never be deleted withthat flag.
                        If you wish to be able to restart the run, choose
                        'never' or 'onSuccess'. Default is 'never' if stats is
                        enabled, and 'onSuccess' otherwise
  --cleanWorkDir {always,never,onSuccess,onError}
                        Determines deletion of temporary worker directory upon
                        completion of a job. Choices: 'always', 'never',
                        'onSuccess'. Default = always. WARNING: This option
                        should be changed for debugging only. Running a full
                        pipeline with this option could fill your disk with
                        intermediate data.

toil options for restarting an existing workflow:
  Allows the restart of an existing workflow

  --restart             If --restart is specified then will attempt to restart
                        existing workflow at the location pointed to by the
                        --jobStore option. Will raise an exception if the
                        workflow does not exist

toil options for specifying the batch system:
  Allows the specification of the batch system, and arguments to the batch
  system/big batch system (see below).

  --batchSystem BATCHSYSTEM
                        The type of batch system to run the job(s) with,
                        currently can be one of singleMachine, parasol,
                        gridEngine, lsf or mesos'. default=singleMachine
  --scale SCALE         A scaling factor to change the value of all submitted
                        tasks's submitted cores. Used in singleMachine batch
                        system. default=1
  --mesosMaster MESOSMASTERADDRESS
                        The host and port of the Mesos master separated by
                        colon. default=localhost:5050
  --parasolCommand PARASOLCOMMAND
                        The name or path of the parasol program. Will be
                        looked up on PATH unless it starts with a
                        slashdefault=parasol
  --parasolMaxBatches PARASOLMAXBATCHES
                        Maximum number of job batches the Parasol batch is
                        allowed to create. One batch is created for jobs with
                        a a unique set of resource requirements. default=10000

toil options for autoscaling the cluster of worker nodes:
  Allows the specification of the minimum and maximum number of nodes in an
  autoscaled cluster, as well as parameters to control the level of
  provisioning.

  --provisioner {cgcloud}
                        The provisioner for cluster auto-scaling. Currently
                        only the cgcloud provisioner exists. The default is
                        None.
  --nodeType TYPE       Node type for non-preemptable nodes. The syntax
                        depends on the provisioner used. For the cgcloud
                        provisioner this is the name of an EC2 instance type,
                        for example 'c3.8xlarge'. The default is None.
  --nodeOptions OPTIONS
                        Provisioning options for the non-preemptable node
                        type. The syntax depends on the provisioner used. For
                        the cgcloud provisioner this is a space-separated list
                        of options to cgcloud's grow-cluster command (run
                        'cgcloud grow-cluster --help' for details. The default
                        is None.
  --minNodes NUM        Minimum number of non-preemptable nodes in the
                        cluster, if using auto-scaling. The default is 0.
  --maxNodes NUM        Maximum number of non-preemptable nodes in the
                        cluster, if using auto-scaling. The default is 10.
  --preemptableNodeType TYPE
                        Node type for preemptable nodes. The syntax depends on
                        the provisioner used. For the cgcloud provisioner this
                        is the name of an EC2 instance type, followed by a
                        colon and the price in dollar to bid for a spot
                        instance, for example 'c3.8xlarge:0.42'. The default
                        is None.
  --preemptableNodeOptions OPTIONS
                        Provisioning options for the preemptable node type.
                        The syntax depends on the provisioner used. For the
                        cgcloud provisioner this is a space-separated list of
                        options to cgcloud's grow-cluster command (run
                        'cgcloud grow-cluster --help' for details. The default
                        is None.
  --minPreemptableNodes NUM
                        Minimum number of preemptable nodes in the cluster, if
                        using auto-scaling. The default is 0.
  --maxPreemptableNodes NUM
                        Maximum number of preemptable nodes in the cluster, if
                        using auto-scaling. The default is 10.
  --alphaPacking ALPHAPACKING
                        default=0.8
  --betaInertia BETAINERTIA
                        default=1.2
  --scaleInterval SCALEINTERVAL
                        The interval (seconds) between assessing if the scale
                        of the cluster needs to change. default=360

toil options for cores/memory requirements:
  The options to specify default cores/memory requirements (if not specified
  by the jobs themselves), and to limit the total amount of memory/cores
  requested from the batch system.

  --defaultMemory INT   The default amount of memory to request for a job.
                        Only applicable to jobs that do not specify an
                        explicit value for this requirement. Standard suffixes
                        like K, Ki, M, Mi, G or Gi are supported. Default is
                        2.0 Gi
  --defaultCores FLOAT  The default number of CPU cores to dedicate a job.
                        Only applicable to jobs that do not specify an
                        explicit value for this requirement. Fractions of a
                        core (for example 0.1) are supported on some batch
                        systems, namely Mesos and singleMachine. Default is
                        1.0
  --defaultDisk INT     The default amount of disk space to dedicate a job.
                        Only applicable to jobs that do not specify an
                        explicit value for this requirement. Standard suffixes
                        like K, Ki, M, Mi, G or Gi are supported. Default is
                        2.0 Gi
  --readGlobalFileMutableByDefault
                        Toil disallows modification of read global files by
                        default. This flag makes it makes read file mutable by
                        default, however it also defeats the purpose of shared
                        caching via hard links to save space. Default is False
  --maxCores INT        The maximum number of CPU cores to request from the
                        batch system at any one time. Standard suffixes like
                        K, Ki, M, Mi, G or Gi are supported. Default is 8.0 Ei
  --maxMemory INT       The maximum amount of memory to request from the batch
                        system at any one time. Standard suffixes like K, Ki,
                        M, Mi, G or Gi are supported. Default is 8.0 Ei
  --maxDisk INT         The maximum amount of disk space to request from the
                        batch system at any one time. Standard suffixes like
                        K, Ki, M, Mi, G or Gi are supported. Default is 8.0 Ei

toil options for rescuing/killing/restarting jobs:
  The options for jobs that either run too long/fail or get lost (some batch
  systems have issues!)

  --retryCount RETRYCOUNT
                        Number of times to retry a failing job before giving
                        up and labeling job failed. default=0
  --maxJobDuration MAXJOBDURATION
                        Maximum runtime of a job (in seconds) before we kill
                        it (this is a lower bound, and the actual time before
                        killing the job may be longer).
                        default=9223372036854775807
  --rescueJobsFrequency RESCUEJOBSFREQUENCY
                        Period of time to wait (in seconds) between checking
                        for missing/overlong jobs, that is jobs which get lost
                        by the batch system. Expert parameter. default=3600

toil miscellaneous options:
  Miscellaneous options

  --maxLogFileSize MAXLOGFILESIZE
                        The maximum size of a job log file to keep (in bytes),
                        log files larger than this will be truncated to the
                        last X bytes. Default is 50 kilobytes, default=50120
  --realTimeLogging     Enable real-time logging from workers to masters
  --sseKey SSEKEY       Path to file containing 32 character key to be used
                        for server-side encryption on awsJobStore. SSE will
                        not be used if this flag is not passed.
  --cseKey CSEKEY       Path to file containing 256-bit key to be used for
                        client-side encryption on azureJobStore. By default,
                        no encryption is used.
  --setEnv NAME=VALUE or NAME, -e NAME=VALUE or NAME
                        Set an environment variable early on in the worker. If
                        VALUE is omitted, it will be looked up in the current
                        environment. Independently of this option, the worker
                        will try to emulate the leader's environment before
                        running a job. Using this option, a variable can be
                        injected into the worker process itself before it is
                        started.
  --servicePollingInterval SERVICEPOLLINGINTERVAL
                        Interval of time service jobs wait between polling for
                        the existence of the keep-alive flag (defailt=60)

toil debug options:
  Debug options

  --badWorker BADWORKER
                        For testing purposes randomly kill 'badWorker'
                        proportion of jobs using SIGKILL, default=0.0
  --badWorkerFailInterval BADWORKERFAILINTERVAL
                        When killing the job pick uniformly within the
                        interval from 0.0 to 'badWorkerFailInterval' seconds
                        after the worker starts, default=0.01
```

