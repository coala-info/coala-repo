---
name: biocontainers
description: BioContainers is a community-driven project that provides a standardized infrastructure for distributing bioinformatics software.
homepage: https://github.com/BioContainers/containers
---

# biocontainers

## Overview
BioContainers is a community-driven project that provides a standardized infrastructure for distributing bioinformatics software. It eliminates the "dependency hell" common in omics fields (genomics, proteomics, etc.) by providing pre-built, tested containers for thousands of tools. Use this skill to ensure reproducible research by leveraging the BioContainers registry instead of manual software installation.

## Accessing Containers
BioContainers are primarily hosted on **Quay.io**. The standard image URI follows this pattern:
`quay.io/biocontainers/<tool_name>:<version>--<build_string>`

### Finding the Correct Tag
1.  **Tool Name**: Use the lowercase name of the software (e.g., `samtools`, `bedtools`, `bwa`).
2.  **Version**: Match the specific software version required for your pipeline.
3.  **Build String**: BioContainers often include a hash (e.g., `he513fc3_0`) representing the specific Conda build used to create the image. Always use the full tag for exact reproducibility.

## Native Command Line Usage

### Running with Docker
To run a tool and process local data, you must mount your current working directory to a path inside the container.

**Basic Pattern:**
```bash
docker run --rm -v $(pwd):/data quay.io/biocontainers/<tool>:<tag> <command> <args>
```

**Best Practices:**
- **Cleanup**: Always use `--rm` to remove the container instance after the command finishes.
- **User Permissions**: Use `-u $(id -u):$(id -g)` to ensure output files are owned by your local user rather than root.
- **Working Directory**: Set the container's working directory with `-w /data` to simplify file pathing.

### Running with Singularity/Apptainer
Singularity is preferred in High-Performance Computing (HPC) environments where root access is restricted.

**Basic Pattern:**
```bash
singularity exec docker://quay.io/biocontainers/<tool>:<tag> <command> <args>
```

**Best Practices:**
- **Image Caching**: Set the `SINGULARITY_CACHEDIR` environment variable to avoid re-downloading large layers.
- **Shell Access**: Use `singularity shell` to explore the container environment if you need to verify installed paths or environment variables.

## Expert Tips
- **Tool Discovery**: If a tool is missing an executable or fails, check the GitHub repository issues for specific build failures (e.g., missing dependencies in the `he513fc3_0` build).
- **Multi-tool Containers**: Some containers bundle related tools (e.g., `ncbi-tools-bin`). Check the container's `/usr/local/bin` to see all available executables.
- **Architecture Awareness**: Most BioContainers are built for `linux/amd64`. If working on ARM64 (Apple Silicon or AWS Graviton), verify compatibility or use emulation, as many bioinformatics tools lack native ARM64 container builds.
- **Environment Variables**: Some tools require specific environment variables (like `JAVA_OPTS` or `PATH`). These are usually pre-configured in the Dockerfile, but can be overridden using `-e` in Docker or `--env` in Singularity.

## Reference documentation
- [BioContainers Main Repository](./references/github_com_BioContainers_containers.md)
- [BioContainers Issues and Troubleshooting](./references/github_com_BioContainers_containers_issues.md)