# Bibliography

These files are for your Thesis' references.

For Bachelor's and Master's theses, you only need to work with one file:
* `references.bib` -- contains all your bibtex references

For PhD theses, there are two additional bibliography files:
* `publications.bib` -- contains author publications for PhD theses
* `supervisions.bib` -- contains supervised student theses (for PhD theses)

If you add further bibliography files, don't forget to include them via `\addbibresource{...}` in [Thesis.tex](../Thesis.tex) :)

## Customizing Bibliographies

The main bibliography printed after the conclusion is configured in [Bibliography.tex](../04-back-matter/Bibliography.tex).
For PhD theses, the additional bibliographies are in [Publications.tex](../02-front-matter/Publications.tex) and [Teaching.tex](../02-front-matter/Teaching.tex).
You can add labels to each bibtex entry to help with filtering and sorting, as well as add custom information into the bibliography.

### Shorthand
Give an bibtex entry a shorthand to customize the label of its citations. It can be handy to label the papers that are part of your cumulative dissertation [A], [B], [C], ... or label other publications with your initials and an index: [CM-1], [CM-2], ...

```bibtex
@mastersthesis{Potter1997,
  author = {Potter, Harry},
  title = {Harry Potter and the Philosopher's Stone},
  year = {1997},
  month = {4},
  type = {Master's Thesis},
  note = {},
  keywords = {supervisedthesis},
  shorthand = {BSC-1},
}
```
Setting shorthands for the student theses you supervised gives the bibliography a cleaner look. Additionally, you can use shorthands to customize the order in which the bibliography is printed, see also `\DeclareSortingTemplate{snyt}` in [classicthesis-config.tex](../classicthesis-config.tex).

### Addendum
The `addendum` will be printed at the end of the reference. This can be handy for different reasons, e.g., indicating that the venue was ranked "CORE-A", the journal's impact factor "Impact Factor 4.2", or that the paper was awarded "Best Paper award."

```bibtex
@INPROCEEDINGS{moonshine2025extraordinary,
  author = {Moonshine, Cecilia and Coauthor, Talented and Hollick, Matthias},
  title = {{Another Extraordinary Work That Is The Centerpiece of My Dissertation}},
  booktitle = {Proceedings of the 2025 CHI Conference on Human Factors in Computing Systems},
  year = {2025},
  pages = {1--22},
  address = {New York, NY, USA},
  publisher = {Association for Computing Machinery},
  doi = {10.2020/202020202.2020202},
  keywords = {mypublication,partofthesis},
  shorthand = {B},
  addendum = {\textcolor{halfgray}{CORE Rank A*}},
}
```
"Core RANK A*" will be printed at the end of this reference in gray. There are some predefined colors in [classicthesis.sty](../classicthesis.sty), e.g., `halfgray`, `webgreen`, and  `webbrown`.

### Keywords
Use `keywords` to enable filtering of your bibliographies.

```bibtex
@ARTICLE{moonshine2020src,
  author = {Moonshine, Cecilia and Guy, Other and Hollick, Matthias},
  title={{One More For The List}}, 
  journal={IEEE Access}, 
  year={2024},
  volume={12},
  number={},
  pages={155666-155695},
  month = {},
  note = {},
  doi={10.1109/ACCESS.2024.3480275},
  keywords = {mypublication,journalarticle},
  shorthand = {CM-2},
}
```
Adding keywords can help you filter the references for each bibliography. Some ideas on keywords and how to use them:

* `partofthesis` -- for all publications that are part of your cumulative thesis. Simplifies filtering for the "Publications that are Part of this Thesis" bibliography with `keyword=partofthesis`
* `mypublication` -- for all publications with your name on the author list. Simplifies filtering fo the "My other publications" bibliography with `keyword=mypublication,notkeyword=partofthesis`.
* `supervisedthesis` -- for all theses you supervised. Simplifies filtering of the "Supervised Bachelor's and Master's Theses" bibliography wth `keyword=supervisedthesis`.
* `conferenceproceedings`, `journalarticle`, `posterdemo`, `extendedabstract` -- if you want to create separate bibliographies per article type.
* `underreview` -- if you want to have a separate bibliography for publications currently under review with `keyword=underreview`and want to exclude them from the other bibliographies with `notkeyword=underreview`.

## Further Reference
If you are seeking customization beyond what is explained above, take a look into the [BibLaTeX](https://ctan.org/pkg/biblatex) package documentation.
