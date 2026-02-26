# ucsc-para CWL Generation Report

## ucsc-para_para

### Tool Description
Manage a batch of jobs in parallel on a compute cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-para:469--h664eb37_1
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-para/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-para/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
para - version 12.19
Manage a batch of jobs in parallel on a compute cluster.
Normal usage is to do a 'para create' followed by 'para push' until
job is done.  Use 'para check' to check status.
usage:

   para [options] command [command-specific arguments]

The commands are:

para create jobList
   This makes the job-tracking database from a text file with the
   command line for each job on a separate line.
   options:
      -cpu=N  Number of CPUs used by the jobs, default 1.
      -ram=N  Number of bytes of RAM used by the jobs.
         Default is RAM on node divided by number of cpus on node.
         Shorthand expressions allow t,g,m,k for tera, giga, mega, kilo.
         e.g. 4g = 4 Gigabytes.
      -batch=batchDir - specify the directory path that is used to store the
       batch control files.  The batchDir can be an absolute path or a path
       relative to the current directory.  The resulting path is use as the
       batch name.  The directory is created if it doesn't exist.  When
       creating a new batch, batchDir should not have been previously used as
       a batch name.  The batchDir must be writable by the paraHub process.
       This does not affect the working directory assigned to jobs.  It defaults
       to the directory where para is run.  If used, this option must be specified
       on all para commands for the  batch.  For example to run two batches in the
       same directory:
          para -batch=b1 make jobs1
          para -batch=b2 make jobs2
para push 
   This pushes forward the batch of jobs by submitting jobs to parasol
   It will limit parasol queue size to something not too big and
   retry failed jobs.
   options:
      -retries=N  Number of retries per job - default 4.
      -maxQueue=N  Number of jobs to allow on parasol queue. 
         Default 2000000.
      -minPush=N  Minimum number of jobs to queue. 
         Default 1.  Overrides maxQueue.
      -maxPush=N  Maximum number of jobs to queue - default 100000.
      -warnTime=N  Number of minutes job runs before hang warning. 
         Default 4320 (3 days).
      -killTime=N  Number of minutes hung job runs before push kills it.
         By default kill off for backwards compatibility.
      -delayTime=N  Number of seconds to delay before submitting next job 
         to minimize i/o load at startup - default 0.
      -priority=x  Set batch priority to high, medium, or low.
         Default medium (use high only with approval).
         If needed, use with make, push, create, shove, or try.
         Or, set batch priority to a specific numeric value - default 10.
         1 is emergency high priority, 
         10 is normal medium, 
         100 is low for bottomfeeders.
         Setting priority higher than normal (1-9) will be logged.
         Please keep low priority jobs short, they won't be pre-empted.
      -maxJob=x  Limit the number of jobs the batch can run.
         Specify number of jobs, for example 10 or 'unlimited'.
         Default unlimited displays as -1.
      -jobCwd=dir - specify the directory path to use as the current working
       directory for each job.  The dir can be an absolute path or a path
       relative to the current directory. It defaults to the directory where
       para is run.
para try 
   This is like para push, but only submits up to 10 jobs.
para shove
   Push jobs in this database until all are done or one fails after N retries.
para make jobList
   Create database and run all jobs in it if possible.  If one job
   fails repeatedly this will fail.  Suitable for inclusion in makefiles.
   Same as a 'create' followed by a 'shove'.
para check
   This checks on the progress of the jobs.
para stop
   This stops all the jobs in the batch.
para chill
   Tells system to not launch more jobs in this batch, but
   does not stop jobs that are already running.
para finished
   List jobs that have finished.
para hung
   List hung jobs in the batch (running > killTime).
para slow
   List slow jobs in the batch (running > warnTime).
para crashed
   List jobs that crashed or failed output checks the last time they were run.
para failed
   List jobs that crashed after repeated restarts.
para status
   List individual job status, including times.
para problems
   List jobs that had problems (even if successfully rerun).
   Includes host info.
para running
   Print info on currently running jobs.
para hippos time
   Print info on currently running jobs taking > 'time' (minutes) to run.
para time
   List timing information.
para recover jobList newJobList
   Generate a job list by selecting jobs from an existing list where
   the `check out' tests fail.
para priority 999
   Set batch priority. Values explained under 'push' options above.
para maxJob 999
   Set batch maxJob. Values explained under 'push' options above.
para ram 999
   Set batch ram usage. Values explained under 'push' options above.
para cpu 999
   Set batch cpu usage. Values explained under 'push' options above.
para resetCounts
   Set batch done and crash counters to 0.
para flushResults
   Flush results file.  Warns if batch has jobs queued or running.
para freeBatch
   Free all batch info on hub.  Works only if batch has nothing queued or running.
para showSickNodes
   Show sick nodes which have failed when running this batch.
para clearSickNodes
   Clear sick nodes statistics and consecutive crash counts of batch.

Common options
   -verbose=1 - set verbosity level.
```

