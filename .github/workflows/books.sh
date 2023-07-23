#!/bin/bash
echo "Making ebooks ..."

sudo apt-get install pandoc

pandoc -o downloads/typescript-book.epub --metadata title="The Concise TypeScript Book" --metadata author="Simone Poggiali"  -s README.md
pandoc -o downloads/typescript-book-zh_CN.epub --metadata title="# 简洁的TypeScript之书" --metadata author="Simone Poggiali"  -s README-zh_CN.md

git config user.name "GitHub Actions Bot"
git config user.email "<>"

git add -A
git commit -m 'Automatically add books'
git push