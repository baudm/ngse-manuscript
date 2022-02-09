Thesis manuscript template for the National Graduate School of Engineering (NGSE), UP Diliman.
# Features
- Loosely based on the [NGSE manuscript template](https://coe.upd.edu.ph/forms/).
- Form and structure follows the guide created by [Dr. Rowel Atienza](https://github.com/roatienza/). The outlines for each chapter were directly lifted from his guide.
- Easily switch between proposal/final and review/camera-ready versions (see lines 3-5 of `main.tex`).
- Proposal version uses A4 paper, while final version uses letter.
- Review version enables colored links and line numbers.
- Defined macros for common abbreviations such as `\eg` for *e.g.*, `\etal` for *et al.* and so on (adapted from the CVPR 2022 template).
- Uses `biblatex` for the bibliography. Sorted `ieee` style is used by default.

# Usage
1. Edit `metadata.tex` and put your details (name, student number, etc.)
2. Edit `main.tex` to add/remove chapters, appendices, packages, or switch between the camera-ready/review and proposal/final versions of the manuscript.
3. Add BibTeX references to `references.bib`.
4. Add/edit/remove chapters in the `chapters` directory.

**NOTE:** `chapters/4-methodology.tex` contains important information regarding style and formatting (e.g. cross-references, abbreviations) that were adapted from the CVPR 2022 template.
