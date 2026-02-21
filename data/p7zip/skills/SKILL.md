---
name: p7zip
description: p7zip is a powerful command-line utility for file compression and archiving, derived from the 7-Zip project.
homepage: https://github.com/p7zip-project/p7zip
---

# p7zip

## Overview
p7zip is a powerful command-line utility for file compression and archiving, derived from the 7-Zip project. This specific version (p7zip-zstd) extends the standard 7-Zip capabilities by integrating advanced codecs that offer superior speed and compression ratios compared to traditional methods. It is the preferred tool for system administrators and developers who need to handle complex archive formats, create encrypted backups, or optimize data transfer using multi-threaded compression.

## Core Commands
The primary binary for this version is `7zz`. Use the following command patterns for common tasks:

- **Extract with full paths**: `7zz x archive.7z`
- **Extract without directory structure**: `7zz e archive.7z`
- **Create/Add to archive**: `7zz a archive.7z path/to/files`
- **List archive contents**: `7zz l archive.7z`
- **Test archive integrity**: `7zz t archive.7z`
- **Update files in archive**: `7zz u archive.7z path/to/files`

## Advanced Codec Usage
This fork supports specialized compression methods via the `-m` switch.

| Codec | Flag | Levels | Best For |
|-------|------|--------|----------|
| **Zstandard** | `-m0=zstd` | 1..22 | Real-time compression/speed trade-off |
| **LZ4** | `-m0=lz4` | 1..12 | Extremely fast decompression |
| **Brotli** | `-m0=brotli` | 0..11 | Web-optimized, dense general purpose |
| **Fast LZMA2** | `-m0=flzma2` | 1..9 | Faster than standard LZMA2 |
| **Lizard** | `-m0=lizard` | 10..49 | High decompression speed (1000MB/s+) |

**Example: High-ratio Zstd compression**
```bash
7zz a -m0=zstd -mx=22 archive.7z folder/
```

## Expert Tips and Best Practices

### Multi-threading
Enable multi-threading to significantly speed up compression on multi-core systems:
- Use `-mmt=on` to auto-detect cores.
- Use `-mmt={N}` to specify a specific number of threads (e.g., `-mmt=4`).

### Security and Encryption
7-Zip provides strong AES-256 encryption.
- **Encrypt files**: `7zz a -p{password} archive.7z`
- **Encrypt headers**: Use `-mhe=on` to hide filenames within the archive until the password is provided.
  ```bash
  7zz a -pSECRET -mhe=on archive.7z private_docs/
  ```

### Working with Large Archives
- **Split archives into volumes**: Use the `-v` switch (e.g., `-v1g` for 1GB parts).
  ```bash
  7zz a -v1g archive.7z large_data/
  ```
- **Exclude specific files**: Use `-x!{pattern}` (e.g., `-x!*.log`).

### Handling Diverse Formats
p7zip can read many formats it cannot create. Use `7zz l` to inspect:
- **Disk Images**: APFS, DMG, ISO, HFS, NTFS, FAT, EXT.
- **Installers/Executables**: MSI, CAB, ELF, Mach-O, PE.
- **Legacy Archives**: ARJ, LZH, CPIO, RPM, DEB.

## Reference documentation
- [p7zip Main Repository](./references/github_com_p7zip-project_p7zip.md)
- [p7zip Wiki - Zstd Method Details](./references/github_com_p7zip-project_p7zip_wiki.md)