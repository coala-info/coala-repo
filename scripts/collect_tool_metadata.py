#!/usr/bin/env python3
"""
Collect metadata for conda tools: conda overview URL, total downloads,
last updated time, GitHub URL and star count.

For each tool, if <workspace>/<tool>/report.md exists, any Conda and GitHub URLs
in the report's Metadata section are used directly; the script still fetches
downloads, last updated, and stars from APIs. The collected data is then written
back into the report's Metadata (Conda, Total Downloads, Last updated, GitHub, Stars).

Channels:
  - bioconda (default): e.g. https://anaconda.org/channels/bioconda/packages/macs3/overview
  - r: for R packages (names starting with r-), e.g. https://anaconda.org/channels/r/packages/r-tidyr/overview

Example:
  python -m cwlagent.scripts.collect_tool_metadata macs3
  python -m cwlagent.scripts.collect_tool_metadata r-tidyr --workspace /path/to/repo

Usage:
  python -m cwlagent.scripts.collect_tool_metadata TOOL [TOOL ...]
  python -m cwlagent.scripts.collect_tool_metadata --channel bioconda --from-file tools.txt
  python -m cwlagent.scripts.collect_tool_metadata r-tidyr --workspace .   # updates r-tidyr/report.md
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

import httpx

ANACONDA_PACKAGE_API = "https://api.anaconda.org/package/{channel}/{package}"
GITHUB_REPO_API = "https://api.github.com/repos/{owner}/{repo}"
GITHUB_REPO_RE = re.compile(
    r"https?://github\.com/([^/]+)/([^/?#\s]+?)(?:\.git)?/?\s*$",
    re.I,
)
DEFAULT_CHANNEL = "bioconda"
R_CHANNEL = "r"
CONDA_OVERVIEW_URL = "https://anaconda.org/channels/{channel}/packages/{package}/overview"
USER_AGENT = "CWLAgent/1.0 (metadata collector)"
# Match "- **Label**: value" in report.md
REPORT_MD_METADATA_RE = re.compile(r"^- \*\*([^*]+)\*\*:\s*(.+)$")
# anaconda.org/channels/CHANNEL/packages/PACKAGE/overview
CONDA_CHANNELS_PACKAGES_RE = re.compile(
    r"https?://anaconda\.org/channels/([^/]+)/packages/([^/?#\s]+)(?:/overview)?/?\s*$", re.I
)
# anaconda.org/CHANNEL/PACKAGE (e.g. anaconda.org/r/r-tidyr)
CONDA_CHANNEL_PACKAGE_RE = re.compile(
    r"https?://anaconda\.org/([^/]+)/([^/?#\s]+)/?\s*$", re.I
)


def _parse_conda_channel_package(url: str) -> tuple[str, str] | None:
    """Parse conda channel and package from anaconda.org URL. Returns (channel, package) or None."""
    if not url:
        return None
    url = url.strip().rstrip("/")
    m = CONDA_CHANNELS_PACKAGES_RE.match(url)
    if m:
        return (m.group(1), m.group(2))
    m = CONDA_CHANNEL_PACKAGE_RE.match(url)
    if m:
        return (m.group(1), m.group(2))
    return None


def _parse_report_metadata(report_path: Path) -> dict:
    """
    Parse first ### Metadata or ## Metadata section in report.md.
    Returns dict with: conda_url, github_url (first GitHub URL found), metadata_section_start, metadata_section_end, lines.
    """
    out = {
        "conda_url": None,
        "github_url": None,
        "metadata_section_start": -1,
        "metadata_section_end": -1,
        "lines": [],
    }
    if not report_path.exists():
        return out
    text = report_path.read_text(encoding="utf-8")
    lines = text.splitlines()
    out["lines"] = lines
    # Find first ### Metadata or ## Metadata
    start = -1
    for i, line in enumerate(lines):
        s = line.strip()
        if s == "### Metadata" or s.lower() == "## metadata":
            start = i
            break
    if start < 0:
        return out
    out["metadata_section_start"] = start
    end = start + 1
    for j in range(start + 1, len(lines)):
        stripped = lines[j].strip()
        if stripped.startswith("#") and not stripped.startswith("# "):
            end = j
            break
        mm = REPORT_MD_METADATA_RE.match(lines[j])
        if mm:
            end = j + 1
            label, value = mm.group(1).strip(), mm.group(2).strip()
            value = value.rstrip(".,;")
            if "conda" in label.lower() and "anaconda.org" in value.lower():
                out["conda_url"] = value
            if ("home" in label.lower() or "github" in label.lower()) and "github.com" in value:
                for part in value.replace(",", " ").split():
                    if "github.com" in part:
                        gh = _parse_github_url(part)
                        if gh:
                            out["github_url"] = f"https://github.com/{gh[0]}/{gh[1]}"
                            break
    out["metadata_section_end"] = end
    return out


def _format_downloads(n: int | None) -> str:
    if n is None:
        return "N/A"
    if n >= 1_000_000:
        return f"{n / 1_000_000:.1f}M"
    if n >= 1_000:
        return f"{n / 1_000:.1f}K"
    return str(n)


def _parse_github_url(url: str) -> tuple[str, str] | None:
    if not url:
        return None
    url = url.strip().rstrip("/")
    m = GITHUB_REPO_RE.match(url)
    if m:
        return (m.group(1), m.group(2))
    return None


def fetch_conda_metadata(channel: str, package: str) -> dict | None:
    """Fetch package metadata from Anaconda API. Returns dict or None on failure."""
    url = ANACONDA_PACKAGE_API.format(channel=channel, package=package)
    with httpx.Client(timeout=30.0, headers={"User-Agent": USER_AGENT}) as client:
        try:
            r = client.get(url)
            if r.status_code != 200:
                return None
            return r.json()
        except Exception:
            return None


def fetch_github_stars(owner: str, repo: str) -> int | None:
    """Fetch GitHub repo stargazers_count. Returns None on failure or rate limit."""
    url = GITHUB_REPO_API.format(owner=owner, repo=repo)
    with httpx.Client(timeout=15.0, headers={"User-Agent": USER_AGENT}) as client:
        try:
            r = client.get(url)
            if r.status_code != 200:
                return None
            data = r.json()
            return data.get("stargazers_count")
        except Exception:
            return None


def collect_metadata(
    channel: str,
    package: str,
    report_conda_url: str | None = None,
    report_github_url: str | None = None,
) -> dict:
    """
    Collect conda and GitHub metadata for a single tool.
    If report_conda_url is set, use it and only fetch ndownloads/modified_at from API (channel/package parsed from URL).
    If report_github_url is set, use it and only fetch stars.
    Returns dict with: tool, channel, conda_url, conda_downloads, conda_last_updated, github_url, github_stars.
    """
    out = {
        "tool": package,
        "channel": channel,
        "conda_url": report_conda_url or CONDA_OVERVIEW_URL.format(channel=channel, package=package),
        "conda_downloads": None,
        "conda_last_updated": None,
        "github_url": report_github_url,
        "github_stars": None,
    }
    # If report had conda URL, normalize to overview and get channel/package for API
    if report_conda_url:
        cp = _parse_conda_channel_package(report_conda_url)
        if cp:
            channel, package = cp
            out["channel"] = channel
            out["conda_url"] = CONDA_OVERVIEW_URL.format(channel=channel, package=package)
    data = fetch_conda_metadata(channel, package)
    if data:
        out["conda_downloads"] = data.get("ndownloads")
        raw = data.get("modified_at")
        if raw:
            out["conda_last_updated"] = str(raw).split("T")[0] if "T" in str(raw) else str(raw).split()[0]
        if not out["github_url"]:
            for candidate in (
                data.get("dev_url"),
                data.get("home"),
                data.get("source_git_url"),
            ):
                candidate = (candidate or "").strip()
                gh = _parse_github_url(candidate) if candidate else None
                if gh:
                    owner, repo = gh
                    out["github_url"] = f"https://github.com/{owner}/{repo}"
                    out["github_stars"] = fetch_github_stars(owner, repo)
                    break
    if out["github_url"] and out["github_stars"] is None:
        gh = _parse_github_url(out["github_url"])
        if gh:
            out["github_stars"] = fetch_github_stars(gh[0], gh[1])
    return out


def _update_report_metadata(
    report_path: Path,
    parsed: dict,
    meta: dict,
) -> None:
    """
    Add or update Conda, Total Downloads, Last updated, GitHub, Stars in the report's Metadata section.
    parsed comes from _parse_report_metadata; meta from collect_metadata.
    """
    lines = parsed["lines"]
    start = parsed["metadata_section_start"]
    end = parsed["metadata_section_end"]
    if start < 0:
        return
    # Build new metadata entries to set
    dl = _format_downloads(meta.get("conda_downloads"))
    updated = meta.get("conda_last_updated") or "N/A"
    stars = meta.get("github_stars") if meta.get("github_stars") is not None else "N/A"
    github_display = meta.get("github_url") or "N/A"
    new_entries = {
        "Conda": meta.get("conda_url"),
        "Total Downloads": dl,
        "Last updated": updated,
        "GitHub": github_display,
        "Stars": str(stars),
    }
    # Keys to match in existing lines (label may be "Conda (r channel)" etc.)
    key_patterns = {
        "conda": ("Conda", new_entries["Conda"]),
        "total downloads": ("Total Downloads", new_entries["Total Downloads"]),
        "last updated": ("Last updated", new_entries["Last updated"]),
        "github": ("GitHub", new_entries["GitHub"]),
        "stars": ("Stars", new_entries["Stars"]),
    }
    seen_keys = set()
    new_lines = []
    for j in range(start + 1, min(end, len(lines))):
        line = lines[j]
        mm = REPORT_MD_METADATA_RE.match(line)
        if mm:
            label = mm.group(1).strip().lower()
            matched = False
            for k, (out_key, out_val) in key_patterns.items():
                if k in label and out_val:
                    seen_keys.add(out_key)
                    new_lines.append(f"- **{out_key}**: {out_val}")
                    matched = True
                    break
            if matched:
                continue
        new_lines.append(line)
    # Append any new keys we didn't update
    for out_key, out_val in [
        ("Conda", new_entries["Conda"]),
        ("Total Downloads", new_entries["Total Downloads"]),
        ("Last updated", new_entries["Last updated"]),
        ("GitHub", new_entries["GitHub"]),
        ("Stars", new_entries["Stars"]),
    ]:
        if out_key not in seen_keys and out_val:
            new_lines.append(f"- **{out_key}**: {out_val}")
    new_content = "\n".join(lines[: start + 1] + new_lines + lines[end:])
    report_path.write_text(new_content + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Collect conda and GitHub metadata for tools"
    )
    parser.add_argument(
        "tools",
        nargs="*",
        help="Tool names (e.g. macs3)",
    )
    parser.add_argument(
        "--channel",
        metavar="CHANNEL",
        help="Conda channel (default: bioconda; r-packages like r-tidyr use channel 'r' when not set)",
    )
    parser.add_argument(
        "--from-file",
        metavar="FILE",
        help="Read tool names from file (one per line)",
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Output JSON lines (one dict per tool)",
    )
    parser.add_argument(
        "--workspace",
        metavar="DIR",
        default=".",
        help="Root directory containing tool dirs (default: current dir); used to find <tool>/report.md",
    )
    parser.add_argument(
        "--no-update-report",
        action="store_true",
        help="Do not write collected data into report.md metadata",
    )
    args = parser.parse_args()
    tools: list[str] = list(args.tools)
    workspace = Path(args.workspace).resolve()
    if args.from_file:
        path = Path(args.from_file)
        if not path.exists():
            print(f"Error: file not found: {path}", file=sys.stderr)
            return 1
        for line in path.read_text(encoding="utf-8").splitlines():
            t = line.strip().split("#")[0].strip()
            if t:
                tools.append(t)
    if not tools:
        parser.print_help()
        return 0
    for tool in tools:
        tool = tool.strip()
        if not tool:
            continue
        channel = (args.channel or (R_CHANNEL if tool.startswith("r-") else DEFAULT_CHANNEL)).strip()
        report_path = workspace / tool / "report.md"
        parsed = _parse_report_metadata(report_path)
        report_conda = parsed.get("conda_url")
        report_github = parsed.get("github_url")
        meta = collect_metadata(
            channel,
            tool,
            report_conda_url=report_conda,
            report_github_url=report_github,
        )
        if not args.no_update_report and report_path.exists() and parsed["metadata_section_start"] >= 0:
            _update_report_metadata(report_path, parsed, meta)
        if args.json:
            import json
            print(json.dumps(meta))
        else:
            dl = _format_downloads(meta["conda_downloads"])
            updated = meta.get("conda_last_updated") or "N/A"
            print(f"tool: {meta['tool']}")
            print(f"  conda: {meta['conda_url']}  Total Downloads: {dl}  Last updated: {updated}")
            if meta["github_url"]:
                stars = meta["github_stars"] if meta["github_stars"] is not None else "N/A"
                print(f"  github: {meta['github_url']}  Stars: {stars}")
            else:
                print(f"  github: N/A")
            print()
    return 0


if __name__ == "__main__":
    sys.exit(main())
