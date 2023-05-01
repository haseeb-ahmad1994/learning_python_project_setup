format-black:
	@black .

format-isort:
	@isort .

lint-black:
	@black . --check

lint-isort:
	@isort . --check

lint-flake8:
	@flake8 .

lint-mypy:
	@mypy ./src

lint-mypy-report:
	@mypy ./src --html-report ./mypy_html

lint-mypy:
	@mypy .

format: format-black format-isort

lint: lint-black lint-isort lint-flake8 lint-mypy

unit-tests:
	@pytest
unit-tests-cov:
	@pytest --cov=src --cov-report term-missing --cov-report=html
unit-tests-cov-fail:
	@pytest --cov=src --cov-report term-missing --cov-report=html --cov-fail-under=80 --junitxml=pytest.xml | tee pytest-coverage.txt
clean-cov:
	@rm -rf .coverage
	@rm -rf htmlcov
	@rm -rf pytest.xml
	@rm -rf pytest-coverage.txt
##@ Documentation
docs-build: ## build documentation locally
	@mkdocs build
docs-deploy: ## build & deploy documentation to "gh-pages" branch
	@mkdocs gh-deploy -m "docs: update documentation" -v --force
clean-docs: ## remove output files from mkdocs
	@rm -rf site