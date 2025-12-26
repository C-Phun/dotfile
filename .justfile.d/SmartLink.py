#!/usr/bin/env -S python

import os
import shutil
import sys
import json
import tomllib
import yaml
from pathlib import Path


def SmartLink(source: str, target_dir: str | None, rename: str | None):
  """Custom Symlink

  Args:
      source: Symlink target.
      target_dir: Symlink location. Defaults to $HOME
      rename: Symlink's name, defaults to basename of source.
  """

  source_path = Path(source).expanduser().resolve()
  if not target_dir:
    target_dir_path = Path.home()
  else:
    expanded = os.path.expandvars(target_dir)
    if expanded == target_dir and "$" in target_dir:
      print(
        f"\033[38;2;255;80;0mError\033[0m: environment variable in '{target_dir}' is not defined"
      )
      sys.exit(1)
    target_dir_path = Path(expanded).expanduser().resolve()

  # if rename == "":
  #   link_path = target_dir_path
  # else:
  link_name = rename if rename else source_path.name
  link_path = target_dir_path / link_name

  link_path.parent.mkdir(parents=True, exist_ok=True)

  if link_path.exists() or link_path.is_symlink():
    if link_path.is_dir() and not link_path.is_symlink():
      shutil.rmtree(link_path)
    else:
      link_path.unlink()

  link_path.symlink_to(source_path)
  print(f"{link_path} -> {source_path}")


def load_config(path: Path):
  ext = path.suffix.lower()

  if ext in (".json", ".jsonc"):
    return json.loads(path.read_text())

  if ext == ".toml":
    if not tomllib:
      print("Error: TOML requires Python 3.11 or newer")
      sys.exit(1)
    return tomllib.loads(path.read_text())

  if ext in (".yaml", ".yml"):
    if not yaml:
      print("Error: YAML requires PyYAML (`pip install pyyaml`)")
      sys.exit(1)
    return yaml.safe_load(path.read_text())

  print(f"Error: Unsupported file type: {ext}")
  sys.exit(1)


def main():
  if len(sys.argv) != 2:
    print(f"Usage: ./{sys.argv[0]} <config.(toml|yaml|json|csv)>")
    sys.exit(1)

  config_path = Path(sys.argv[1]).expanduser().resolve()
  if not config_path.exists():
    print(f"Error: config file '{config_path}' not found")
    sys.exit(1)

  data = load_config(config_path)

  links = data.get("links")
  if not isinstance(links, list):
    print("Error: Config file must contain a top-level 'links' list")
    sys.exit(1)

  for entry in links:
    SmartLink(
      entry.get("source"),
      entry.get("target_dir"),
      entry.get("rename"),
    )


if __name__ == "__main__":
  main()
