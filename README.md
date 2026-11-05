# test-ci-cd

Простой репозиторий на Python с CI/CD через GitHub Actions.

## Структура проекта

```
test-ci-cd/
├── .gitignore
├── LICENSE
├── README.md
├── pyproject.toml
├── src/
│   └── myapp/
│       ├── __init__.py
│       └── app.py
├── tests/
│   ├── __init__.py
│   └── test_app.py
├── src/migrations/
│   ├── env.py
│   ├── script.py.mako
│   └── versions/
│       └── 0001_initial.py
└── .github/
    ├── workflows/
    │   ├── ci.yml
    │   └── release.yml
    └── scripts/
        └── notify-telegram.sh
```

## Установка

```bash
# Клонирование репозитория
git clone https://github.com/finstape/test-ci-cd.git
cd test-ci-cd

# Создание и активация виртуального окружения
python -m venv .venv
source .venv/bin/activate   # Linux / macOS
# .venv\Scripts\activate    # Windows

# Установка зависимостей
pip install -e ".[dev]"
```

## Использование

```bash
python -m src.myapp
```

Или:

```python
from src.myapp.app import greet

print(greet("World"))
```

## Тесты

```bash
pytest
```

## Миграции базы данных

Проект использует **Alembic** для управления миграциями базы данных SQLite.

Запуск миграций:
```bash
# Установка зависимостей
pip install alembic sqlalchemy

# Применение миграций
PYTHONPATH=src alembic upgrade head

# Создание новой миграции
PYTHONPATH=src alembic revision --autogenerate -m "description"
```

## Линтер

```bash
ruff check src/ tests/
ruff format --check src/ tests/
```

## CI/CD

Каждый коммит запускает пайплайн CI:

1. **build** — сборка пакета.
2. **lint** — проверка кода через `ruff`.
3. **test** — прогон тестов через `pytest`.
4. **security** — сканирование безопасности (`bandit` + `pip-audit`).
5. **db-migrate** — применение миграций базы данных через `alembic upgrade head`.
6. **notify** — уведомление в Telegram о статусе пайплайна.

При пуше тега вида `v*` автоматически создаётся релиз на GitHub с changelog и прикреплённым артефактом сборки.

## Лицензия

MIT License.
