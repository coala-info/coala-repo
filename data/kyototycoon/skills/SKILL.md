---
name: kyototycoon
description: Kyoto Tycoon acts as a lightweight, concurrent network interface for the Kyoto Cabinet database engine.
homepage: https://github.com/alticelabs/kyoto
---

# kyototycoon

## Overview

Kyoto Tycoon acts as a lightweight, concurrent network interface for the Kyoto Cabinet database engine. It is designed for scenarios requiring high-throughput key-value storage with flexible persistence options, ranging from volatile in-memory caches to compressed on-disk B-tree structures. This skill assists in selecting the correct database tuning parameters and server options to balance data durability with raw performance.

## Server Configuration (ktserver)

The primary daemon is `ktserver`. It uses a specific URI-like syntax to define database behavior.

### Common Server Options
- `-port <num>`: Port to listen on (default: 1978).
- `-th <num>`: Number of worker threads (default: 8).
- `-log <file>`: Path to the log file.
- `-ls`: Log to standard output.
- `-ulog <dir>`: Enable binary update logging for replication or recovery.
- `-sid <num>`: Unique server ID (required for replication).

### Database Type Definitions
The database is specified as a trailing argument. Use the following suffixes and tuning parameters:

- **Persistent B-Tree (`.kct`)**: Best for ordered traversal and compression.
  - `opts=c`: Enable LZO compression.
  - `pccap=256m`: Set page cache capacity (e.g., 256MB).
  - Example: `ktserver 'db.kct#opts=c#pccap=256m'`

- **Persistent Hash (`.kch`)**: Best for O(1) lookups.
  - `bnum=1000000`: Number of buckets (should be ~2x the number of expected records).
  - `msiz=512m`: Size of the memory-mapped region.
  - Example: `ktserver 'db.kch#bnum=2000000#msiz=512m'`

- **In-Memory Hash (`*`)**: Volatile cache.
  - `capsiz=256m`: Maximum memory capacity.
  - Example: `ktserver '*#bnum=100000#capsiz=256m'`

## Performance vs. Durability

Kyoto Tycoon provides several flags to control how aggressively data is synced to disk.

- **High Performance (Volatile)**: Omit durability flags for maximum speed.
- **High Durability**: Use these flags at a significant performance cost:
  - `-oat`: On-the-fly auto transaction.
  - `-uasi <num>`: Update auto sync interval (seconds).
  - `-asi <num>`: Auto sync interval.
  - `-ash`: Auto sync hard (calls fsync).

## Protocol Compatibility

### Memcached Support
To allow memcached clients to connect, use the pluggable server system:
- `-plsv <path>`: Path to `ktplugservmemc.so`.
- `-plex 'port=11211#opts=f'`: Configuration for the memcached port and flags support.

## Management and Maintenance

### Key Management (ktremotemgr)
Use `ktremotemgr` for remote administration tasks:
- **List keys by prefix**: `ktremotemgr list -pr <prefix>`
- **List keys by regex**: `ktremotemgr list -re <regex>`
- **Report status**: `ktremotemgr report`

### Expert Tips
- **Avoid `capsiz` on disk**: Do not use the `capsiz` option with on-disk databases (`.kct` or `.kch`), as the server may stall while attempting to free space. Use auto-expiring keys instead.
- **Bucket Tuning**: If the number of records exceeds `bnum` in a hash database, performance degrades significantly due to collisions. Always over-provision buckets.
- **Memory Mapping**: Ensure `msiz` does not exceed available physical RAM to avoid heavy swap usage.

## Reference documentation
- [Kyoto Tycoon Overview and Usage](./references/github_com_AlticeLabsPublic_kyoto.md)
- [Release Notes and Feature Updates](./references/github_com_AlticeLabsPublic_kyoto_releases.md)