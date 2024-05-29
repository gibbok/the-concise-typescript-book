#!/bin/bash
DIR_DOWNLOADS="downloads"

INPUT_EN="README"
INPUT_CN="README-zh_CN"

OUTPUT_EN="typescript-book"
OUTPUT_CN="typescript-book-zh_CN"

AUTHOR="Simone Poggiali"
TITLE_EN="The Concise TypeScript Book"
TITLE_CN="# 简洁的TypeScript之书"

cd ../

echo "Making ebooks ..."

# Check dependencies
if command -v pandoc &>/dev/null; then
    echo "pandoc is installed"
else
    echo "You need to install pandoc. Please visit: https://pandoc.org/installing.html"
    exit 1
fi
if command -v epubcheck &>/dev/null; then
    echo "epubcheck is installed"
else
    echo "You need to install epubcheck. Please visit: https://www.w3.org/publishing/epubcheck/docs/installation/"
    exit 1
fi

# Generate eBooks
pandoc -o $DIR_DOWNLOADS/$OUTPUT_EN.epub --metadata title="$TITLE_EN" --metadata author="$AUTHOR" -s $INPUT_EN.md
pandoc -o $DIR_DOWNLOADS/$OUTPUT_CN.epub --metadata title="$TITLE_CN" --metadata author="$AUTHOR" -s $INPUT_CN.md

# Validate eBooks
epubcheck $DIR_DOWNLOADS/$OUTPUT_CN.epub
epubcheck $DIR_DOWNLOADS/$OUTPUT_CN.epub

cd ./tools || exit

# Generate PDFs 
npm run make-pdf --source=$INPUT_EN --destination=$OUTPUT_EN
npm run make-pdf --source=$INPUT_CN --destination=$OUTPUT_CN

echo "Books were created. Please commit!"