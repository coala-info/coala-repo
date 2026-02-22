#!/usr/bin/env bash
# Generate CWL for each tool in 100.txt; skip tools that already have .cwl files in their folder.
# Failures in generate/skill/regenerate do not stop the loop.
# Usage: ./scripts/generate-skip-existing.sh [file_list=100.txt]

list="${1:-100.txt}"

while IFS= read -r i || [[ -n "$i" ]]; do
  i=$(echo "$i" | tr -d '\r\n')
  [[ -z "$i" ]] && continue

  if [[ -d "$i" ]] && ls "$i"/*.cwl 1>/dev/null 2>&1; then
    echo "[skip] $i (already has .cwl)"
    continue
  fi

  echo "[run] $i"
  cwlagent generate "$i" --singularity || echo "[warn] $i: generate failed"
  skip_skill=
  if [[ -f "$i/skills/SKILL.md" ]]; then
    skip_skill="skills/SKILL.md exists"
  elif [[ -f "$i/report.md" ]] && grep -qE 'Validation.*FAIL|generation failed' "$i/report.md" 2>/dev/null; then
    skip_skill="generation failed (Validation FAIL)"
  fi
  if [[ -n "$skip_skill" ]]; then
    echo "[skip] $i skill/regenerate ($skip_skill)"
  else
    cwlagent skill "$i" || echo "[warn] $i: skill failed"
    cwlagent regenerate "$i" --singularity || echo "[warn] $i: regenerate failed"
  fi
  # Remove this tool's Docker image from report.md if present
  report="$i/report.md"
  if [[ -f "$report" ]]; then
    img=$(grep -m1 '\*\*Docker Image\*\*:' "$report" 2>/dev/null | sed 's/^.*\*\*Docker Image\*\*: *//;s/[[:space:]]*$//')
    if [[ -n "$img" ]]; then
      if docker rmi "$img" 2>/dev/null; then
        echo "[rmi] removed $img"
      else
        echo "[rmi] skip $img (in use or not found)"
      fi
    fi
  fi
done < "$list"
