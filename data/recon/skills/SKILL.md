---
name: recon
description: The recon tool automates information gathering and vulnerability identification by orchestrating various security tools to map an organization's external attack surface. Use when user asks to perform subdomain enumeration, conduct OSINT, analyze web assets, or run automated vulnerability scans on a target domain.
homepage: https://github.com/six2dez/reconftw
---


# recon

## Overview

The recon skill leverages the reconFTW framework to automate the complex process of information gathering and vulnerability identification. It orchestrates a wide array of specialized security tools to perform passive and active discovery, including OSINT, subdomain enumeration, web analysis, and host scanning. This skill transforms a single target domain into a comprehensive map of an organization's external attack surface, identifying potential entry points and misconfigurations.

## Core Workflows

### Target Specification
- **Single Domain**: Use `-d` followed by the target domain.
- **Domain List**: Use `-l` followed by a path to a text file containing one domain per line.

### Execution Modes
- **All-in-One (-a)**: Performs the full suite of tests (OSINT, subdomains, hosts, web, and vulnerabilities). This is the most thorough but time-consuming option.
- **Recon (-r)**: Performs full reconnaissance without the final vulnerability scanning phase.
- **Subdomains (-s)**: Focuses exclusively on subdomain discovery (passive, active, and permutations).
- **Web Analysis (-w)**: Probes for live web servers, takes screenshots, and performs directory fuzzing.
- **OSINT (-o)**: Gathers domain info, emails, and searches for leaks without active scanning.
- **Vulnerability (-v)**: Runs targeted vulnerability checks (XSS, SSRF, SQLi, etc.) on discovered web targets.

## CLI Usage Patterns

### Basic Commands
```bash
# Perform full reconnaissance on a single domain
./reconftw.sh -d example.com -r

# Run all modules including vulnerability scans on a list of targets
./reconftw.sh -l targets.txt -a

# Perform only passive reconnaissance (useful for stealth)
./reconftw.sh -d example.com -o
```

### Advanced Options
- **Deep Scan**: Combine modes or use specific flags for deeper discovery.
- **Interactive Mode (-i)**: Prompts for confirmation before running specific modules.
- **Axiom Support**: If the Ax Framework is configured, use the appropriate flags to distribute the scan across multiple VPS instances for massive speed gains.

## Expert Tips

- **Configuration First**: Before running a scan, ensure `reconftw.cfg` is populated with your API keys (e.g., BinaryEdge, Chaos, GitHub, Shodan). This significantly increases the success rate of passive discovery.
- **Data Management**: Results are organized in the `Recon/` directory by domain name. Familiarize yourself with the sub-folder structure (e.g., `subdomains/`, `webs/`, `vulns/`) to quickly locate specific findings.
- **Resource Intensity**: Full scans (`-a`) are resource-heavy. When scanning large scopes, prefer running on a VPS or using the Ax Framework integration to avoid local bandwidth or CPU bottlenecks.
- **WAF Awareness**: Active scanning can trigger Web Application Firewalls. Use the web analysis results to identify WAFs (`wafw00f` integration) before launching aggressive vulnerability scans.

## Reference documentation
- [reconFTW Main Repository](./references/github_com_six2dez_reconftw.md)
- [reconFTW Wiki Home](./references/github_com_six2dez_reconftw_wiki.md)