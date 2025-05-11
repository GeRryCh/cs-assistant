# Technology Context

This section outlines the technologies, dependencies, and development setup for CS Assistant.

## Languages and Runtime
- Python 3.8+  
- Uses standard library modules: `argparse`, `json`, `pathlib`, `re`, `dataclasses`, `typing`

## Dependencies
- LLM Providers
  - `openai` (OpenAI Python SDK)  
  - `google-generativeai` (Google Gemini client)  
  - `anthropic` (Anthropic Claude client)  
- Environment and Configuration  
  - `python-dotenv` for loading `.csarc` file  
- Testing  
  - `pytest` for unit tests  

## Configuration Patterns
- JSON Schema (`config.schema.json`) enforces shape of `config.json`  
- `Config` dataclasses enable strongly-typed, immutable configuration  
- Two config instantiation paths:
  1. `Config.from_json` parses and validates JSON file  
  2. `Config.from_args` builds from CLI flags

## Project Structure
```
/
├── src/
│   ├── main.py           # CLI entry point
│   ├── config.py         # Dataclass definitions and JSON parsing
│   ├── llm_config.py     # Model provider enum and helpers
│   ├── api_clients.py    # Wrappers for each LLM API
│   ├── solve.py          # Core IssueSolver implementation
│   ├── spinner.py        # Console spinner utility
│   └── constants.py      # ANSI color codes and other constants
├── tests/
│   └── test_api_clients.py  # Unit tests for API client wrappers
├── config.schema.json    # JSON schema for user config
├── pyproject.toml        # Build and packaging configuration
├── requirements.txt      # Runtime dependencies
└── cs-assistant-output/  # Generated solutions (read-only)
```

## Development Setup
1. Clone repository  
2. Create virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Run tests:
   ```bash
   pytest
