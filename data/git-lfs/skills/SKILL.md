---
name: git-lfs
description: Git Large File Storage (LFS) replaces large files with text pointers inside Git while storing the actual file contents on a remote server.
homepage: https://github.com/git-lfs/git-lfs
---

# git-lfs

## Overview
Git Large File Storage (LFS) replaces large files with text pointers inside Git while storing the actual file contents on a remote server. This prevents repository bloat and keeps fetch/clone operations fast. Use this skill to configure tracking patterns, handle repository migrations, and manage binary assets without degrading Git performance.

## Core Workflows

### Initialization and Tracking
Before using LFS in a repository, ensure the extension is installed globally and initialized for the local project.

- **Initialize LFS**: `git lfs install` (Run once per machine/user).
- **Track file types**: `git lfs track "*.psd"` (Quotes prevent shell expansion).
- **Verify tracking**: Check the `.gitattributes` file to ensure patterns are recorded.
- **Commit changes**: Always commit `.gitattributes` after changing tracking patterns.

### Managing Files
- **List tracked files**: `git lfs ls-files` to see which files are currently managed by LFS.
- **Check local storage**: `git lfs status` shows the status of LFS objects in the current checkout.
- **Force download**: `git lfs pull` to fetch and checkout all LFS objects for the current branch.
- **Prune old data**: `git lfs prune` to delete old local LFS objects and free up disk space.

### History Migration
If large files were committed to Git history before LFS was enabled, they must be migrated to reduce repository size.

- **Import history**: `git lfs migrate import --include="*.zip" --everything`
  - *Warning*: This rewrites history and changes commit hashes.
- **Export history**: `git lfs migrate export --include="*.zip" --everything`
  - Use this to convert LFS pointers back into regular Git objects.

### File Locking
Use locking to prevent merge conflicts on binary files that cannot be merged automatically.

- **Lock a file**: `git lfs lock path/to/file.png`
- **View locks**: `git lfs locks`
- **Unlock a file**: `git lfs unlock path/to/file.png`
- **Force unlock**: `git lfs unlock --force <id>` (Requires administrative permissions).

## Expert Tips
- **Batching**: Git LFS automatically batches transfers to improve performance over high-latency connections.
- **Pointer Verification**: If a file appears as a small text file containing an OID instead of the actual data, run `git lfs checkout` to resolve the pointers.
- **SSH vs HTTPS**: LFS usually defaults to HTTPS for data transfer even if the Git remote uses SSH. Ensure your credentials helper is configured if you encounter 401 Unauthorized errors.
- **Partial Clones**: Use `git clone -S` (or `git lfs clone`) for faster cloning of repositories with massive LFS histories, as it optimizes the download of LFS objects.

## Reference documentation
- [Git LFS README](./references/github_com_git-lfs_git-lfs.md)
- [Git LFS Wiki](./references/github_com_git-lfs_git-lfs_wiki.md)