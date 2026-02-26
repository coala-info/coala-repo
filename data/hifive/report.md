# hifive CWL Generation Report

## hifive

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
- **Homepage**: https://github.com/bxlab/hifive
- **Package**: https://anaconda.org/channels/bioconda/packages/hifive/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/hifive/overview
- **Total Downloads**: 45.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bxlab/hifive
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
--------------------------------------------------------------------------
The value of the MCA parameter "plm_rsh_agent" was set to a path
that could not be found:

  plm_rsh_agent: ssh : rsh

Please either unset the parameter, or check that the path is correct
--------------------------------------------------------------------------
[9dd1e4b3211c:00007] [[INVALID],INVALID] FORCE-TERMINATE AT Not found:-13 - error plm_rsh_component.c(327)
[9dd1e4b3211c:00007] *** Process received signal ***
[9dd1e4b3211c:00007] Signal: Segmentation fault (11)
[9dd1e4b3211c:00007] Signal code: Address not mapped (1)
[9dd1e4b3211c:00007] Failing at address: (nil)
[9dd1e4b3211c:00007] [ 0] /lib/libpthread.so.0(+0x10220)[0x712427e8d220]
[9dd1e4b3211c:00007] *** End of error message ***
[9dd1e4b3211c:00001] [[INVALID],INVALID] ORTE_ERROR_LOG: Unable to start a daemon on the local node in file ess_singleton_module.c at line 532
[9dd1e4b3211c:00001] [[INVALID],INVALID] ORTE_ERROR_LOG: Unable to start a daemon on the local node in file ess_singleton_module.c at line 166
--------------------------------------------------------------------------
It looks like orte_init failed for some reason; your parallel process is
likely to abort.  There are many reasons that a parallel process can
fail during orte_init; some of which are due to configuration or
environment problems.  This failure appears to be an internal failure;
here's some additional information (which may only be relevant to an
Open MPI developer):

  orte_ess_init failed
  --> Returned value Unable to start a daemon on the local node (-127) instead of ORTE_SUCCESS
--------------------------------------------------------------------------
--------------------------------------------------------------------------
It looks like MPI_INIT failed for some reason; your parallel process is
likely to abort.  There are many reasons that a parallel process can
fail during MPI_INIT; some of which are due to configuration or environment
problems.  This failure appears to be an internal failure; here's some
additional information (which may only be relevant to an Open MPI
developer):

  ompi_mpi_init: ompi_rte_init failed
  --> Returned "Unable to start a daemon on the local node" (-127) instead of "Success" (0)
--------------------------------------------------------------------------
*** An error occurred in MPI_Init_thread
*** on a NULL communicator
*** MPI_ERRORS_ARE_FATAL (processes in this communicator will now abort,
***    and potentially your MPI job)
[9dd1e4b3211c:00001] Local abort before MPI_INIT completed completed successfully, but am not able to aggregate error messages, and not able to guarantee that all other processes were killed!
```

