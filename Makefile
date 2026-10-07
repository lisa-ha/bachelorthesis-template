# ------------------------------------------------------------------------------
# latexmk configuration for local (interactive) and CI (non-interactive) runs
# ------------------------------------------------------------------------------

DOCUMENT := Thesis
LATEXMK := latexmk
LATEXMK_CI := latexmk -interaction=nonstopmode

# ------------------------------------------------------------------------------
# Main targets for building the main document
# ------------------------------------------------------------------------------

.PHONY: all document ci-document clean

all: document

document:
	@echo "Build document (interactive)"
	$(LATEXMK) $(DOCUMENT)

ci-document: setup-git-hooks
	@echo "Build document (CI mode)"
	$(LATEXMK_CI) $(DOCUMENT)

clean:
	@echo "Clean up"
	$(LATEXMK) -C $(DOCUMENT)

# ------------------------------------------------------------------------------
# Helper targets (not needed to build the main document)
# ------------------------------------------------------------------------------

.PHONY: sort-acronyms setup-git-hooks

sort-acronyms:
	sort 00-definitions/Acronyms.tex -o 00-definitions/Acronyms.tex

# setup git hooks and generate the initial .git/gitHeadInfo.gin file
setup-git-hooks:
	git config core.hooksPath .githooks
	.githooks/post-checkout

# ------------------------------------------------------------------------------
# Special targets to test certain variants of the template
# ------------------------------------------------------------------------------
.PHONY: test-default test-tight test-phd-draft-balanced

# master's thesis, no drafting, standard layout
test-default:
	$(LATEXMK) -g \
	-usepretex="\def\injectCToptions{\PassOptionsToPackage{drafting=false}{classicthesis}} \
	\def\injectCTSoptions{\PassOptionsToPackage{layout=standard}{classicthesis-seemoo}}" \
	$(DOCUMENT)

# master's thesis, no drafting, tight layout
test-tight:
	$(LATEXMK) -g \
	-usepretex="\def\injectCToptions{\PassOptionsToPackage{drafting=false}{classicthesis}} \
	\def\injectCTSoptions{\PassOptionsToPackage{layout=tight}{classicthesis-seemoo}}" \
	$(DOCUMENT)

# phd, drafting, balanced layout
test-phd-draft-balanced:
	$(LATEXMK) -g \
	-usepretex="\def\injectCToptions{\PassOptionsToPackage{drafting=true}{classicthesis}} \
	\def\injectCTSoptions{\PassOptionsToPackage{phd,layout=balanced}{classicthesis-seemoo}}" \
	$(DOCUMENT)
