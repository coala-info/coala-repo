# A Future for R: Available Future Backends

The **future** package comes with built-in future backends that leverage the **parallel** package part of R itself. In addition to these backends, others exist in package extensions, e.g. **[future.callr](https://future.callr.futureverse.org)**, **[future.mirai](https://future.mirai.futureverse.org)**, and **[future.batchtools](https://future.batchtools.futureverse.org)**. Below is an overview of the most common backends that you as an end-user can chose from.

| Package / Backend | Features | How futures are evaluated |
| --- | --- | --- |
| **future**  `sequential` | 📶 ♻️ | sequentially and in the current R process; default Example: `plan(sequential)` |
| **future**  `multisession` | 📶 ♻️ | parallelly via background R sessions on current machine Examples: `plan(multisession)` and `plan(multisession, workers = 2)` |
| **future**  `cluster` | 📶 ♻️\* | parallelly in external R sessions on current, local, and/or remote machines Examples: `plan(cluster, workers = "raspberry-pi")`, `plan(cluster, workers = c("localhost", "n1", "n1", "pi.example.org"))` |
| **future**  `multicore` | 📶 ♻️ | (not recommended) parallelly via forked R processes on current machine; not with GUIs like RStudio; not on Windows Examples: `plan(multicore)` and `plan(multicore, workers = 2)` |
| **[future.callr](https://future.callr.futureverse.org)**  `callr` | 📶 ♻️ | parallelly via transient **[callr](https://cran.r-project.org/package%3Dcallr)** background R sessions on current machine; all memory is returned when as each future is resolved Examples: `plan(callr)` and `plan(callr, workers = 2)` |
| **[future.mirai](https://future.mirai.futureverse.org)**  `mirai_multisession` | 📶 ♻️ | parallelly via **[mirai](https://cran.r-project.org/package%3Dmirai)** background R sessions on current machine; low latency Examples: `plan(mirai_multisession)` and `plan(mirai_multisession, workers = 2)` |
| **[future.mirai](https://future.mirai.futureverse.org)**  `mirai_cluster` | ♻️ | parallelly via **[mirai](https://cran.r-project.org/package%3Dmirai)** daemons running locally or remotely Example: `plan(mirai_cluster)` |
| **[future.batchtools](https://future.batchtools.futureverse.org)**  `batchtools_lsf` `batchtools_openlava` `batchtools_sge` `batchtools_slurm` `batchtools_torque` | 📶(soon)  ♻️ | parallelly on HPC job schedulers (Load Sharing Facility [LSF], OpenLava, TORQUE/PBS, Son/Sun/Oracle/Univa Grid Engine [SGE], Slurm) via **[batchtools](https://cran.r-project.org/package%3Dbatchtools)**; for long-running tasks; high latency |

📶: futures relay progress updates in real-time, e.g. **[progressr](https://progressr.futureverse.org)**
♻️: futures are interruptible and restartable; \* interrupts are disabled by default
(next): next release; (soon): in a near-future release