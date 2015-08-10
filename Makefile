SHELL := /bin/bash

all: standard_rc ~/.standardrc ~/.standard_aliases/aliases doc/FUNCTION_DESCRIPTIONS.md doc/SHORTER_FUNCTION_DESCRIPTIONS.md

standard_rc: standard_functions scripts/update-rc.py scripts/util.py scripts/const.py scripts/resources/rc-options-comment
	temp=$(shell tempfile); \
	./scripts/update-rc.py > "$$temp"; \
	cp "$$temp" standard_rc

~/.standardrc: standard_functions standard_rc scripts/update-rc.py scripts/util.py scripts/const.py scripts/resources/rc-options-comment
	temp=$(shell tempfile); \
	./scripts/update-rc.py --user > "$$temp"; \
	cp "$$temp" ~/.standardrc

~/.standard_aliases/aliases: standard_functions ~/.standardrc scripts/generate-aliases scripts/parse-rc.py scripts/util.py scripts/const.py
	./scripts/generate-aliases > ~/.standard_aliases/aliases

doc/FUNCTION_DESCRIPTIONS.md: standard_rc standard_functions scripts/generate-table-of-functions.py scripts/util.py scripts/const.py
	./scripts/generate-table-of-functions.py > doc/FUNCTION_DESCRIPTIONS.md

doc/SHORTER_FUNCTION_DESCRIPTIONS.md: standard_rc standard_functions scripts/generate-table-of-functions.py scripts/util.py scripts/const.py doc/interesting-functions
	./scripts/generate-table-of-functions.py --readme > doc/SHORTER_FUNCTION_DESCRIPTIONS.md
