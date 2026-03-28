## Benchmarking Programs

---

* [IOR](https://github.com/LLNL/ior) has a 'driver' for PnetCDF
* The [E3SM I/O kernel](https://github.com/Parallel-NetCDF/E3SM-IO)
  is a case study of parallel I/O kernel of the
  [E3SM](https://github.com/E3SM-Project/E3SM) climate simulation model.
  The I/O pattern exhibits a large volume of non-contiguous requests.
* The
  [FLASH
  I/O kernel](http://flash.uchicago.edu/~jbgallag/io_bench/flash_io_bench.tar.gz), developed at the FLASH center of University of Chicago, measure
  severals write-only workloads. Starting from 1.4.0 release, PnetCDF
  distribution includes
  [the
  FLASH-IO kernel that uses PnetCDF APIs](https://github.com/Parallel-NetCDF/PnetCDF/tree/master/benchmarks/FLASH-IO).
* [BTIO](https://github.com/Parallel-NetCDF/BTIO) is a
  block-tridiagonal partitioning pattern on a three-dimensional array across a
  square number of MPI processes, part of NASA's NAS Parallel Benchmarks (NPB)
  suite.
* [GCRM-IO](https://github.com/Parallel-NetCDF/GCRM-IO) is the I/O
  kernel of Global Cloud Resolving Model (GCRM) simulation codes. GCRM was
  developed at the Colorado State University.
* [S3D-IO](https://github.com/Parallel-NetCDF/S3D-IO) is the I/O
  kernel of S3D combustion simulation code, a continuum scale first principles
  direct numerical simulation code which solves the compressible governing
  equations of mass continuity, momenta, energy and mass fractions of chemical
  species including chemical reactions, developed at the Sandia National
  Laboratory.

Be mindful of benchmarks which write large contiguous chunks of data. While
interesting, it might not be what a scientific application using PnetCDF would
actually do.

Older versions of IOR triggered a performance bug on some Lustre file systems.
Sometimes slow write performance on Lustre can be fixed by disabling the "data
sieving" optimization. See [HintsForPnetcdf](HintsForPnetcdf.html)
for more information.