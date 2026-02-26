# relion-binplusmpi CWL Generation Report

## relion-binplusmpi_relion_refine_mpi

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/3dem/relion
- **Package**: https://anaconda.org/channels/bioconda/packages/relion/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/relion-binplusmpi/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/3dem/relion
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
```

