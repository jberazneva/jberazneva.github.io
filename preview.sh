#!/usr/bin/env bash
# Local preview for juliaberazneva.com redesign.
#
# Instead of copying content-source/ into site/ (which is what the GitHub
# Action does on CI), this script symlinks the YAML files and bio.md into
# site/_data/ and site/_includes/ — so when you edit a file in content-source/,
# Jekyll's file watcher sees the change via the symlink and live-reloads
# http://localhost:4000 in your browser. Edit in content-source/, see it live.
#
# Usage:
#   ./preview.sh           # sync + serve with live-reload (default)
#   ./preview.sh build     # one-shot build, no server
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "==> Linking content-source/ -> site/_data/ and site/_includes/"
mkdir -p site/_data site/_includes site/assets/files

# Wipe any stale files/links, then symlink each YAML and bio.md.
rm -f site/_data/*.yml site/_includes/bio.md
for f in content-source/*.yml; do
  ln -s "../../$f" "site/_data/$(basename "$f")"
done
ln -s "../../content-source/bio.md" "site/_includes/bio.md"

# Copy the newest CV PDF into the site as cv.pdf.
latest_cv=$(ls -t reference/Berazneva_CV-*.pdf 2>/dev/null | head -n 1 || true)
if [ -n "$latest_cv" ]; then
  cp "$latest_cv" site/assets/files/cv.pdf
  echo "    CV: $(basename "$latest_cv") -> site/assets/files/cv.pdf"
fi

# Toolchain: brew Ruby + macOS C++ SDK for eventmachine.
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export SDKROOT="$(xcrun --show-sdk-path)"
export CPLUS_INCLUDE_PATH="$SDKROOT/usr/include/c++/v1"

cd site
if [ "${1:-serve}" = "build" ]; then
  echo "==> Building site (one-shot)"
  bundle exec jekyll build
else
  echo "==> Starting jekyll serve at http://localhost:4000 (Ctrl-C to stop)"
  bundle exec jekyll serve --livereload
fi
