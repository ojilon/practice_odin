#!/usr/bin/env python3
"""Verify dojo scaffold completeness (structure only, no Odin execution).

Usage: python tools/verify_dojo.py
Checks: every NN_* folder under phase_*/ has 00_GUIDE.md, 01_EXERCISES.md,
02_QUESTIONS.md; reports missing pieces and PROGRESS.md checkbox coverage.
"""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent.parent
REQUIRED = ["00_GUIDE.md", "01_EXERCISES.md", "02_QUESTIONS.md"]

def main() -> int:
    problems = 0
    phases = sorted(p for p in ROOT.iterdir() if p.is_dir() and p.name.startswith("phase_"))
    if not phases:
        print("no phase_* directories found")
        return 1
    for phase in phases:
        subs = sorted(p for p in phase.iterdir() if p.is_dir())
        if not subs:
            print(f"WARN {phase.name}: no exercise folders yet")
            continue
        for sub in subs:
            missing = [f for f in REQUIRED if not (sub / f).exists()]
            if missing:
                print(f"MISSING {phase.name}/{sub.name}: {', '.join(missing)}")
                problems += 1
            # quick check: GUIDE should state Done-when, EXERCISES must-have
            guide = sub / "00_GUIDE.md"
            if guide.exists():
                text = guide.read_text(encoding="utf-8", errors="replace")
                if "Done when" not in text:
                    print(f"WARN {phase.name}/{sub.name}: GUIDE lacks 'Done when'")
    # progress file sanity
    prog = ROOT / "PROGRESS.md"
    if prog.exists():
        boxes = len(re.findall(r"- \[ \]", prog.read_text(encoding="utf-8", errors="replace")))
        print(f"PROGRESS.md open checkboxes: {boxes}")
    print("OK - all folders complete" if problems == 0 else f"FAIL - {problems} folder(s) incomplete")
    return 0 if problems == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
